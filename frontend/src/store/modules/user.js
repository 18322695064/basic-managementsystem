import { defineStore } from 'pinia'
import { login, getInfo, logout } from '@/api/auth'
import { getToken, setToken, removeToken } from '@/utils/auth'

export const useUserStore = defineStore('user', {
  state: () => ({
    token: getToken(),
    id: '',
    username: '',
    nickname: '',
    avatar: '',
    roles: [],
    permissions: []
  }),

  actions: {
    async login(userInfo) {
      const { username, password, code, uuid } = userInfo
      const res = await login({ username, password, code, uuid })
      setToken(res.data.token)
      this.token = res.data.token
      return res
    },

    async getInfo() {
      const res = await getInfo()
      const user = res.data.user
      this.id = user.id
      this.username = user.accountNumber
      this.nickname = user.nickName
      this.avatar = user.avatar || ''
      this.roles = res.data.roles || []
      this.permissions = res.data.permissions || []
      return res
    },

    async logout() {
      try {
        await logout()
      } finally {
        this.token = ''
        this.roles = []
        this.permissions = []
        removeToken()
      }
    },

    resetToken() {
      this.token = ''
      this.roles = []
      this.permissions = []
      removeToken()
    }
  }
})
