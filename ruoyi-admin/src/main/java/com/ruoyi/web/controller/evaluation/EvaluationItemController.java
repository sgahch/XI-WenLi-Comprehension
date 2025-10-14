//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.system.domain.evaluation.EvaluationItem;
//import com.ruoyi.system.service.evaluation.IEvaluationItemService;
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
//import java.util.List;
//import java.util.Map;
//
//@Slf4j
//@RestController
//@RequestMapping("/evaluation-item")
//@Tag(name = "测评项管理", description = "提供测评项的CRUD及相关操作API接口")
//public class EvaluationItemController {
//
//    @Autowired
//    private IEvaluationItemService evaluationItemService;
//
//    @Operation(
//        summary = "根据测评体系ID获取测评项列表",
//        description = "获取指定测评体系下的所有测评项信息"
//    )
//    @ApiResponses({
//        @ApiResponse(responseCode = "200", description = "查询成功", content = @Content(schema = @Schema(implementation = EvaluationItem.class, type = "array"))),
//        @ApiResponse(responseCode = "500", description = "查询失败", content = @Content(schema = @Schema(type = "string")))
//    })
//    @GetMapping("/system/{systemId}")
//    public AjaxResult getItemsBySystemId(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("根据测评体系ID获取测评项列表请求: systemId={}", systemId);
//            return evaluationItemService.findBySystemId(systemId);
//        } catch (Exception e) {
//            log.error("根据测评体系ID获取测评项列表异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "根据测评体系ID获取模块列表",
//        description = "获取指定测评体系下的所有模块信息"
//    )
//    @GetMapping("/system/{systemId}/modules")
//    public AjaxResult getModulesBySystemId(
//            @Parameter(name = "systemId", description = "测评体系ID", required = true)
//            @PathVariable Long systemId) {
//        try {
//            log.info("根据测评体系ID获取模块列表请求: systemId={}", systemId);
//            return evaluationItemService.findModulesBySystemId(systemId);
//        } catch (Exception e) {
//            log.error("根据测评体系ID获取模块列表异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "根据父项ID获取子项列表",
//        description = "获取指定父项ID下的所有子项信息"
//    )
//    @GetMapping("/parent/{parentId}")
//    public AjaxResult getItemsByParentId(
//            @Parameter(name = "parentId", description = "父项ID", required = true)
//            @PathVariable Long parentId) {
//        try {
//            log.info("根据父项ID获取子项列表请求: parentId={}", parentId);
//            return evaluationItemService.findItemsByParentId(parentId);
//        } catch (Exception e) {
//            log.error("根据父项ID获取子项列表异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "设置测评项权重",
//        description = "设置指定测评项的权重值"
//    )
//    @PutMapping("/{itemId}/weight")
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult setItemWeight(
//            @Parameter(name = "itemId", description = "测评项ID", required = true)
//            @PathVariable Long itemId,
//            @RequestBody Map<String, Double> weightRequest) {
//        try {
//            Double weightValue = weightRequest.get("weight");
//            java.math.BigDecimal weight = java.math.BigDecimal.valueOf(weightValue);
//            log.info("设置测评项权重请求: itemId={}, weight={}", itemId, weight);
//            return evaluationItemService.setItemWeight(itemId, weight);
//        } catch (Exception e) {
//            log.error("设置测评项权重异常", e);
//            return AjaxResult.error("设置失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "更新测评项评分规则",
//        description = "更新指定测评项的评分规则"
//    )
//    @PutMapping("/{itemId}/score-rule")
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult updateScoreRule(
//            @Parameter(name = "itemId", description = "测评项ID", required = true)
//            @PathVariable Long itemId,
//            @RequestBody Map<String, Object> scoreRuleRequest) {
//        try {
//            log.info("更新测评项评分规则请求: itemId={}", itemId);
//            String scoreRule = scoreRuleRequest.get("scoreRule").toString();
//            return evaluationItemService.updateScoreRule(itemId, scoreRule);
//        } catch (Exception e) {
//            log.error("更新测评项评分规则异常", e);
//            return AjaxResult.error("更新失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "批量保存测评项",
//        description = "批量保存或更新多个测评项信息"
//    )
//    @PostMapping("/batch")
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult batchSave(@RequestBody List<EvaluationItem> evaluationItems) {
//        try {
//            log.info("批量保存测评项请求: 共{}条记录", evaluationItems.size());
//            return evaluationItemService.batchSave(evaluationItems);
//        } catch (Exception e) {
//            log.error("批量保存测评项异常", e);
//            return AjaxResult.error("保存失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "根据测评项类型获取测评项列表",
//        description = "获取指定类型的所有测评项信息"
//    )
//    @GetMapping("/type/{itemType}")
//    public AjaxResult getItemsByType(
//            @Parameter(name = "itemType", description = "测评项类型", required = true)
//            @PathVariable String itemType) {
//        try {
//            log.info("根据测评项类型获取测评项列表请求: itemType={}", itemType);
//            return evaluationItemService.findByItemType(itemType);
//        } catch (Exception e) {
//            log.error("根据测评项类型获取测评项列表异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取测评项详情",
//        description = "获取指定测评项的详细信息"
//    )
//    @GetMapping("/{itemId}")
//    public AjaxResult getItemById(
//            @Parameter(name = "itemId", description = "测评项ID", required = true)
//            @PathVariable Long itemId) {
//        try {
//            log.info("获取测评项详情请求: itemId={}", itemId);
//            // 直接调用服务方法，它会返回AjaxResult
//            return AjaxResult.success(evaluationItemService.getById(itemId));
//        } catch (Exception e) {
//            log.error("获取测评项详情异常", e);
//            return AjaxResult.error("查询失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "创建测评项",
//        description = "创建新的测评项信息"
//    )
//    @PostMapping
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult createItem(@RequestBody EvaluationItem evaluationItem) {
//        try {
//            log.info("创建测评项请求: {}", evaluationItem.getItemName());
//            boolean saveResult = evaluationItemService.save(evaluationItem);
//            if (saveResult) {
//                log.info("创建测评项成功: itemId={}", evaluationItem.getId());
//                return AjaxResult.success("创建成功", evaluationItem);
//            } else {
//                log.error("创建测评项失败");
//                return AjaxResult.error("创建失败");
//            }
//        } catch (Exception e) {
//            log.error("创建测评项异常", e);
//            return AjaxResult.error("创建失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "更新测评项",
//        description = "更新指定测评项的信息"
//    )
//    @PutMapping
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult updateItem(@RequestBody EvaluationItem evaluationItem) {
//        try {
//            log.info("更新测评项请求: itemId={}", evaluationItem.getId());
//            boolean updateResult = evaluationItemService.updateById(evaluationItem);
//            if (updateResult) {
//                log.info("更新测评项成功: itemId={}", evaluationItem.getId());
//                return AjaxResult.success("更新成功");
//            } else {
//                log.error("更新测评项失败");
//                return AjaxResult.error("更新失败");
//            }
//        } catch (Exception e) {
//            log.error("更新测评项异常", e);
//            return AjaxResult.error("更新失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "删除测评项",
//        description = "删除指定测评项信息"
//    )
//    @DeleteMapping("/{itemId}")
//    @PreAuthorize("hasRole('ADMIN') or hasRole('TEACHER')")
//    public AjaxResult deleteItem(
//            @Parameter(name = "itemId", description = "测评项ID", required = true)
//            @PathVariable Long itemId) {
//        try {
//            log.info("删除测评项请求: itemId={}", itemId);
//            boolean deleteResult = evaluationItemService.removeById(itemId);
//            if (deleteResult) {
//                log.info("删除测评项成功: itemId={}", itemId);
//                return AjaxResult.success("删除成功");
//            } else {
//                log.error("删除测评项失败");
//                return AjaxResult.error("删除失败");
//            }
//        } catch (Exception e) {
//            log.error("删除测评项异常", e);
//            return AjaxResult.error("删除失败: " + e.getMessage());
//        }
//    }
//}