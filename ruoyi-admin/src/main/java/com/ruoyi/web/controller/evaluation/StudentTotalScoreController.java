//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.Parameter;
//import io.swagger.v3.oas.annotations.media.Content;
//import io.swagger.v3.oas.annotations.media.Schema;
//import io.swagger.v3.oas.annotations.responses.ApiResponse;
//import io.swagger.v3.oas.annotations.responses.ApiResponses;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Slf4j
//@RestController
//@RequestMapping("/student-total-score")
//@Tag(name = "学生总分管理", description = "提供学生测评总分的查询及相关操作API接口")
//public class StudentTotalScoreController {
//
//    @Autowired
//    private IStudentTotalScoreService studentTotalScoreService;
//
//    @Operation(
//        summary = "根据学生ID和测评体系ID获取总分",
//        description = "获取指定学生在指定测评体系下的总分信息"
//    )
//    @ApiResponses({
//        @ApiResponse(responseCode = "200", description = "查询成功", content = @Content(schema = @Schema(implementation = StudentTotalScore.class))),
//        @ApiResponse(responseCode = "404", description = "未找到相关总分记录", content = @Content(schema = @Schema(type = "string")))
//    })
//    @GetMapping("/student/{studentId}/system/{systemId}")
//    @PreAuthorize("hasRole('STUDENT') or hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult getScoreByStudentAndSystem(
//            @Parameter(name = "studentId", description = "学生ID", required = true)
//            @PathVariable Long studentId,
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("获取学生总分请求: studentId={}, systemId={}", studentId, systemId);
//            return studentTotalScoreService.findByStudentIdAndSystemId(studentId, systemId);
//        } catch (Exception e) {
//            log.error("获取学生总分异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取学生在所有测评体系的总分",
//        description = "获取指定学生在所有测评体系下的总分信息"
//    )
//    @GetMapping("/student/{studentId}")
//    @PreAuthorize("hasRole('STUDENT') or hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult getScoresByStudentId(
//            @Parameter(name = "studentId", description = "学生ID", required = true)
//            @PathVariable Long studentId) {
//        try {
//            log.info("获取学生所有测评体系总分请求: studentId={}", studentId);
//            return studentTotalScoreService.findByStudentId(studentId);
//        } catch (Exception e) {
//            log.error("获取学生所有测评体系总分异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评体系下所有学生的总分",
//        description = "获取指定测评体系下所有学生的总分信息"
//    )
//    @GetMapping("/system/{systemId}")
//    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult getScoresBySystemId(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("获取测评体系所有学生总分请求: systemId={}", systemId);
//            return studentTotalScoreService.findBySystemId(systemId);
//        } catch (Exception e) {
//            log.error("获取测评体系所有学生总分异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "保存或更新学生总分",
//        description = "保存或更新指定学生在指定测评体系下的总分信息"
//    )
//    @PostMapping
//    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult saveOrUpdateScore(@RequestBody StudentTotalScore score) {
//        try {
//            log.info("保存或更新学生总分请求: studentId={}, systemId={}", score.getStudentId(), score.getSystemId());
//            boolean saveResult = studentTotalScoreService.saveOrUpdate(score);
//            if (saveResult) {
//                log.info("保存或更新学生总分成功: scoreId={}", score.getId());
//                return AjaxResult.success("保存成功", score);
//            } else {
//                log.error("保存或更新学生总分失败");
//                return AjaxResult.error("保存失败");
//            }
//        } catch (Exception e) {
//            log.error("保存或更新学生总分异常", e);
//            return AjaxResult.error("保存失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "批量计算学生总分",
//        description = "根据测评体系ID批量计算并更新学生总分"
//    )
//    @PostMapping("/calculate/{systemId}")
//    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult calculateScores(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("批量计算学生总分请求: systemId={}", systemId);
//            return studentTotalScoreService.calculateAllScoresBySystemId(systemId);
//        } catch (Exception e) {
//            log.error("批量计算学生总分异常", e);
//            return AjaxResult.error("计算失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "根据总分范围查询学生",
//        description = "在指定测评体系下，根据总分范围查询学生信息"
//    )
//    @GetMapping("/range")
//    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult getScoresByRange(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @RequestParam Long systemId,
//            @Parameter(name = "minScore", description = "最低分数", required = true)
//            @RequestParam Double minScore,
//            @Parameter(name = "maxScore", description = "最高分数", required = true)
//            @RequestParam Double maxScore) {
//        try {
//            log.info("根据总分范围查询学生请求: systemId={}, minScore={}, maxScore={}", systemId, minScore, maxScore);
//            return studentTotalScoreService.findByScoreRange(systemId, minScore, maxScore);
//        } catch (Exception e) {
//            log.error("根据总分范围查询学生异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评体系下学生总分排名",
//        description = "获取指定测评体系下学生总分的排名信息"
//    )
//    @GetMapping("/ranking/system/{systemId}")
//    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult getRankingBySystemId(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("获取学生总分排名请求: systemId={}", systemId);
//            return studentTotalScoreService.getRankingBySystemId(systemId);
//        } catch (Exception e) {
//            log.error("获取学生总分排名异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "删除学生总分记录",
//        description = "删除指定的学生总分记录"
//    )
//    @DeleteMapping("/{id}")
//    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
//    public AjaxResult deleteScore(
//            @Parameter(name = "id", description = "总分记录ID", required = true)
//            @PathVariable Long id) {
//        try {
//            log.info("删除学生总分记录请求: id={}", id);
//            boolean deleteResult = studentTotalScoreService.removeById(id);
//            if (deleteResult) {
//                log.info("删除学生总分记录成功: id={}", id);
//                return AjaxResult.success("删除成功");
//            } else {
//                log.error("删除学生总分记录失败");
//                return AjaxResult.error("删除失败");
//            }
//        } catch (Exception e) {
//            log.error("删除学生总分记录异常", e);
//            return AjaxResult.error("删除失败: " + e.getMessage());
//        }
//    }
//}