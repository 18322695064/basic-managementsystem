import request from '@/utils/request'

export function listRole(params) {
  return request({
    url: '/system/role/list',
    method: 'get',
    params
  })
}

export function getRole(roleId) {
  return request({
    url: '/system/role/' + roleId,
    method: 'get'
  })
}

export function addRole(data) {
  return request({
    url: '/system/role',
    method: 'post',
    data
  })
}

export function updateRole(data) {
  return request({
    url: '/system/role',
    method: 'put',
    data
  })
}

export function delRole(roleIds) {
  return request({
    url: '/system/role/' + roleIds,
    method: 'delete'
  })
}

export function getRoleOptions() {
  return request({
    url: '/system/role/optionselect',
    method: 'get'
  })
}

export function updateRoleMenuPerms(data) {
  return request({
    url: '/system/role/menuPerms',
    method: 'put',
    data
  })
}

export function updateRoleDataScope(roleId, dataScope) {
  return request({
    url: '/system/role/dataScope',
    method: 'put',
    data: { id: roleId, dataScope }
  })
}
