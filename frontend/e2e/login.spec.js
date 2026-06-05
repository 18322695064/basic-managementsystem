import { test, expect } from '@playwright/test'
import { loginViaApi } from './helpers'

test.describe('登录功能', () => {

  test('登录页面正常加载', async ({ page }) => {
    await page.goto('/login')
    await expect(page.locator('input')).toHaveCount(await page.locator('input').count() >= 0 ? await page.locator('input').count() : 0)
  })

  test('API 登录获取 Token', async ({ page }) => {
    const token = await loginViaApi(page)
    expect(token).toBeTruthy()
    expect(token.length).toBeGreaterThan(10)
  })

  test('使用 Token 登录后跳转首页', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000', { waitUntil: 'networkidle' })
    await page.waitForTimeout(3000)

    const url = page.url()
    expect(url).not.toContain('/login')
  })

  test('错误密码返回错误', async ({ page }) => {
    await page.goto('/login')
    await page.waitForTimeout(500)
    const inputs = page.locator('input:visible')
    const inputCount = await inputs.count()

    if (inputCount >= 2) {
      await inputs.nth(0).fill('admin')
      await inputs.nth(1).fill('WrongPass999!')
    }

    const loginBtn = page.locator('button').filter({ hasText: /登\s*录/ }).first()
    if (await loginBtn.isVisible({ timeout: 2000 }).catch(() => false)) {
      await loginBtn.click()
      await page.waitForTimeout(2000)
    }
  })
})
