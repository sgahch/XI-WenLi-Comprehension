//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.system.domain.evaluation.dto.EvaluationDTO;
//import com.ruoyi.system.service.evaluation.IEvaluationService;
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
//import java.util.Map;
//
//@Slf4j
//@RestController
//@RequestMapping("/evaluation")
//@Tag(name = "测评管理", description = "提供测评相关的API接口")
//public class EvaluationController {
//
//    @Autowired
//    private IEvaluationService evaluationService;
//
//    @Operation(summary = "测试认证", description = "测试用户是否已认证")
//    @GetMapping("/test-auth")
//    public AjaxResult testAuth() {
//        try {
//            log.info("测试认证请求");
//            return evaluationService.testAuth();
//        } catch (Exception e) {
//            log.error("测试认证时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("测试认证失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "创建测评",
//        description = "创建新的测评项目"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "创建成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "400", description = "创建参数错误"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PostMapping
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult createEvaluation(
//            @Parameter(name = "evaluationDTO", description = "测评信息DTO对象", required = true)
//            @RequestBody EvaluationDTO evaluationDTO) {
//        try {
//            log.info("创建测评请求，测评评论: {}", evaluationDTO.getComments());
//            return evaluationService.createEvaluation(evaluationDTO);
//        } catch (Exception e) {
//            log.error("创建测评时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("创建测评失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评列表",
//        description = "查询系统中的测评列表"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping
//    public AjaxResult getEvaluationList() {
//        try {
//            log.info("获取测评列表请求");
//            return evaluationService.getEvaluationList();
//        } catch (Exception e) {
//            log.error("获取测评列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取测评列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评详情",
//        description = "查询指定ID的测评详情"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "测评不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/{evaluationId}")
//    public AjaxResult getEvaluationById(
//            @Parameter(name = "evaluationId", description = "测评ID", required = true)
//            @PathVariable Long evaluationId) {
//        try {
//            log.info("获取测评详情请求，测评ID: {}", evaluationId);
//            return evaluationService.getEvaluationById(evaluationId);
//        } catch (Exception e) {
//            log.error("获取测评详情时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取测评详情失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "更新测评信息",
//        description = "更新指定ID的测评信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "更新成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "测评不存在"),
//        @ApiResponse(responseCode = "400", description = "更新参数错误"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PutMapping("/{evaluationId}")
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult updateEvaluation(
//            @Parameter(name = "evaluationId", description = "测评ID", required = true)
//            @PathVariable Long evaluationId,
//            @Parameter(name = "evaluationDTO", description = "测评信息DTO对象", required = true)
//            @RequestBody EvaluationDTO evaluationDTO) {
//        try {
//            log.info("更新测评信息请求，测评ID: {}, 测评评论: {}", evaluationId, evaluationDTO.getComments());
//            return evaluationService.updateEvaluation(evaluationId, evaluationDTO);
//        } catch (Exception e) {
//            log.error("更新测评信息时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("更新测评失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "删除测评",
//        description = "删除指定ID的测评"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "删除成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "测评不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @DeleteMapping("/{evaluationId}")
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult deleteEvaluation(
//            @Parameter(name = "evaluationId", description = "测评ID", required = true)
//            @PathVariable Long evaluationId) {
//        try {
//            log.info("删除测评请求，测评ID: {}", evaluationId);
//            return evaluationService.deleteEvaluation(evaluationId);
//        } catch (Exception e) {
//            log.error("删除测评时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("删除测评失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评分页列表",
//        description = "分页查询系统中的测评信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/page")
//    public AjaxResult getEvaluationPageList(
//            @Parameter(name = "params", description = "分页查询参数，包含pageNum, pageSize等")
//            @RequestParam Map<String, Object> params) {
//        try {
//            log.info("获取测评分页列表请求，查询参数: {}", params);
//            AjaxResult result = evaluationService.getEvaluationPageList(params);
//
//            if (result.isSuccess()) {
//                log.info("获取测评分页列表成功");
//            } else {
//                log.warn("获取测评分页列表失败，原因: {}", result.get("msg"));
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取测评分页列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取测评分页列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取用户参与的测评列表",
//        description = "查询当前用户参与的测评列表"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/user")
//    public AjaxResult getUserEvaluations() {
//        try {
//            log.info("获取用户参与的测评列表请求");
//            AjaxResult result = evaluationService.getUserEvaluations();
//
//            if (result.isSuccess()) {
//                log.info("获取用户参与的测评列表成功");
//            } else {
//                log.warn("获取用户参与的测评列表失败，原因: {}", result.get("msg"));
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取用户参与的测评列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取用户参与的测评列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "提交测评",
//        description = "提交指定ID的测评"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "提交成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "测评不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PostMapping("/{evaluationId}/submit")
//    public AjaxResult submitEvaluation(
//            @Parameter(name = "evaluationId", description = "测评ID", required = true)
//            @PathVariable Long evaluationId) {
//        try {
//            log.info("提交测评请求，测评ID: {}", evaluationId);
//            AjaxResult result = evaluationService.submitEvaluation(evaluationId);
//
//            if (result.isSuccess()) {
//                log.info("提交测评成功，测评ID: {}", evaluationId);
//            } else {
//                log.warn("提交测评失败，测评ID: {}, 原因: {}", evaluationId, result.get("msg"));
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("提交测评时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("提交测评失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评统计信息",
//        description = "获取指定ID的测评统计信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "测评不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/{evaluationId}/statistics")
//    public AjaxResult getEvaluationStatistics(
//            @Parameter(name = "evaluationId", description = "测评ID", required = true)
//            @PathVariable Long evaluationId) {
//        try {
//            log.info("获取测评统计信息请求，测评ID: {}", evaluationId);
//            AjaxResult result = evaluationService.getEvaluationStatistics(evaluationId);
//
//            if (result.isSuccess()) {
//                log.info("获取测评统计信息成功，测评ID: {}", evaluationId);
//            } else {
//                log.warn("获取测评统计信息失败，测评ID: {}, 原因: {}", evaluationId, result.get("msg"));
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取测评统计信息时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取测评统计信息失败: " + e.getMessage());
//        }
//    }
//}