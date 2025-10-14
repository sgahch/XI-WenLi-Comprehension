import { http } from '../utils/axios'

// 材料管理API（按需求文档规范）
export const materialAPI = {
  // 学生提交材料
  submitMaterial(formData) {
    return http.post('/materials/submit', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
  },

  // 查询我的材料记录
  getMyRecords(userId) {
    return http.get('/materials/my-records', { params: { userId } })
  },

  // 班委审核材料
  monitorAudit(materialId, data) {
    return http.post(`/materials/${materialId}/monitor-audit`, data)
  },

  // 辅导员审核材料
  teacherAudit(materialId, data) {
    return http.post(`/materials/${materialId}/teacher-audit`, data)
  },

  // 查询待班委审核的材料
  getPendingMonitorRecords(collegeId) {
    return http.get('/materials/pending-monitor', { params: { collegeId } })
  },

  // 查询待辅导员审核的材料
  getPendingTeacherRecords(collegeId) {
    return http.get('/materials/pending-teacher', { params: { collegeId } })
  },

  // 查询材料详情
  getMaterialDetail(materialId) {
    return http.get(`/materials/${materialId}`)
  },

  // 查询审核历史
  getAuditHistory(materialId) {
    return http.get(`/materials/${materialId}/audit-history`)
  },

  // 下载材料文件
  downloadMaterial(materialId) {
    return http.get(`/materials/${materialId}/download`, {
      responseType: 'blob'
    })
  },

  // 学生重新提交材料（申诉后）
  resubmitMaterial(materialId, formData) {
    return http.put(`/materials/${materialId}/resubmit`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
  },

  // 批量审核材料
  batchAudit(data) {
    return http.post('/materials/batch-audit', data)
  },

  // 导出材料审核报告
  exportAuditReport(params) {
    return http.get('/materials/export-report', {
      params,
      responseType: 'blob'
    })
  }
}
