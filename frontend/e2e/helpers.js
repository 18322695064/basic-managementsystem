import Redis from 'ioredis'

const REDIS_CONFIG = {
  host: '192.168.1.204',
  port: 6379,
  password: 'Admin123',
  db: 6,
  connectTimeout: 5000,
  lazyConnect: true
}

export async function loginViaApi(page) {
  const redis = new Redis(REDIS_CONFIG)

  await page.goto('http://localhost:3000', { waitUntil: 'domcontentloaded' })
  await page.waitForTimeout(500)

  const captchaRes = await page.request.get('http://localhost:8080/api/auth/captchaImage')
  const captchaData = await captchaRes.json()
  const uuid = captchaData.data.uuid

  const captchaCode = await redis.get(`captcha:${uuid}`)
  redis.disconnect()

  if (!captchaCode) {
    throw new Error('Failed to get captcha code from Redis')
  }

  const cleanCode = captchaCode.replace(/^"(.*)"$/, '$1')

  const loginRes = await page.request.post('http://localhost:8080/api/auth/login', {
    data: {
      username: 'admin',
      password: 'superAdmin@088',
      code: cleanCode,
      uuid: uuid
    }
  })

  const loginData = await loginRes.json()
  if (loginData.code !== 200 || !loginData.data?.token) {
    throw new Error(`Login failed: ${loginData.msg || JSON.stringify(loginData)}`)
  }

  await page.evaluate((token) => {
    localStorage.setItem('Admin-Token', token)
  }, loginData.data.token)

  return loginData.data.token
}

export async function ensureLoggedIn(page) {
  await page.goto('http://localhost:3000', { waitUntil: 'domcontentloaded' })
  await page.waitForTimeout(1000)

  if (page.url().includes('/login')) {
    try {
      await loginViaApi(page)
      await page.goto('http://localhost:3000', { waitUntil: 'networkidle' })
      await page.waitForTimeout(2000)
    } catch (e) {
      console.error('Auto-login failed:', e.message)
    }
  }
}
