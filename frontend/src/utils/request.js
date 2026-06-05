import axios from 'axios'
import { message } from 'ant-design-vue'
import { getToken, removeToken } from './auth'
import router from '@/router'

const service = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  timeout: 30000
})

service.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
      config.headers['Authorization'] = 'Bearer ' + token
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

service.interceptors.response.use(
  response => {
    if (response.config.responseType === 'blob') {
      return response.data
    }
    const res = response.data
    if (res.code !== 200) {
      if (!response.config?.silent) {
        message.error(res.msg || '请求失败')
      }
      if (res.code === 401) {
        removeToken()
        localStorage.removeItem('openedTabs')
        localStorage.removeItem('activeTab')
        router.push('/login')
      }
      return Promise.reject(new Error(res.msg || '请求失败'))
    }
    return res
  },
  error => {
    if (error.response) {
      switch (error.response.status) {
        case 401:
          removeToken()
          localStorage.removeItem('openedTabs')
          localStorage.removeItem('activeTab')
          router.push('/login')
          if (!error.config?.silent) message.error('登录已过期，请重新登录')
          break
        case 403:
          if (!error.config?.silent) message.error('没有权限访问')
          break
        case 404:
          message.error('请求资源不存在')
          break
        case 500:
          message.error('服务器内部错误')
          break
        default:
          message.error(error.message || '请求失败')
      }
    } else {
      message.error('网络连接失败')
    }
    return Promise.reject(error)
  }
)

export default service
