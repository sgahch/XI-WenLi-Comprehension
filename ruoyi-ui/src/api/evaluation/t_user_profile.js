import request from '@/utils/request'

// 查询学生档案管理列表
export function listT_user_profile(query) {
  return request({
    url: '/evaluation/t_user_profile/list',
    method: 'get',
    params: query
  })
}

// 查询学生档案管理详细
export function getT_user_profile(id) {
  return request({
    url: '/evaluation/t_user_profile/' + id,
    method: 'get'
  })
}

// 新增学生档案管理
export function addT_user_profile(data) {
  return request({
    url: '/evaluation/t_user_profile',
    method: 'post',
    data: data
  })
}

// 修改学生档案管理
export function updateT_user_profile(data) {
  return request({
    url: '/evaluation/t_user_profile',
    method: 'put',
    data: data
  })
}

// 删除学生档案管理
export function delT_user_profile(id) {
  return request({
    url: '/evaluation/t_user_profile/' + id,
    method: 'delete'
  })
}
