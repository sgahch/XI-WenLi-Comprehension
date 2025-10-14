import request from '@/utils/request'

// 查询考评加分记录列表
export function listT_score_record(query) {
  return request({
    url: '/evaluation/t_score_record/list',
    method: 'get',
    params: query
  })
}

// 查询考评加分记录详细
export function getT_score_record(id) {
  return request({
    url: '/evaluation/t_score_record/' + id,
    method: 'get'
  })
}

// 新增考评加分记录
export function addT_score_record(data) {
  return request({
    url: '/evaluation/t_score_record',
    method: 'post',
    data: data
  })
}

// 修改考评加分记录
export function updateT_score_record(data) {
  return request({
    url: '/evaluation/t_score_record',
    method: 'put',
    data: data
  })
}

// 删除考评加分记录
export function delT_score_record(id) {
  return request({
    url: '/evaluation/t_score_record/' + id,
    method: 'delete'
  })
}
