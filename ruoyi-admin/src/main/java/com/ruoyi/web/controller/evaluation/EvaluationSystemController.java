//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.system.domain.evaluation.EvaluationSystem;
//import com.ruoyi.system.service.evaluation.IEvaluationSystemService;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.Parameter;
//import io.swagger.v3.oas.annotations.media.Content;
//import io.swagger.v3.oas.annotations.media.Schema;
//import io.swagger.v3.oas.annotations.responses.ApiResponse;
//import io.swagger.v3.oas.annotations.responses.ApiResponses;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@Slf4j
//@RestController
//@RequestMapping("/evaluation-system")
//@Tag(name = "测评体系管理", description = "提供测评体系相关的API接口")
//public class EvaluationSystemController {
//
//    @Autowired
//    private IEvaluationSystemService evaluationSystemService;
//
//    @Operation(
//        summary = "获取当前生效的测评体系",
//        description = "查询当前正在使用的测评体系，返回体系的详细信息包括名称、学年、学期等"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "当前没有生效的测评体系")
//    })
//    @GetMapping("/current")
//    public AjaxResult getCurrentSystem() {
//        try {
//            log.info("获取当前生效的测评体系请求");
//            AjaxResult result = evaluationSystemService.getCurrentSystem();
//            if (result != null && result.isSuccess()) {
//                log.info("获取当前生效的测评体系成功");
//                return result;
//            }
//            log.warn("当前没有生效的测评体系");
//            return AjaxResult.error("当前没有生效的测评体系");
//        } catch (Exception e) {
//            log.error("获取当前生效的测评体系时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取测评体系失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评体系列表",
//        description = "查询所有测评体系，支持按条件筛选"
//    )
//    @GetMapping
//    public AjaxResult getSystemList() {
//        try {
//            log.info("获取测评体系列表请求");
//            // 使用默认分页参数获取所有体系
//            AjaxResult result = evaluationSystemService.findAll(1, 1000);
//            log.info("获取测评体系列表成功");
//            return result;
//        } catch (Exception e) {
//            log.error("获取测评体系列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取测评体系列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "启用测评体系",
//        description = "将指定的测评体系设置为当前生效的体系"
//    )
//    @PutMapping("/{systemId}/enable")
//    public AjaxResult enableSystem(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("启用测评体系请求，体系ID: {}", systemId);
//            AjaxResult result = evaluationSystemService.enableSystem(systemId);
//            if (result.isSuccess()) {
//                log.info("测评体系启用成功，体系ID: {}", systemId);
//            } else {
//                log.warn("测评体系启用失败，体系ID: {}", systemId);
//            }
//            return result;
//        } catch (Exception e) {
//            log.error("启用测评体系时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("启用测评体系失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "关闭测评体系",
//        description = "关闭指定的测评体系"
//    )
//    @PutMapping("/{systemId}/close")
//    public AjaxResult closeSystem(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("关闭测评体系请求，体系ID: {}", systemId);
//            AjaxResult result = evaluationSystemService.closeSystem(systemId);
//            if (result.isSuccess()) {
//                log.info("测评体系关闭成功，体系ID: {}", systemId);
//            } else {
//                log.warn("测评体系关闭失败，体系ID: {}", systemId);
//            }
//            return result;
//        } catch (Exception e) {
//            log.error("关闭测评体系时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("关闭测评体系失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "添加测评体系",
//        description = "创建新的测评体系"
//    )
//    @PostMapping
//    public AjaxResult addSystem(
//            @Parameter(name = "system", description = "测评体系信息", required = true)
//            @RequestBody EvaluationSystem system) {
//        try {
//            log.info("添加测评体系请求，体系名称: {}", system.getSystemName());
//            AjaxResult result = evaluationSystemService.insertEvaluationSystem(system);
//            if (result.isSuccess()) {
//                log.info("添加测评体系成功，体系ID: {}", system.getId());
//            } else {
//                log.warn("添加测评体系失败，体系名称: {}", system.getSystemName());
//            }
//            return result;
//        } catch (Exception e) {
//            log.error("添加测评体系时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("添加测评体系失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "更新测评体系",
//        description = "更新指定ID的测评体系信息"
//    )
//    @PutMapping("/{systemId}")
//    public AjaxResult updateSystem(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId,
//            @Parameter(name = "system", description = "更新后的测评体系信息", required = true)
//            @RequestBody EvaluationSystem system) {
//        try {
//            log.info("更新测评体系请求，体系ID: {}", systemId);
//            system.setId(systemId);
//            AjaxResult result = evaluationSystemService.updateEvaluationSystem(system);
//            if (result.isSuccess()) {
//                log.info("更新测评体系成功，体系ID: {}", systemId);
//            } else {
//                log.warn("更新测评体系失败，体系ID: {}", systemId);
//            }
//            return result;
//        } catch (Exception e) {
//            log.error("更新测评体系时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("更新测评体系失败: " + e.getMessage());
//        }
//    }
//}