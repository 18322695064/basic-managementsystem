import request from '@/utils/request'

export function listNotice(params) {
  return request({
    url: '/system/notice/list',
    method: 'get',
    params
  })
}

export function getNotice(noticeId) {
  return request({
    url: '/system/notice/' + noticeId,
    method: 'get'
  })
}

export function addNotice(data) {
  return request({
    url: '/system/notice',
    method: 'post',
    data
  })
}

export function updateNotice(data) {
  return request({
    url: '/system/notice',
    method: 'put',
    data
  })
}

export function delNotice(noticeIds) {
  return request({
    url: '/system/notice/' + noticeIds,
    method: 'delete'
  })
}
