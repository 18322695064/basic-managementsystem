import request from '@/utils/request'

export function listConfig(params) {
  return request({
    url: '/system/config/list',
    method: 'get',
    params
  })
}

export function getConfig(configId) {
  return request({
    url: '/system/config/' + configId,
    method: 'get'
  })
}

export function addConfig(data) {
  return request({
    url: '/system/config',
    method: 'post',
    data
  })
}

export function updateConfig(data) {
  return request({
    url: '/system/config',
    method: 'put',
    data
  })
}

export function delConfig(configIds) {
  return request({
    url: '/system/config/' + configIds,
    method: 'delete'
  })
}

export function getConfigByKey(configKey) {
  return request({
    url: '/system/config/key/' + configKey,
    method: 'get'
  })
}
