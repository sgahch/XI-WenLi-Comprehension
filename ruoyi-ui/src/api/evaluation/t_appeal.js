import request from '@/utils/request'

// 查询申诉列表
export function listT_appeal(query) {
  return request({
    url: '/evaluation/t_appeal/list',
    method: 'get',
    params: query
  })
}

// 查询申诉详细
export function getT_appeal(id) {
  return request({
    url: '/evaluation/t_appeal/' + id,
    method: 'get'
  })
}

// 新增申诉
export function addT_appeal(data) {
  return request({
    url: '/evaluation/t_appeal',
    method: 'post',
    data: data
  })
}

// 修改申诉
export function updateT_appeal(data) {
  return request({
    url: '/evaluation/t_appeal',
    method: 'put',
    data: data
  })
}

// 删除申诉
export function delT_appeal(id) {
  return request({
    url: '/evaluation/t_appeal/' + id,
    method: 'delete'
  })
}
