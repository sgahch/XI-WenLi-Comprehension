import { http } from '../utils/axios'

// 测评相关API
export const evaluationAPI = {
  // 获取测评体系列表
  getEvaluationSystems(params) {
    return http.get('/evaluation/systems', params)
  },
  
  // 获取当前测评体系
  getCurrentSystem() {
    return http.get('/evaluation/current-system')
  },
  
  // 获取测评项目列表
  getEvaluationItems(params) {
    return http.get('/evaluation/items', params)
  },
  
  // 获取单个测评项目详情
  getEvaluationItemDetail(id) {
    return http.get(`/evaluation/items/${id}`)
  },
  
  // 提交测评申请
  submitEvaluation(data) {
    return http.post('/evaluation/submit', data)
  },
  
  // 获取我的测评记录
  getMyEvaluations(params) {
    return http.get('/evaluation/my-evaluations', params)
  },
  
  // 获取测评结果
  getEvaluationResults(params) {
    return http.get('/evaluation/results', params)
  },
  
  // 获取个人测评成绩
  getMyScore() {
    return http.get('/evaluation/my-score')
  },
  
  // 提交成绩申诉
  submitAppeal(data) {
    return http.post('/evaluation/appeal', data)
  },
  
  // 获取申诉状态
  getAppealStatus(id) {
    return http.get(`/evaluation/appeal/${id}/status`)
  },
  
  // 获取我的申诉记录
  getMyAppeals(params) {
    return http.get('/evaluation/my-appeals', params)
  },
  
  // 上传证明材料
  uploadProofFile(file, evaluationId) {
    return http.upload(`/evaluation/upload-proof/${evaluationId}`, file)
  },
  
  // 下载证明材料
  downloadProofFile(fileId) {
    return http.download(`/evaluation/download-proof/${fileId}`)
  }
}

export default evaluationAPI

// 兼容具名导出
export const submitScoreAppeal = evaluationAPI.submitAppeal;
export const getAppealRecords = evaluationAPI.getMyAppeals;
export const getAppealDetail = evaluationAPI.getAppealStatus;
export const getEvaluationItems = evaluationAPI.getEvaluationItems;
