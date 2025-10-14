import request from '@/utils/request'

// 查询学生档案管理列表
export function listProfile(query) {
  return request({
    url: '/evaluation/profile/list',
    method: 'get',
    params: query
  })
}

// 查询学生档案管理详细
export function getProfile(id) {
  return request({
    url: '/evaluation/profile/' + id,
    method: 'get'
  })
}

// 新增学生档案管理
export function addProfile(data) {
  return request({
    url: '/evaluation/profile',
    method: 'post',
    data: data
  })
}

// 修改学生档案管理
export function updateProfile(data) {
  return request({
    url: '/evaluation/profile',
    method: 'put',
    data: data
  })
}

// 删除学生档案管理
export function delProfile(id) {
  return request({
    url: '/evaluation/profile/' + id,
    method: 'delete'
  })
}
