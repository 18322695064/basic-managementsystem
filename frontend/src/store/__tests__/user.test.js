import { describe, it, expect, beforeEach, vi } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'
import { useUserStore } from '../modules/user'

vi.mock('@/api/auth', () => ({
  login: vi.fn(),
  getInfo: vi.fn(),
  logout: vi.fn()
}))

vi.mock('@/utils/auth', () => ({
  getToken: vi.fn(() => null),
  setToken: vi.fn(),
  removeToken: vi.fn()
}))

import { login, getInfo, logout } from '@/api/auth'
import { setToken, removeToken, getToken } from '@/utils/auth'

describe('user store', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
    vi.clearAllMocks()
    localStorage.clear()
  })

  describe('state', () => {
    it('should initialize with null token when no token in storage', () => {
      getToken.mockReturnValue(null)
      const store = useUserStore()
      expect(store.token).toBeNull()
      expect(store.roles).toEqual([])
      expect(store.permissions).toEqual([])
    })

    it('should initialize with token from storage', () => {
      getToken.mockReturnValue('existing-token')
      const store = useUserStore()
      expect(store.token).toBe('existing-token')
    })
  })

  describe('login', () => {
    it('should login and set token', async () => {
      const mockResponse = { data: { token: 'jwt-token-123' } }
      login.mockResolvedValue(mockResponse)

      const store = useUserStore()
      const result = await store.login({
        username: 'admin',
        password: 'pass123',
        code: 'ABCD',
        uuid: 'uuid-1'
      })

      expect(login).toHaveBeenCalledWith({
        username: 'admin',
        password: 'pass123',
        code: 'ABCD',
        uuid: 'uuid-1'
      })
      expect(setToken).toHaveBeenCalledWith('jwt-token-123')
      expect(store.token).toBe('jwt-token-123')
      expect(result).toEqual(mockResponse)
    })
  })

  describe('getInfo', () => {
    it('should fetch and store user info', async () => {
      const mockResponse = {
        data: {
          user: { id: 'u-1', accountNumber: 'admin', nickName: '管理员' },
          roles: ['admin'],
          permissions: ['*:*:*']
        }
      }
      getInfo.mockResolvedValue(mockResponse)

      const store = useUserStore()
      await store.getInfo()

      expect(store.id).toBe('u-1')
      expect(store.username).toBe('admin')
      expect(store.nickname).toBe('管理员')
      expect(store.roles).toEqual(['admin'])
      expect(store.permissions).toEqual(['*:*:*'])
    })
  })

  describe('logout', () => {
    it('should logout and clear state', async () => {
      logout.mockResolvedValue({})

      const store = useUserStore()
      store.token = 'some-token'
      store.roles = ['admin']
      store.permissions = ['*:*:*']

      await store.logout()

      expect(store.token).toBe('')
      expect(store.roles).toEqual([])
      expect(store.permissions).toEqual([])
      expect(removeToken).toHaveBeenCalled()
    })

    it('should clear state even if API call fails', async () => {
      logout.mockImplementation(() => Promise.reject(new Error('Network error')))

      const store = useUserStore()
      store.token = 'some-token'

      try {
        await store.logout()
      } catch (e) {
        // expected - try/finally re-throws the error
      }

      expect(store.token).toBe('')
      expect(removeToken).toHaveBeenCalled()
    })
  })

  describe('resetToken', () => {
    it('should reset token and roles', () => {
      const store = useUserStore()
      store.token = 'some-token'
      store.roles = ['admin']

      store.resetToken()

      expect(store.token).toBe('')
      expect(store.roles).toEqual([])
      expect(removeToken).toHaveBeenCalled()
    })
  })
})
