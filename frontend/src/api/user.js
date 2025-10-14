import { http } from "../utils/axios";

// 用户相关API
export const userAPI = {
  // 用户登录
  login(data) {
    return http.post("/user/login", data);
  },

  // 用户注册
  register(data) {
    return http.post("/user/register", data);
  },

  // 用户登出
  logout() {
    return http.post("/user/logout");
  },

  // 获取当前用户信息
  getUserInfo() {
    return http.get("/user/info");
  },

  // 更新用户信息
  updateUserInfo(data) {
    return http.put("/user/info", data);
  },

  // 修改密码
  updatePassword(data) {
    return http.put("/user/password", data);
  },

  // 更新头像
  updateAvatar(data) {
    return http.put("/user/avatar", data);
  },

  // 忘记密码
  forgotPassword(data) {
    return http.post("/user/forgot-password", data);
  },

  // 获取Dashboard统计数据
  getDashboardStats() {
    return http.get("/user/dashboard-stats");
  },

  // 获取待办事项
  getTodos() {
    return http.get("/user/todos");
  },

  // 获取成绩趋势数据
  getScoreTrend(semester) {
    return http.get("/user/score-trend", { params: { semester } });
  },

  // 获取通知列表
  getNotifications(params) {
    return http.get("/user/notifications", { params });
  },

  // 标记通知为已读
  markNotificationAsRead(notificationId) {
    return http.put(`/user/notifications/${notificationId}/read`);
  },

  // 标记所有通知为已读
  markAllNotificationsAsRead() {
    return http.put("/user/notifications/read-all");
  },

  // 上传头像
  uploadAvatar(file) {
    const formData = new FormData();
    formData.append("file", file);
    return http.post("/file/upload/avatar", formData, {
      headers: {
        "Content-Type": "multipart/form-data"
      }
    });
  }
};

export default userAPI;