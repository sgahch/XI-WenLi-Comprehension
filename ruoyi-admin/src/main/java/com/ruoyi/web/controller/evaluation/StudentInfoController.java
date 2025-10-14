//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.common.utils.SecurityUtils;
//import com.ruoyi.system.service.evaluation.IStudentService;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//import java.util.*;
//
///**
// * 学生信息相关API - 使用若依框架
// * [MODIFIED] 使用SecurityUtils获取当前用户信息
// */
//@Slf4j
//@RestController
//@RequestMapping("/student-info")
//@CrossOrigin(origins = "*")
//public class StudentInfoController {
//
//    @Autowired
//    private IStudentService studentService;
//
//    /**
//     * 获取当前学生信息
//     * [MODIFIED] 使用SecurityUtils获取当前用户信息
//     */
//    @GetMapping("/me")
//    public AjaxResult getMyInfo() {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取学生信息失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//
//            log.info("成功获取学生信息: userId={}", userId);
//            // 将StudentDetailDTO包装成AjaxResult
//            return AjaxResult.success("获取学生信息成功", studentService.getStudentDetailById(userId));
//        } catch (Exception e) {
//            log.error("获取学生信息异常", e);
//            return AjaxResult.error("获取学生信息失败: " + e.getMessage());
//        }
//    }
//
//    /**
//     * 获取Dashboard统计数据
//     * [MODIFIED] 使用SecurityUtils获取当前用户信息
//     */
//    @GetMapping("/dashboard-stats")
//    public AjaxResult getDashboardStats() {
//        try {
//            // 使用若依框架获取当前用户
//            Long userId = SecurityUtils.getUserId();
//            if (userId == null) {
//                log.warn("获取Dashboard统计数据失败：未找到用户信息");
//                return AjaxResult.error("未授权或无法找到用户信息");
//            }
//
//            log.info("获取Dashboard统计数据请求: userId={}", userId);
//            Map<String, Object> stats = new HashMap<>();
//            stats.put("completedEvaluations", 5);
//            stats.put("pendingEvaluations", 2);
//            stats.put("currentScore", 89.5);
//            stats.put("unreadNotifications", 3);
//            stats.put("completionRate", 85);
//            stats.put("urgentCount", 2);
//            stats.put("scoreIncrease", 5);
//
//            return AjaxResult.success("获取统计数据成功", stats);
//        } catch (Exception e) {
//            log.error("获取Dashboard统计数据异常", e);
//            return AjaxResult.error("获取统计数据失败: " + e.getMessage());
//        }
//    }
//
//    /**
//     * 获取待办事项
//     */
//    @GetMapping("/todos")
//    public AjaxResult getTodos() {
//        List<Map<String, Object>> todos = new ArrayList<>();
//
//        Map<String, Object> todo1 = new HashMap<>();
//        todo1.put("id", 1);
//        todo1.put("title", "2024年春季学期综合测评填报");
//        todo1.put("status", "pending");
//        todo1.put("deadline", "2024-06-30T23:59:59");
//        todos.add(todo1);
//
//        Map<String, Object> todo2 = new HashMap<>();
//        todo2.put("id", 2);
//        todo2.put("title", "上传社会实践证明材料");
//        todo2.put("status", "pending");
//        todo2.put("deadline", "2024-06-15T23:59:59");
//        todos.add(todo2);
//
//        Map<String, Object> todo3 = new HashMap<>();
//        todo3.put("id", 3);
//        todo3.put("title", "填写志愿服务时长");
//        todo3.put("status", "pending");
//        todo3.put("deadline", "2024-06-20T23:59:59");
//        todos.add(todo3);
//
//        return AjaxResult.success("获取待办事项成功", todos);
//    }
//
//    /**
//     * 获取通知列表
//     */
//    @GetMapping("/notifications")
//    public AjaxResult getNotifications(@RequestParam(defaultValue = "10") int limit) {
//        List<Map<String, Object>> notifications = new ArrayList<>();
//
//        Map<String, Object> notification1 = new HashMap<>();
//        notification1.put("id", 1);
//        notification1.put("title", "2024年春季学期综合测评开始啦，请及时完成填报");
//        notification1.put("timestamp", "2025-09-14T10:30:00");
//        notification1.put("read", false);
//        notifications.add(notification1);
//
//        Map<String, Object> notification2 = new HashMap<>();
//        notification2.put("id", 2);
//        notification2.put("title", "系统将于本周六进行维护升级，请提前安排工作");
//        notification2.put("timestamp", "2025-09-13T18:00:00");
//        notification2.put("read", false);
//        notifications.add(notification2);
//
//        Map<String, Object> notification3 = new HashMap<>();
//        notification3.put("id", 3);
//        notification3.put("title", "您的2023-2024学年秋季学期综测成绩已发布");
//        notification3.put("timestamp", "2025-09-12T15:30:00");
//        notification3.put("read", true);
//        notifications.add(notification3);
//
//        return AjaxResult.success("获取通知列表成功", notifications.subList(0, Math.min(limit, notifications.size())));
//    }
//
//    /**
//     * 获取成绩趋势数据
//     */
//    @GetMapping("/score-trend")
//    public AjaxResult getScoreTrend(@RequestParam(defaultValue = "all") String semester) {
//        Map<String, Object> trendData = new HashMap<>();
//
//        List<String> periods = Arrays.asList("2022-2023春季", "2022-2023秋季", "2023-2024春季", "2023-2024秋季");
//        List<Double> scores = Arrays.asList(82.0, 85.0, 87.0, 89.5);
//
//        trendData.put("periods", periods);
//        trendData.put("scores", scores);
//
//        return AjaxResult.success("获取成绩趋势成功", trendData);
//    }
//}