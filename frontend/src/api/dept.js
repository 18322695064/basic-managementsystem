import request from '@/utils/request'

export function listDept(params) {
  return request({
    url: '/system/dept/list',
    method: 'get',
    params
  })
}

export function getDept(deptId) {
  return request({
    url: '/system/dept/' + deptId,
    method: 'get'
  })
}

export function addDept(data) {
  return request({
    url: '/system/dept',
    method: 'post',
    data
  })
}

export function updateDept(data) {
  return request({
    url: '/system/dept',
    method: 'put',
    data
  })
}

export function delDept(deptId) {
  return request({
    url: '/system/dept/' + deptId,
    method: 'delete'
  })
}

export function getDeptOptions() {
  return request({
    url: '/system/dept/optionselect',
    method: 'get'
  })
}

export function downloadDeptTemplate() {
  return request({
    url: '/system/dept/importTemplate',
    method: 'get',
    responseType: 'blob'
  })
}

export function importDept(formData) {
  return request({
    url: '/system/dept/importData',
    method: 'post',
    data: formData,
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}
