import { describe, it, expect, beforeEach } from 'vitest'
import { getToken, setToken, removeToken } from '../auth'

describe('auth utils', () => {
  beforeEach(() => {
    localStorage.clear()
  })

  describe('setToken', () => {
    it('should store token in localStorage', () => {
      setToken('test-token-123')
      expect(localStorage.getItem('Admin-Token')).toBe('test-token-123')
    })

    it('should overwrite existing token', () => {
      localStorage.setItem('Admin-Token', 'old-token')
      setToken('new-token')
      expect(localStorage.getItem('Admin-Token')).toBe('new-token')
    })
  })

  describe('getToken', () => {
    it('should return token from localStorage', () => {
      localStorage.setItem('Admin-Token', 'my-token')
      expect(getToken()).toBe('my-token')
    })

    it('should return null when no token exists', () => {
      expect(getToken()).toBeNull()
    })
  })

  describe('removeToken', () => {
    it('should remove token from localStorage', () => {
      localStorage.setItem('Admin-Token', 'my-token')
      removeToken()
      expect(localStorage.getItem('Admin-Token')).toBeNull()
    })

    it('should not throw when token does not exist', () => {
      expect(() => removeToken()).not.toThrow()
    })
  })
})
