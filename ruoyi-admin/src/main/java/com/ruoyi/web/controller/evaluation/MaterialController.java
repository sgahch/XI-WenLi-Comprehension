//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.annotation.Log;
//import com.ruoyi.common.core.controller.BaseController;
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.common.core.page.TableDataInfo;
//import com.ruoyi.common.enums.BusinessType;
//// import com.ruoyi.evaluation.domain.Material;  // 注释掉不存在的类
//// import com.ruoyi.evaluation.service.IMaterialService;  // 注释掉不存在的类
//import io.swagger.annotations.Api;
//import io.swagger.annotations.ApiOperation;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.web.bind.annotation.*;
//
//// import java.util.List;  // 注释掉未使用的导入
//
///**
// * 材料管理 控制器
// *
// * @author ruoyi
// */
//@Slf4j
//@RestController
//@RequestMapping("/evaluation/material")
//@Tag(name = "材料管理", description = "材料管理接口")
//@Api(tags = "材料管理")
//public class MaterialController extends BaseController {
//
//    // @Autowired
//    // private IMaterialService materialService;  // 注释掉不存在的类
//
//    /**
//     * 查询材料列表
//     */
//    // @GetMapping("/list")
//    // @Operation(summary = "查询材料列表", description = "分页查询材料列表")
//    // public TableDataInfo list(Material material) {
//    //     startPage();
//    //     List<Material> list = materialService.selectMaterialList(material);
//    //     return getDataTable(list);
//    // }
//
//    /**
//     * 获取材料详细信息
//     */
//    // @GetMapping(value = "/{id}")
//    // @Operation(summary = "获取材料详细信息", description = "根据ID获取材料详细信息")
//    // public AjaxResult getInfo(@PathVariable("id") Long id) {
//    //     return AjaxResult.success(materialService.selectMaterialById(id));
//    // }
//
//    /**
//     * 新增材料
//     */
//    // @Log(title = "材料管理", businessType = BusinessType.INSERT)
//    // @PostMapping
//    // @PreAuthorize("@ss.hasPermi('evaluation:material:add')")
//    // @Operation(summary = "新增材料", description = "新增材料信息")
//    // public AjaxResult add(@RequestBody Material material) {
//    //     return toAjax(materialService.insertMaterial(material));
//    // }
//
//    /**
//     * 修改材料
//     */
//    // @Log(title = "材料管理", businessType = BusinessType.UPDATE)
//    // @PutMapping
//    // @PreAuthorize("@ss.hasPermi('evaluation:material:edit')")
//    // @Operation(summary = "修改材料", description = "修改材料信息")
//    // public AjaxResult edit(@RequestBody Material material) {
//    //     return toAjax(materialService.updateMaterial(material));
//    // }
//
//    /**
//     * 删除材料
//     */
//    // @Log(title = "材料管理", businessType = BusinessType.DELETE)
//    // @DeleteMapping("/{ids}")
//    // @PreAuthorize("@ss.hasPermi('evaluation:material:remove')")
//    // @Operation(summary = "删除材料", description = "批量删除材料信息")
//    // public AjaxResult remove(@PathVariable Long[] ids) {
//    //     return toAjax(materialService.deleteMaterialByIds(ids));
//    // }
//
//    /**
//     * 提交材料审核
//     */
//    // @PostMapping("/submit/{id}")
//    // @Operation(summary = "提交材料审核", description = "提交材料进行审核")
//    // public AjaxResult submitForReview(@PathVariable("id") Long id) {
//    //     try {
//    //         log.info("提交材料审核：id={}", id);
//    //         boolean result = materialService.submitForReview(id);
//    //         return result ? AjaxResult.success("提交成功") : AjaxResult.error("提交失败");
//    //     } catch (Exception e) {
//    //         log.error("提交材料审核失败：id={}, error={}", id, e.getMessage(), e);
//    //         return AjaxResult.error("提交失败：" + e.getMessage());
//    //     }
//    // }
//
//    /**
//     * 审核材料（教师用）
//     */
//    // @PostMapping("/review-teacher")
//    // @Operation(summary = "教师审核材料", description = "教师审核材料")
//    // public AjaxResult reviewByTeacher(@RequestParam Long id,
//    //                                 @RequestParam Integer status,
//    //                                 @RequestParam(required = false) String comment) {
//    //     try {
//    //         log.info("教师审核材料：id={}, status={}, comment={}", id, status, comment);
//    //         boolean result = materialService.reviewByTeacher(id, status, comment);
//    //         return result ? AjaxResult.success("审核成功") : AjaxResult.error("审核失败");
//    //     } catch (Exception e) {
//    //         log.error("教师审核材料失败：id={}, status={}, comment={}, error={}", id, status, comment, e.getMessage(), e);
//    //         return AjaxResult.error("审核失败：" + e.getMessage());
//    //     }
//    // }
//
//    /**
//     * 审核材料（管理员用）
//     */
//    // @PostMapping("/review-admin")
//    // @Operation(summary = "管理员审核材料", description = "管理员审核材料")
//    // public AjaxResult reviewByAdmin(@RequestParam Long id,
//    //                               @RequestParam Integer status,
//    //                               @RequestParam(required = false) String comment) {
//    //     try {
//    //         log.info("管理员审核材料：id={}, status={}, comment={}", id, status, comment);
//    //         boolean result = materialService.reviewByAdmin(id, status, comment);
//    //         return result ? AjaxResult.success("审核成功") : AjaxResult.error("审核失败");
//    //     } catch (Exception e) {
//    //         log.error("管理员审核材料失败：id={}, status={}, comment={}, error={}", id, status, comment, e.getMessage(), e);
//    //         return AjaxResult.error("审核失败：" + e.getMessage());
//    //     }
//    // }
//
//    /**
//     * 查询待审核材料（教师用）
//     */
//    // @GetMapping("/pending-teacher")
//    // @Operation(summary = "查询待教师审核材料", description = "教师查询待审核的材料列表")
//    // public AjaxResult getPendingTeacherRecords(@RequestParam String teacherId) {
//    //     try {
//    //         log.info("查询待教师审核材料：teacherId={}", teacherId);
//    //         return AjaxResult.success("查询成功");
//    //     } catch (Exception e) {
//    //         log.error("查询待教师审核材料失败：teacherId={}, error={}", teacherId, e.getMessage(), e);
//    //         return AjaxResult.error("查询失败：" + e.getMessage());
//    //     }
//    // }
//
//    /**
//     * 查询待审核材料（辅导员用）
//     */
//    // @GetMapping("/pending-teacher")
//    // @Operation(summary = "查询待辅导员审核材料", description = "辅导员查询待审核的材料列表")
//    // public AjaxResult getPendingTeacherRecords(@RequestParam String collegeId) {
//    //     try {
//    //         log.info("查询待辅导员审核材料：collegeId={}", collegeId);
//    //         return AjaxResult.success("查询成功");
//    //     } catch (Exception e) {
//    //         log.error("查询待辅导员审核材料失败：collegeId={}, error={}", collegeId, e.getMessage(), e);
//    //         return AjaxResult.error("查询失败：" + e.getMessage());
//    //     }
//    // }
//}