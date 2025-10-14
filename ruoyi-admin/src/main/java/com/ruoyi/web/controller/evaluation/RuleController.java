//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.system.domain.evaluation.EvaluationRule;
//import com.ruoyi.system.service.evaluation.EvaluationRuleService;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.Parameter;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
///**
// * 考评规则控制器
// * 实现需求文档中的规则配置API
// */
//@Slf4j
//@RestController
//@RequestMapping("/api/rules")
//@RequiredArgsConstructor
//@Tag(name = "考评规则管理", description = "考评规则配置相关接口")
//public class RuleController {
//
//    private final EvaluationRuleService ruleService;
//
//    /**
//     * 添加学院考评规则
//     * POST /api/rules/college
//     */
//    @PostMapping("/college")
//    @Operation(summary = "添加学院考评规则", description = "管理员为学院配置考评规则")
//    public AjaxResult addCollegeRule(@RequestBody AddRuleRequest request) {
//        try {
//            log.info("添加学院考评规则：collegeId={}, semester={}", request.getCollegeId(), request.getSemester());
//
//            String ruleId = ruleService.addCollegeRule(request.getCollegeId(), request.getIndicators(), request.getSemester());
//
//            return AjaxResult.success("规则添加成功", ruleId);
//
//        } catch (EvaluationRuleService.BusinessException e) {
//            log.error("添加学院考评规则失败：{}", e.getMessage());
//            return AjaxResult.error(e.getMessage());
//        } catch (Exception e) {
//            log.error("添加学院考评规则失败：", e);
//            return AjaxResult.error("规则添加失败：" + e.getMessage());
//        }
//    }
//
//    /**
//     * 调整考评维度权重
//     * PUT /api/rules/{ruleId}/adjust
//     */
//    @PutMapping("/{ruleId}/adjust")
//    @Operation(summary = "调整考评维度权重", description = "管理员调整现有规则的指标权重")
//    public AjaxResult adjustRule(
//            @Parameter(name = "ruleId", description = "规则ID", required = true)
//            @PathVariable String ruleId,
//            @RequestBody List<EvaluationRuleService.Indicator> indicators) {
//
//        try {
//            log.info("调整考评规则权重：ruleId={}", ruleId);
//
//            EvaluationRuleService.RuleAdjustResult result = ruleService.adjustRule(ruleId, indicators);
//
//            if (result.isSuccess()) {
//                return AjaxResult.success(result.getMessage(), ruleId);
//            } else {
//                return AjaxResult.error(result.getMessage());
//            }
//
//        } catch (Exception e) {
//            log.error("调整考评规则权重失败：ruleId={}, error={}", ruleId, e.getMessage(), e);
//            return AjaxResult.error("权重调整失败：" + e.getMessage());
//        }
//    }
//
//    /**
//     * 获取学院当前考评规则
//     * GET /api/rules/college/{collegeId}/current
//     */
//    @GetMapping("/college/{collegeId}/current")
//    @Operation(summary = "获取学院当前考评规则", description = "查询学院当前生效的考评规则")
//    public AjaxResult getCurrentRule(
//            @Parameter(name = "collegeId", description = "学院ID", required = true)
//            @PathVariable String collegeId,
//            @Parameter(name = "semester", description = "学期", required = true)
//            @RequestParam String semester) {
//
//        try {
//            EvaluationRule rule = ruleService.getCurrentRule(collegeId, semester);
//
//            if (rule != null) {
//                return AjaxResult.success("查询成功", rule);
//            } else {
//                return AjaxResult.error("未找到该学院在此学期的考评规则");
//            }
//
//        } catch (Exception e) {
//            log.error("查询学院考评规则失败：collegeId={}, semester={}, error={}", collegeId, semester, e.getMessage(), e);
//            return AjaxResult.error("查询失败：" + e.getMessage());
//        }
//    }
//
//    /**
//     * 添加规则请求类
//     */
//    public static class AddRuleRequest {
//        private String collegeId;
//        private List<EvaluationRuleService.Indicator> indicators;
//        private String semester;
//
//        // Getters and Setters
//        public String getCollegeId() { return collegeId; }
//        public void setCollegeId(String collegeId) { this.collegeId = collegeId; }
//        public List<EvaluationRuleService.Indicator> getIndicators() { return indicators; }
//        public void setIndicators(List<EvaluationRuleService.Indicator> indicators) { this.indicators = indicators; }
//        public String getSemester() { return semester; }
//        public void setSemester(String semester) { this.semester = semester; }
//    }
//}