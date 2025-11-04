import request from '@/utils/request'

/**
 * 查询审核日志列表
 * @param {Object} query - 查询参数
 */
export function listAuditLog(query) {
  return request({
    url: '/evaluation/auditLog/list',
    method: 'get',
    params: query
  })
}

/**
 * 查询审核日志详情
 * @param {Number} id - 日志ID
 */
export function getAuditLog(id) {
  return request({
    url: `/evaluation/auditLog/${id}`,
    method: 'get'
  })
}

/**
 * 根据提交ID查询审核日志
 * @param {Number} submissionId - 提交ID
 */
export function getAuditLogsBySubmissionId(submissionId) {
  return request({
    url: `/evaluation/auditLog/submission/${submissionId}`,
    method: 'get'
  })
}

/**
 * 根据详情ID查询审核日志
 * @param {Number} detailId - 详情ID
 */
export function getAuditLogsByDetailId(detailId) {
  return request({
    url: `/evaluation/auditLog/detail/${detailId}`,
    method: 'get'
  })
}

/**
 * 导出审核日志
 * @param {Object} query - 查询参数
 */
export function exportAuditLog(query) {
  return request({
    url: '/evaluation/auditLog/export',
    method: 'get',
    params: query,
    responseType: 'blob'
  })
}

