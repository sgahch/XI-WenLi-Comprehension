import store from '@/store'

/**
 * 综测系统权限工具类
 */
export default {
  /**
   * 检查是否为综测学生角色
   */
  isEvaluationStudent() {
    const roles = store.getters.roles || []
    return roles.includes('evaluation_student')
  },

  /**
   * 检查是否为综测教师角色
   */
  isEvaluationTeacher() {
    const roles = store.getters && store.getters.roles
    return roles.includes('evaluation_teacher')
  },

  /**
   * 检查是否为综测管理员角色
   */
  isEvaluationAdmin() {
    const roles = store.getters && store.getters.roles
    return roles.includes('evaluation_admin') || roles.includes('admin')
  },

  /**
   * 检查是否有综测填报权限
   */
  canSubmitEvaluation() {
    return this.isEvaluationStudent() || this.isEvaluationTeacher() || this.isEvaluationAdmin()
  },

  /**
   * 检查是否有综测审核权限
   */
  canAuditEvaluation() {
    return this.isEvaluationTeacher() || this.isEvaluationAdmin()
  },

  /**
   * 检查是否有成绩统计权限
   */
  canViewStatistics() {
    return this.isEvaluationTeacher() || this.isEvaluationAdmin()
  },

  /**
   * 检查是否有导入导出权限
   */
  canImportExport() {
    return this.isEvaluationTeacher() || this.isEvaluationAdmin()
  },

  /**
   * 检查是否有配置管理权限
   */
  canManageConfig() {
    return this.isEvaluationAdmin()
  },

  /**
   * 检查是否有删除权限
   */
  canDelete() {
    return this.isEvaluationAdmin()
  },

  /**
   * 获取当前用户的综测角色类型
   */
  getCurrentEvaluationRole() {
    if (this.isEvaluationAdmin()) return 'admin'
    if (this.isEvaluationTeacher()) return 'teacher'
    if (this.isEvaluationStudent()) return 'student'
    return null
  },

  /**
   * 检查是否有查看指定学生数据的权限
   * @param {String} studentId 学生ID
   */
  canViewStudentData(studentId) {
    // 管理员可查看所有
    if (this.isEvaluationAdmin()) return true
    // 学生仅可查看自己的数据：后端以 userName 作为学号对比
    const userName = String(store.getters.name || '')
    const sid = String(studentId || '')
    if (this.isEvaluationStudent()) {
      return userName && sid && userName === sid
    }
    // 教师：后续按班级/专业范围判断，这里保持现状
    if (this.isEvaluationTeacher()) return true
    return false
  },

  /**
   * 检查是否有编辑指定学生数据的权限
   * @param {String} studentId 学生ID
   */
  canEditStudentData(studentId) {
    // 管理员可编辑所有
    if (this.isEvaluationAdmin()) return true
    // 学生仅可编辑自己的数据：与后端保持一致使用 userName
    const userName = String(store.getters.name || '')
    const sid = String(studentId || '')
    if (this.isEvaluationStudent()) {
      return userName && sid && userName === sid
    }
    // 教师默认不可直接编辑（仅审核），如需开放再细化
    return false
  }
}