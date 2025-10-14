//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.system.domain.evaluation.StudentScoreDetail;
//import com.ruoyi.system.service.evaluation.IStudentScoreDetailService;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.Parameter;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.math.BigDecimal;
//import java.util.List;
//import java.util.Map;
//
//@Slf4j
//@RestController
//@RequestMapping("/student-score")
//@Tag(name = "学生成绩明细管理", description = "提供学生成绩明细相关的API接口")
//public class StudentScoreDetailController {
//
//    @Autowired
//    private IStudentScoreDetailService studentScoreDetailService;
//
//    @Operation(summary = "根据学生ID和测评体系ID获取成绩明细", description = "查询指定学生在特定测评体系下的所有成绩明细")
//    @GetMapping
//    public AjaxResult getScoreDetailsByStudentAndSystem(
//            @Parameter(name = "studentId", description = "学生ID", required = true)
//            @RequestParam Long studentId,
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @RequestParam Long systemId) {
//        try {
//            log.info("根据学生ID和测评体系ID获取成绩明细请求，学生ID: {}, 体系ID: {}", studentId, systemId);
//            List<StudentScoreDetail> result = studentScoreDetailService.findByStudentIdAndSystemId(studentId, systemId);
//            return AjaxResult.success("获取成绩明细成功", result);
//        } catch (Exception e) {
//            log.error("根据学生ID和测评体系ID获取成绩明细时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取成绩明细失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "根据测评体系ID和状态获取成绩明细", description = "查询指定测评体系下特定状态的成绩明细")
//    @GetMapping("/system/{systemId}")
//    public AjaxResult getScoreDetailsBySystemAndStatus(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId,
//            @Parameter(name = "status", description = "成绩状态，0表示待提交，1表示待审核，2表示已通过，3表示已驳回", required = false)
//            @RequestParam(required = false) String status) {
//        try {
//            log.info("根据测评体系ID和状态获取成绩明细请求，体系ID: {}, 状态: {}", systemId, status);
//            Integer statusInt = null;
//            if (status != null) {
//                try {
//                    statusInt = Integer.parseInt(status);
//                } catch (NumberFormatException e) {
//                    log.warn("status参数格式错误: {}", status);
//                    return AjaxResult.error("status参数格式错误");
//                }
//            }
//            List<StudentScoreDetail> result = studentScoreDetailService.findBySystemIdAndStatus(systemId, statusInt);
//            return AjaxResult.success("获取成绩明细成功", result);
//        } catch (Exception e) {
//            log.error("根据测评体系ID和状态获取成绩明细时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取成绩明细失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "提交成绩", description = "提交学生的测评项目成绩")
//    @PostMapping("/submit")
//    public AjaxResult submitScore(
//            @Parameter(name = "scoreDetail", description = "成绩明细信息", required = true)
//            @RequestBody StudentScoreDetail scoreDetail) {
//        try {
//            log.info("提交成绩请求，学生ID: {}, 测评项目ID: {}",
//                    scoreDetail.getStudentId(), scoreDetail.getItemId());
//            boolean result = studentScoreDetailService.submitScore(scoreDetail);
//            return result ? AjaxResult.success("成绩提交成功") : AjaxResult.error("成绩提交失败");
//        } catch (Exception e) {
//            log.error("提交成绩时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("成绩提交失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "审核成绩", description = "审核学生提交的成绩")
//    @PutMapping("/{detailId}/audit")
//    public AjaxResult auditScore(
//            @Parameter(name = "detailId", description = "成绩明细ID", required = true)
//            @PathVariable Long detailId,
//            @Parameter(name = "auditInfo", description = "审核信息，包含status(状态)和remark(备注)", required = true)
//            @RequestBody Map<String, Object> auditInfo) {
//        try {
//            log.info("审核成绩请求，成绩明细ID: {}", detailId);
//            String statusStr = (String) auditInfo.get("status");
//            String remark = (String) auditInfo.get("remark");
//            Integer status = null;
//            if (statusStr != null) {
//                try {
//                    status = Integer.parseInt(statusStr);
//                } catch (NumberFormatException e) {
//                    log.warn("status参数格式错误: {}", statusStr);
//                    return AjaxResult.error("status参数格式错误");
//                }
//            }
//            // auditorId 可根据实际需求获取，这里传 null
//            boolean result = studentScoreDetailService.auditScore(detailId, status, remark, null);
//            return result ? AjaxResult.success("成绩审核成功") : AjaxResult.error("成绩审核失败");
//        } catch (Exception e) {
//            log.error("审核成绩时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("成绩审核失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "批量导入成绩", description = "通过Excel文件批量导入学生成绩")
//    @PostMapping("/batch-import")
//    public AjaxResult batchImport(
//            @Parameter(name = "file", description = "包含成绩信息的Excel文件", required = true)
//            @RequestParam("file") MultipartFile file) {
//        try {
//            log.info("批量导入成绩请求，文件名: {}", file.getOriginalFilename());
//            List<StudentScoreDetail> result = studentScoreDetailService.batchImport(file);
//            return AjaxResult.success("批量导入成功", result);
//        } catch (Exception e) {
//            log.error("批量导入成绩时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("批量导入失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "更新成绩", description = "更新指定成绩明细的分数")
//    @PutMapping("/{detailId}")
//    public AjaxResult updateScore(
//            @Parameter(name = "detailId", description = "成绩明细ID", required = true)
//            @PathVariable Long detailId,
//            @Parameter(name = "scoreInfo", description = "分数信息，包含score字段", required = true)
//            @RequestBody Map<String, Double> scoreInfo) {
//        try {
//            log.info("更新成绩请求，成绩明细ID: {}", detailId);
//            Double score = scoreInfo.get("score");
//            BigDecimal scoreDecimal = score != null ? BigDecimal.valueOf(score) : null;
//            // evidenceUrl 可根据实际需求获取，这里传 null
//            boolean result = studentScoreDetailService.updateScore(detailId, scoreDecimal, null);
//            if (result) {
//                log.info("成绩更新成功，成绩明细ID: {}, 新分数: {}", detailId, scoreDecimal);
//                return AjaxResult.success("成绩更新成功");
//            }
//            log.warn("成绩更新失败，成绩明细ID: {}", detailId);
//            return AjaxResult.error("成绩更新失败");
//        } catch (Exception e) {
//            log.error("更新成绩时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("成绩更新失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "获取待审核成绩数量", description = "统计指定测评体系下待审核的成绩数量")
//    @GetMapping("/pending-audit/count")
//    public AjaxResult countPendingAudit(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @RequestParam Long systemId) {
//        try {
//            log.info("获取待审核成绩数量请求，体系ID: {}", systemId);
//            int count = studentScoreDetailService.countPendingAudit(systemId);
//            log.info("获取待审核成绩数量成功，体系ID: {}, 待审核数量: {}", systemId, count);
//            return AjaxResult.success("获取待审核数量成功", count);
//        } catch (Exception e) {
//            log.error("获取待审核成绩数量时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取待审核数量失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(summary = "根据项目ID获取成绩明细", description = "查询指定测评项目下的所有学生成绩明细")
//    @GetMapping("/item/{itemId}")
//    public AjaxResult getScoreDetailsByItemId(
//            @Parameter(name = "itemId", description = "测评项目ID", required = true)
//            @PathVariable Long itemId) {
//        try {
//            log.info("根据项目ID获取成绩明细请求，项目ID: {}", itemId);
//            List<StudentScoreDetail> scoreDetails = studentScoreDetailService.findByItemId(itemId);
//            log.info("根据项目ID获取成绩明细成功，项目ID: {}, 共找到 {} 条记录", itemId, scoreDetails.size());
//            return AjaxResult.success("获取成绩明细成功", scoreDetails);
//        } catch (Exception e) {
//            log.error("根据项目ID获取成绩明细时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取成绩明细失败: " + e.getMessage());
//        }
//    }
//}