import { http } from '../utils/axios'

// 班委专用API（新增角色）
export const monitorAPI = {
  // 获取班级待审核材料列表
  getPendingMaterials(collegeId) {
    return http.get('/materials/pending-monitor', { params: { collegeId } })
  },

  // 班委审核材料
  auditMaterial(materialId, data) {
    return http.post(`/materials/${materialId}/monitor-audit`, data)
  },

  // 获取班级学生列表
  getClassStudents(collegeId) {
    return http.get('/monitor/class-students', { params: { collegeId } })
  },

  // 获取班级统计数据
  getClassStatistics(collegeId) {
    return http.get('/monitor/class-statistics', { params: { collegeId } })
  },

  // 提醒未提交学生
  remindStudents(studentIds, message) {
    return http.post('/monitor/remind-students', { studentIds, message })
  },

  // 批量初审材料
  batchAudit(data) {
    return http.post('/monitor/batch-audit', data)
  },

  // 获取审核进度统计
  getAuditProgress(collegeId) {
    return http.get('/monitor/audit-progress', { params: { collegeId } })
  },

  // 导出班级材料汇总
  exportClassSummary(collegeId, params) {
    return http.get('/monitor/export-summary', {
      params: { collegeId, ...params },
      responseType: 'blob'
    })
  },

  // 查看材料详情
  getMaterialDetail(materialId) {
    return http.get(`/materials/${materialId}`)
  },

  // 获取审核历史
  getAuditHistory(materialId) {
    return http.get(`/materials/${materialId}/audit-history`)
  },

  // 设置审核标准
  setAuditCriteria(collegeId, criteria) {
    return http.post('/monitor/audit-criteria', { collegeId, criteria })
  },

  // 获取审核标准
  getAuditCriteria(collegeId) {
    return http.get('/monitor/audit-criteria', { params: { collegeId } })
  }
}
