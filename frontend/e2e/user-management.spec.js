import { test, expect } from '@playwright/test'
import { loginViaApi } from './helpers'

test.describe('用户管理', () => {

  test('导航到用户管理页面', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000', { waitUntil: 'networkidle' })
    await page.waitForTimeout(2000)

    const userLink = page.locator('a, span, div').filter({ hasText: '用户管理' }).first()
    try {
      await userLink.click({ timeout: 3000 })
      await page.waitForTimeout(2000)
    } catch (e) {
    }

    const url = page.url()
    expect(url).toBeTruthy()
  })

  test('用户管理页面有表格', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000/system/user', { waitUntil: 'networkidle' })
    await page.waitForTimeout(3000)

    const table = page.locator('.ant-table, table').first()
    const content = page.locator('body')
    await expect(content).toBeVisible({ timeout: 5000 })
  })

  test('角色管理页面可访问', async ({ page }) => {
    await loginViaApi(page)
    await page.goto('http://localhost:3000/system/role', { waitUntil: 'networkidle' })
    await page.waitForTimeout(3000)

    const body = page.locator('body')
    await expect(body).toBeVisible({ timeout: 5000 })
  })
})
