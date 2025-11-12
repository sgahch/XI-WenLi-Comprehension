import request from '@/utils/request'

// 查询计分规则列表
export function listRule(query) {
  return request({
    url: '/evaluation/rule/list',
    method: 'get',
    params: query
  })
}

// 查询计分规则详细
export function getRule(id) {
  return request({
    url: '/evaluation/rule/' + id,
    method: 'get'
  })
}

// 新增计分规则
export function addRule(data) {
  return request({
    url: '/evaluation/rule',
    method: 'post',
    data: data
  })
}

// 修改计分规则
export function updateRule(data) {
  return request({
    url: '/evaluation/rule',
    method: 'put',
    data: data
  })
}

// 删除计分规则
export function delRule(id) {
  return request({
    url: '/evaluation/rule/' + id,
    method: 'delete'
  })
}
