import { http } from '../utils/axios'

// 管理员相关API
export const adminAPI = {
  // 获取学生列表
  getStudentList(params) {
    return http.get('/admin/students', params)
  },
  
  // 获取学生详情
  getStudentDetail(id) {
    return http.get(`/admin/students/${id}`)
  },
  
  // 添加学生
  addStudent(data) {
    return http.post('/admin/students', data)
  },
  
  // 更新学生信息
  updateStudent(id, data) {
    return http.put(`/admin/students/${id}`, data)
  },
  
  // 删除学生
  deleteStudent(id) {
    return http.delete(`/admin/students/${id}`)
  },
  
  // 批量导入学生
  importStudents(file) {
    return http.upload('/admin/students/import', file)
  },
  
  // 导出学生列表
  exportStudents(params) {
    return http.download('/admin/students/export', params)
  },
  
  // 配置测评体系
  configEvaluationSystem(data) {
    return http.post('/admin/evaluation/system', data)
  },
  
  // 启用/禁用测评体系
  toggleSystemStatus(id, status) {
    return http.put(`/admin/evaluation/system/${id}/status`, { status })
  },
  
  // 管理测评项目
  manageEvaluationItems(data) {
    return http.post('/admin/evaluation/items', data)
  },
  
  // 批量导入测评项目
  importEvaluationItems(file) {
    return http.upload('/admin/evaluation/items/import', file)
  },
  
  // 审核测评申请
  reviewEvaluation(id, data) {
    return http.put(`/admin/evaluation/review/${id}`, data)
  },
  
  // 批量审核测评申请
  batchReviewEvaluations(data) {
    return http.put('/admin/evaluation/review/batch', data)
  },
  
  // 处理成绩申诉
  handleAppeal(id, data) {
    return http.put(`/admin/evaluation/appeal/${id}/handle`, data)
  },
  
  // 获取申诉列表
  getAppealList(params) {
    return http.get('/admin/evaluation/appeals', params)
  },
  
  // 计算综测总分
  calculateTotalScores(semester) {
    return http.post('/admin/evaluation/calculate', { semester })
  },
  
  // 发布/撤回成绩
  toggleScorePublish(semester, status) {
    return http.put(`/admin/evaluation/scores/publish/${semester}`, { status })
  },
  
  // 管理用户角色
  manageUserRoles(data) {
    return http.post('/admin/user/roles', data)
  },
  
  // 发布通知
  publishNotification(data) {
    return http.post('/admin/notifications', data)
  },
  
  // 获取通知列表
  getNotificationList(params) {
    return http.get('/admin/notifications', params)
  }
}

export default adminAPI