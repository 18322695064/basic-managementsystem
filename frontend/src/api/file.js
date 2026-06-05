import request from '@/utils/request'

export function listFile(params) {
  return request({
    url: '/system/file/list',
    method: 'get',
    params
  })
}

export function delFile(fileIds) {
  return request({
    url: '/system/file/' + fileIds,
    method: 'delete'
  })
}

export function downloadFile(fileId) {
  return request({
    url: '/system/file/download/' + fileId,
    method: 'get',
    responseType: 'blob'
  })
}
