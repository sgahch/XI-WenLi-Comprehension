import request from '@/utils/request'

// 查询测评体系列表
export function listT_evaluation(query) {
  return request({
    url: '/evaluation/t_evaluation/list',
    method: 'get',
    params: query
  })
}

// 查询测评体系详细
export function getT_evaluation(id) {
  return request({
    url: '/evaluation/t_evaluation/' + id,
    method: 'get'
  })
}

// 新增测评体系
export function addT_evaluation(data) {
  return request({
    url: '/evaluation/t_evaluation',
    method: 'post',
    data: data
  })
}

// 修改测评体系
export function updateT_evaluation(data) {
  return request({
    url: '/evaluation/t_evaluation',
    method: 'put',
    data: data
  })
}

// 删除测评体系
export function delT_evaluation(id) {
  return request({
    url: '/evaluation/t_evaluation/' + id,
    method: 'delete'
  })
}
