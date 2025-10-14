import { http } from "../utils/axios";

// 学生相关API
export const studentAPI = {
  // 获取当前学生信息（通过用户接口）
  getMyInfo() {
    return http.get("/user/info");
  },

  // 更新当前学生信息
  updateMyInfo(data) {
    return http.put("/user/info", data);
  },

  // 获取Dashboard统计数据（通过用户接口）
  getDashboardStats() {
    return http.get("/user/dashboard-stats");
  },

  // 获取待办事项（通过用户接口）
  getTodos() {
    return http.get("/user/todos");
  },

  // 获取成绩趋势数据（通过用户接口）
  getScoreTrend(semester) {
    return http.get("/user/score-trend", { params: { semester } });
  },

  // 获取通知列表（通过用户接口）
  getNotifications(params) {
    return http.get("/user/notifications", { params });
  },

  // 获取学生成绩详情列表
  getScoreDetails(params) {
    return http.get("/student-score-detail/my-list", params);
  },

  // 获取学生总成绩
  getTotalScore() {
    return http.get("/student-total-score/my-score");
  },

  // 提交测评项目得分
  submitScore(data) {
    return http.post("/student-score-detail/submit", data);
  },

  // 更新测评项目得分
  updateScore(id, data) {
    return http.put(`/student-score-detail/update/${id}`, data);
  }
};

export default studentAPI;