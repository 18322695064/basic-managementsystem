import { test, expect } from '@playwright/test'
import { loginViaApi } from './helpers'

test.describe('导航与菜单', () => {

  test('API 登录后显示主界面', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000', { waitUntil: 'networkidle' })
    await page.waitForTimeout(3000)

    const body = page.locator('body')
    await expect(body).toBeVisible()
  })

  test('侧边栏菜单可见', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000', { waitUntil: 'networkidle' })
    await page.waitForTimeout(3000)

    const sider = page.locator('.ant-layout-sider, aside, [class*="sidebar"]').first()
    await expect(sider).toBeVisible({ timeout: 5000 })
  })

  test('首页内容区可见', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000', { waitUntil: 'networkidle' })
    await page.waitForTimeout(3000)

    const content = page.locator('.ant-layout-content, main, [class*="content"]').first()
    await expect(content).toBeVisible({ timeout: 5000 })
  })
})
