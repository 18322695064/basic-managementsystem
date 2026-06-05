import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/auth/login',
    method: 'post',
    data
  })
}

export function getInfo() {
  return request({
    url: '/auth/getInfo',
    method: 'get'
  })
}

export function getRouters() {
  return request({
    url: '/auth/getRouters',
    method: 'get'
  })
}

export function logout() {
  return request({
    url: '/auth/logout',
    method: 'post'
  })
}

export function getCaptchaImage() {
  return request({
    url: '/auth/captchaImage',
    method: 'get'
  })
}
