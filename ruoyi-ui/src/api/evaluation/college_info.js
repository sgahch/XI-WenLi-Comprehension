import request from '@/utils/request'

// 查询学院信息列表
export function listCollege_info(query) {
  return request({
    url: '/evaluation/college_info/list',
    method: 'get',
    params: query
  })
}

// 查询学院信息详细
export function getCollege_info(id) {
  return request({
    url: '/evaluation/college_info/' + id,
    method: 'get'
  })
}

// 新增学院信息
export function addCollege_info(data) {
  return request({
    url: '/evaluation/college_info',
    method: 'post',
    data: data
  })
}

// 修改学院信息
export function updateCollege_info(data) {
  return request({
    url: '/evaluation/college_info',
    method: 'put',
    data: data
  })
}

// 删除学院信息
export function delCollege_info(id) {
  return request({
    url: '/evaluation/college_info/' + id,
    method: 'delete'
  })
}
