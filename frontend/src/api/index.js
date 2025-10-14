// API模块入口文件
// 导出所有API模块（按需求文档四角色系统优化）
export * from "./user";
export * from "./evaluation";
export * from "./admin";
export * from "./leader";
export * from "./material"; // 新增：材料管理API
export * from "./rule"; // 新增：考评规则API
export * from "./monitor"; // 新增：班委专用API

// 角色常量定义
export const USER_ROLES = {
  STUDENT: "USER_STU", // 学生
  MONITOR: "USER_MON", // 班委
  TEACHER: "USER_TCH", // 辅导员
  ADMIN: "USER_ADM", // 管理员
};

// 材料状态常量
export const MATERIAL_STATUS = {
  PENDING_MON: "PENDING_MON", // 待班委审核
  PENDING_TCH: "PENDING_TCH", // 待辅导员审核
  PASS: "PASS", // 审核通过
  REJECT: "REJECT", // 审核拒绝
};

// 审核结果常量
export const AUDIT_RESULT = {
  PASS: "PASS",
  REJECT: "REJECT",
};
