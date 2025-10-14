import { http } from '../utils/axios'

// 领导端相关API
export const leaderAPI = {
  // 获取数据驾驶舱概览
  getDashboardOverview(semester) {
    return http.get('/leader/dashboard/overview', { params: { semester } })
  },
  
  // 获取院系统计数据
  getDepartmentStatistics(params) {
    return http.get('/leader/statistics/departments', params)
  },
  
  // 获取专业统计数据
  getMajorStatistics(params) {
    return http.get('/leader/statistics/majors', params)
  },
  
  // 获取班级统计数据
  getClassStatistics(params) {
    return http.get('/leader/statistics/classes', params)
  },
  
  // 获取年级统计数据
  getGradeStatistics(params) {
    return http.get('/leader/statistics/grades', params)
  },
  
  // 多维度查询学生成绩
  queryStudentScores(params) {
    return http.get('/leader/query/scores', params)
  },
  
  // 获取测评项目分析
  getEvaluationItemAnalysis(params) {
    return http.get('/leader/analysis/items', params)
  },
  
  // 获取成绩分布分析
  getScoreDistributionAnalysis(params) {
    return http.get('/leader/analysis/score-distribution', params)
  },
  
  // 获取年度趋势分析
  getYearlyTrendAnalysis(params) {
    return http.get('/leader/analysis/yearly-trend', params)
  },
  
  // 导出综合测评报表
  exportComprehensiveReport(params) {
    return http.download('/leader/reports/comprehensive', params)
  },
  
  // 导出院系对比报表
  exportDepartmentComparisonReport(params) {
    return http.download('/leader/reports/department-comparison', params)
  },
  
  // 导出专业对比报表
  exportMajorComparisonReport(params) {
    return http.download('/leader/reports/major-comparison', params)
  },
  
  // 获取异常数据报告
  getAbnormalDataReport(params) {
    return http.get('/leader/reports/abnormal-data', params)
  },
  
  // 获取测评工作进度
  getEvaluationProgress(semester) {
    return http.get('/leader/progress', { params: { semester } })
  },
  
  // 获取系统使用情况统计
  getSystemUsageStats(params) {
    return http.get('/leader/stats/system-usage', params)
  }
}

export default leaderAPI