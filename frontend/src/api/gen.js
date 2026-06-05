import request from '@/utils/request'

export function listTable(params) {
  return request({ url: '/tool/gen/list', method: 'get', params })
}

export function getTableInfo(tableName) {
  return request({ url: '/tool/gen/' + tableName, method: 'get' })
}

export function previewCode(tableName) {
  return request({ url: '/tool/gen/preview/' + tableName, method: 'get' })
}

export function generateCode(tableName) {
  return request({ url: '/tool/gen/generate/' + tableName, method: 'post', responseType: 'blob' })
}

export function createTable(data) {
  return request({ url: '/tool/gen/table', method: 'post', data })
}

export function updateTable(tableName, data) {
  return request({ url: '/tool/gen/table/' + tableName, method: 'put', data })
}
