import request from '@/utils/request'

// 获取树状结构的计分规则
export function getRuleTree(params) {
  return request({
    url: '/evaluation/rule/tree',
    method: 'get',
    params
  })
}

// 创建填报
export function createSubmission(data) {
  return request({
    url: '/evaluation/submission',
    method: 'post',
    data
  })
}

// 更新填报
export function updateSubmission(data) {
  return request({
    url: '/evaluation/submission',
    method: 'post',
    data
  })
}

// 获取填报详情
export function getSubmissionDetail(id) {
  return request({
    url: `/evaluation/submission/${id}`,
    method: 'get'
  })
}

// 获取填报详情（别名，用于兼容）
export function getSubmission(id) {
  return request({
    url: `/evaluation/submission/${id}`,
    method: 'get'
  })
}

// 获取填报列表（审核用）
export function getSubmissionList(params) {
  return request({
    url: '/evaluation/submission/list',
    method: 'get',
    params
  })
}

// 获取填报列表（别名，用于兼容）
export function listSubmission(params) {
  return request({
    url: '/evaluation/submission/list',
    method: 'get',
    params
  })
}

// 执行审核操作
export function auditSubmission(data) {
  return request({
    url: '/evaluation/submission/audit',
    method: 'post',
    data
  })
}

// 批量审核
export function batchAuditSubmission(data) {
  return request({
    url: '/evaluation/submission/audit/batch',
    method: 'post',
    data
  })
}

// 获取学生填报历史
export function getSubmissionHistory(params) {
  return request({
    url: '/evaluation/submission/history',
    method: 'get',
    params
  })
}

// 删除填报（草稿状态）
export function deleteSubmission(id) {
  return request({
    url: `/evaluation/submission/${id}`,
    method: 'delete'
  })
}

// 获取填报统计数据
export function getSubmissionStatistics(params) {
  return request({
    url: '/evaluation/submission/statistics',
    method: 'get',
    params
  })
}

// 导出填报数据
export function exportSubmissionData(params) {
  return request({
    url: '/evaluation/submission/export',
    method: 'get',
    params,
    responseType: 'blob'
  })
}