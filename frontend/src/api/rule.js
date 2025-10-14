import { http } from '../utils/axios'

// 考评规则管理API（按需求文档规范）
export const ruleAPI = {
  // 添加学院考评规则
  addCollegeRule(data) {
    return http.post('/rules/college', data)
  },

  // 调整考评维度权重
  adjustRule(ruleId, indicators) {
    return http.put(`/rules/${ruleId}/adjust`, indicators)
  },

  // 获取学院当前考评规则
  getCurrentRule(collegeId, semester) {
    return http.get(`/rules/college/${collegeId}/current`, {
      params: { semester }
    })
  },

  // 获取学院所有规则历史
  getCollegeRules(collegeId) {
    return http.get(`/rules/college/${collegeId}/history`)
  },

  // 启用/禁用规则
  toggleRuleStatus(ruleId, status) {
    return http.put(`/rules/${ruleId}/status`, { status })
  },

  // 删除规则
  deleteRule(ruleId) {
    return http.delete(`/rules/${ruleId}`)
  },

  // 复制规则到新学期
  copyRuleToSemester(ruleId, newSemester) {
    return http.post(`/rules/${ruleId}/copy`, { semester: newSemester })
  },

  // 获取所有启用的规则
  getEnabledRules() {
    return http.get('/rules/enabled')
  },

  // 预览规则配置
  previewRule(data) {
    return http.post('/rules/preview', data)
  },

  // 导入规则模板
  importRuleTemplate(formData) {
    return http.post('/rules/import-template', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
  },

  // 导出规则配置
  exportRuleConfig(ruleId) {
    return http.get(`/rules/${ruleId}/export`, {
      responseType: 'blob'
    })
  },

  // 验证规则配置
  validateRule(data) {
    return http.post('/rules/validate', data)
  }
}
