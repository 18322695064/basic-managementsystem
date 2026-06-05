import request from '@/utils/request'

export function listOperLog(params) {
  return request({
    url: '/system/log/oper/list',
    method: 'get',
    params
  })
}

export function cleanOperLog() {
  return request({
    url: '/system/log/oper/clean',
    method: 'delete'
  })
}

export function listLoginLog(params) {
  return request({
    url: '/system/log/login/list',
    method: 'get',
    params
  })
}

export function cleanLoginLog() {
  return request({
    url: '/system/log/login/clean',
    method: 'delete'
  })
}
