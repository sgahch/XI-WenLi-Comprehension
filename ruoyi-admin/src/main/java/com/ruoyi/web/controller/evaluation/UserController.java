//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.common.core.domain.entity.SysUser;
//import com.ruoyi.common.utils.SecurityUtils;
//import com.ruoyi.system.domain.evaluation.dto.UpdateUserDTO;
//import com.ruoyi.system.domain.evaluation.dto.UserRegisterDTO;
//import com.ruoyi.system.service.evaluation.IUserService;
//import com.ruoyi.framework.web.service.TokenService;
//import com.ruoyi.common.core.domain.model.LoginUser;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.util.StringUtils;
//import org.springframework.web.bind.annotation.*;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.Arrays;
//import java.util.Collections;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Slf4j
//@RestController
//@RequestMapping("/user")
//@Tag(name = "用户管理", description = "提供用户认证、授权和个人信息管理相关的API接口")
//public class UserController {
//
//    @Autowired
//    private IUserService userService;
//
//    @Autowired
//    private TokenService tokenService;
//
//    // --- 认证接口 ---
//
//    @Operation(summary = "用户登录", description = "用户通过学号/工号和密码进行认证")
//    @PostMapping("/login")
//    public AjaxResult login(@RequestBody Map<String, String> loginRequest) {
//        log.info("接收到登录请求, 请求体内容: {}", loginRequest);
//        try {
//            // 检查请求体是否为空
//            if (loginRequest == null) {
//                log.error("登录请求体为空");
//                return AjaxResult.error("请求参数不能为空");
//            }
//
//            String loginIdentifier = loginRequest.get("username");//这里的username实际上是学号
//            String password = loginRequest.get("password");
//
//            // 检查必要参数
//            if (!StringUtils.hasText(loginIdentifier)) {
//                log.error("登录标识(学号/工号)为空");
//                return AjaxResult.error("学号/工号不能为空");
//            }
//
//            if (!StringUtils.hasText(password)) {
//                log.error("密码为空");
//                return AjaxResult.error("密码不能为空");
//            }
//
//            log.info("接收到登录请求, 登录标识 (学号/工号): {}", loginIdentifier);
//            // 使用若依框架的认证机制
//            return userService.login(loginIdentifier, password);
//        } catch (Exception e) {
//            log.error("用户登录时发生未知异常", e);
//            return AjaxResult.error("登录失败，请稍后重试");
//        }
//    }
//
//    @Operation(summary = "用户注册", description = "新用户注册，提供学号/工号和密码")
//    @PostMapping("/register")
//    public AjaxResult register(@RequestBody UserRegisterDTO userRegisterDTO) {
//        log.info("接收到用户注册请求: {}", userRegisterDTO.getStudentId());
//        return userService.register(userRegisterDTO);
//    }
//
//    @Operation(summary = "用户登出", description = "用户登出系统，清除认证信息")
//    @PostMapping("/logout")
//    public AjaxResult logout(HttpServletRequest request) {
//        try {
//            // 获取当前用户
//            LoginUser loginUser = tokenService.getLoginUser(request);
//            if (loginUser != null) {
//                tokenService.delLoginUser(loginUser.getToken());
//                log.info("用户已登出: {}", loginUser.getUsername());
//            }
//            return AjaxResult.success("登出成功");
//        } catch (Exception e) {
//            log.error("登出异常", e);
//            return AjaxResult.error("登出失败: " + e.getMessage());
//        }
//    }
//
//    // --- 个人信息管理 (需要认证) ---
//
//    @Operation(summary = "获取当前用户信息", description = "获取当前登录用户的详细信息")
//    @GetMapping("/info")
//    public AjaxResult getUserInfo() {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取当前用户信息失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//
//            log.info("成功获取用户信息: userId={}", userId);
//            return userService.getUserInfo(userId);
//        } catch (Exception e) {
//            log.error("获取用户信息异常", e);
//            return AjaxResult.error("获取用户信息失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "更新当前用户信息", description = "更新当前登录用户的个人资料")
//    @PutMapping("/info")
//    public AjaxResult updateUserInfo(@RequestBody UpdateUserDTO updateUserDTO) {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("更新用户信息失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到更新用户信息请求: userId={}", userId);
//            return userService.updateUserInfo(userId, updateUserDTO);
//        } catch (Exception e) {
//            log.error("更新用户信息异常", e);
//            return AjaxResult.error("更新用户信息失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "修改当前用户密码", description = "当前登录用户修改自己的密码")
//    @PutMapping("/password")
//    public AjaxResult updatePassword(@RequestBody Map<String, String> passwordRequest) {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("修改密码失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            String oldPassword = passwordRequest.get("oldPassword");
//            String newPassword = passwordRequest.get("newPassword");
//            log.info("接收到修改密码请求: userId={}", userId);
//            return userService.updatePassword(userId, oldPassword, newPassword);
//        } catch (Exception e) {
//            log.error("修改密码异常", e);
//            return AjaxResult.error("修改密码失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "更新当前用户头像", description = "更新当前登录用户的头像URL")
//    @PutMapping("/avatar")
//    public AjaxResult updateAvatar(@RequestBody Map<String, String> avatarRequest) {
//        log.info("接收到更新头像请求，请求体: {}", avatarRequest);
//
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.error("更新头像失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//
//            String avatarUrl = avatarRequest.get("avatarUrl");
//            log.info("用户 userId={} 请求更新头像为URL: {}", userId, avatarUrl);
//
//            if (!StringUtils.hasText(avatarUrl)) {
//                log.error("更新头像失败：头像URL为空");
//                return AjaxResult.error("头像URL不能为空");
//            }
//
//            AjaxResult result = userService.updateUserAvatar(userId, avatarUrl);
//            log.info("更新头像结果: {}", result.get("msg"));
//            return result;
//        } catch (Exception e) {
//            log.error("更新头像异常", e);
//            return AjaxResult.error("更新头像失败: " + e.getMessage());
//        }
//    }
//
//    // --- 密码找回与重置 ---
//
//    @Operation(summary = "忘记密码", description = "用户通过学号/工号等信息申请重置密码")
//    @PostMapping("/forgot-password")
//    public AjaxResult forgotPassword(@RequestBody Map<String, String> request) {
//        // 这是一个公共接口，不需要认证
//        String studentId = request.get("studentId");
//        log.info("接收到忘记密码请求: {}", studentId);
//        // TODO: 实现发送验证码/邮件等找回密码的业务逻辑
//        return AjaxResult.success("如果用户存在，密码重置指令已发送");
//    }
//
//    @Operation(summary = "[管理员]重置用户密码", description = "管理员为指定用户重置密码")
//    @PutMapping("/{userId}/reset-password")
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult resetPassword(@PathVariable Long userId, @RequestBody Map<String, String> request) {
//        log.info("接收到管理员重置密码请求: 用户ID {}", userId);
//        String newPassword = request.get("newPassword");
//        return userService.resetPassword(userId, newPassword);
//    }
//
//    // --- 通知相关 (需要认证) ---
//
//    @Operation(summary = "获取用户通知", description = "获取当前登录用户的通知列表")
//    @GetMapping("/notifications")
//    public AjaxResult getNotifications(@RequestParam(defaultValue = "10") int limit) {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取通知失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到获取通知请求: userId={}", userId);
//
//            // TODO返回模拟数据，后续可改为真实的通知服务
//            List<Map<String, Object>> notifications = Arrays.asList(
//                new HashMap<String, Object>() {{
//                    put("id", 1);
//                    put("title", "2024年春季学期综合测评开始啦，请及时完成填报");
//                    put("timestamp", "2025-09-14T10:30:00");
//                    put("read", false);
//                }},
//                new HashMap<String, Object>() {{
//                    put("id" , 2);
//                    put("title", "系统将于本周六进行维护升级，请提前安排工作");
//                    put("timestamp", "2025-09-13T18:00:00");
//                    put("read", false);
//                }},
//                new HashMap<String, Object>() {{
//                    put("id", 3);
//                    put("title", "您的2023-2024学年秋季学期综测成绩已发布");
//                    put("timestamp", "2025-09-12T15:30:00");
//                    put("read", true);
//                }}
//            );
//
//            return AjaxResult.success("获取通知成功", notifications.subList(0, Math.min(limit, notifications.size())));
//        } catch (Exception e) {
//            log.error("获取用户通知异常", e);
//            return AjaxResult.error("获取通知失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "获取Dashboard统计数据", description = "获取当前用户的Dashboard数据")
//    @GetMapping("/dashboard-stats")
//    public AjaxResult getDashboardStats() {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取Dashboard统计数据失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到获取Dashboard统计数据请求: userId={}", userId);
//
//            //TODO 返回模拟数据，后续可改为真实的数据库查询
//            Map<String, Object> stats = new HashMap<String, Object>() {{
//                put("completedEvaluations", 5);
//                put("pendingEvaluations", 2);
//                put("currentScore", 89.5);
//                put("unreadNotifications", 3);
//                put("completionRate", 85);
//                put("urgentCount", 2);
//                put("scoreIncrease", 5);
//            }};
//
//            return AjaxResult.success("获取统计数据成功", stats);
//        } catch (Exception e) {
//            log.error("获取Dashboard统计数据异常", e);
//            return AjaxResult.error("获取统计数据失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "获取待办事项", description = "获取当前用户的待办事项列表")
//    @GetMapping("/todos")
//    public AjaxResult getTodos() {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取待办事项失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到获取待办事项请求: userId={}", userId);
//
//            // TODO返回模拟数据，后续可改为真实的业务数据
//            List<Map<String, Object>> todos = Arrays.asList(
//                new HashMap<String, Object>() {{
//                    put("id", 1);
//                    put("title", "2024年春季学期综合测评填报");
//                    put("status", "pending");
//                    put("deadline", "2024-06-30T23:59:59");
//                }},
//                new HashMap<String, Object>() {{
//                    put("id", 2);
//                    put("title", "上传社会实践证明材料");
//                    put("status", "pending");
//                    put("deadline", "2024-06-15T23:59:59");
//                }},
//                new HashMap<String, Object>() {{
//                    put("id", 3);
//                    put("title", "填写志愿服务时长");
//                    put("status", "pending");
//                    put("deadline", "2024-06-20T23:59:59");
//                }}
//            );
//
//            return AjaxResult.success("获取待办事项成功", todos);
//        } catch (Exception e) {
//            log.error("获取待办事项异常", e);
//            return AjaxResult.error("获取待办事项失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "获取成绩趋势数据", description = "获取当前用户的成绩趋势数据")
//    @GetMapping("/score-trend")
//    public AjaxResult getScoreTrend(@RequestParam(defaultValue = "all") String semester) {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取成绩趋势数据失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到获取成绩趋势数据请求: userId={}, 学期: {}", userId, semester);
//
//            // 返回模拟数据，后续可改为真实的数据库查询
//            Map<String, Object> trendData = new HashMap<String, Object>() {{
//                put("periods", Arrays.asList("2022-2023春季", "2022-2023秋季", "2023-2024春季", "2023-2024秋季"));
//                put("scores", Arrays.asList(82.0, 85.0, 87.0, 89.5));
//            }};
//
//            return AjaxResult.success("获取成绩趋势成功", trendData);
//        } catch (Exception e) {
//            log.error("获取成绩趋势数据异常", e);
//            return AjaxResult.error("获取成绩趋势失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "将通知标记为已读", description = "将指定ID的通知标记为已读")
//    @PutMapping("/notifications/{notificationId}/read")
//    public AjaxResult markNotificationAsRead(@PathVariable Long notificationId) {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("标记通知已读失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到标记通知已读请求: userId={}, 通知ID: {}", userId, notificationId);
//            // TODO: 调用通知服务更新状态
//            return AjaxResult.success("标记成功");
//        } catch (Exception e) {
//            log.error("标记通知已读异常", e);
//            return AjaxResult.error("标记失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "将所有通知标记为已读", description = "将当前用户的所有通知标记为已读")
//    @PutMapping("/notifications/read-all")
//    public AjaxResult markAllNotificationsAsRead() {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("标记所有通知已读失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//            log.info("接收到标记所有通知已读请求: userId={}", userId);
//            // TODO: 调用通知服务更新状态
//            return AjaxResult.success("全部标记成功");
//        } catch (Exception e) {
//            log.error("标记所有通知已读异常", e);
//            return AjaxResult.error("标记失败: " + e.getMessage());
//        }
//    }
//}