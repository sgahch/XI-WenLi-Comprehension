//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.common.core.domain.entity.SysRole;
//import com.ruoyi.system.service.evaluation.IRoleService;
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
//@RequestMapping("/role")
//@Tag(name = "角色管理", description = "提供系统角色的管理相关API接口")
//public class RoleController {
//
//    @Autowired
//    private IRoleService roleService;
//
//    @Operation(
//        summary = "获取所有角色列表",
//        description = "查询系统中所有可用的角色信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/list")
//    public AjaxResult getAllRoles() {
//        try {
//            log.info("获取所有角色列表请求");
//            return roleService.getAllRoles();
//        } catch (Exception e) {
//            log.error("获取所有角色列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取角色列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取角色详情",
//        description = "查询指定角色ID的详细信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "角色不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/{roleId}")
//    public AjaxResult getRoleById(
//            @Parameter(name = "roleId", description = "角色ID", required = true)
//            @PathVariable Long roleId) {
//        try {
//            log.info("获取角色详情请求，角色ID: {}", roleId);
//            AjaxResult result = roleService.getRoleById(roleId);
//
//            if (result.isSuccess()) {
//                log.info("获取角色详情成功，角色ID: {}", roleId);
//            } else {
//                log.warn("获取角色详情失败，角色ID: {}", roleId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取角色详情时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取角色详情失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "创建新角色",
//        description = "创建新的系统角色"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "创建成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "400", description = "创建参数错误"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PostMapping
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult createRole(
//            @Parameter(name = "sysRole", description = "角色信息对象", required = true)
//            @RequestBody SysRole sysRole) {
//        try {
//            log.info("创建新角色请求，角色名称: {}", sysRole.getRoleName());
//            AjaxResult result = roleService.createRole(sysRole);
//
//            if (result.isSuccess()) {
//                log.info("创建新角色成功，角色名称: {}", sysRole.getRoleName());
//            } else {
//                log.warn("创建新角色失败，角色名称: {}", sysRole.getRoleName());
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("创建新角色时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("创建角色失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "更新角色信息",
//        description = "更新指定角色的信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "更新成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "角色不存在"),
//        @ApiResponse(responseCode = "400", description = "更新参数错误"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PutMapping("/{roleId}")
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult updateRole(
//            @Parameter(name = "roleId", description = "角色ID", required = true)
//            @PathVariable Long roleId,
//            @Parameter(name = "sysRole", description = "角色信息对象", required = true)
//            @RequestBody SysRole sysRole) {
//        try {
//            log.info("更新角色信息请求，角色ID: {}, 角色名称: {}", roleId, sysRole.getRoleName());
//            AjaxResult result = roleService.updateRole(roleId, sysRole);
//
//            if (result.isSuccess()) {
//                log.info("更新角色信息成功，角色ID: {}", roleId);
//            } else {
//                log.warn("更新角色信息失败，角色ID: {}", roleId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("更新角色信息时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("更新角色失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "删除角色",
//        description = "删除指定的系统角色"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "删除成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "角色不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @DeleteMapping("/{roleId}")
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult deleteRole(
//            @Parameter(name = "roleId", description = "角色ID", required = true)
//            @PathVariable Long roleId) {
//        try {
//            log.info("删除角色请求，角色ID: {}", roleId);
//            AjaxResult result = roleService.deleteRole(roleId);
//
//            if (result.isSuccess()) {
//                log.info("删除角色成功，角色ID: {}", roleId);
//            } else {
//                log.warn("删除角色失败，角色ID: {}", roleId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("删除角色时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("删除角色失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取角色权限列表",
//        description = "查询指定角色的权限列表"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "角色不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/{roleId}/permissions")
//    public AjaxResult getRolePermissions(
//            @Parameter(name = "roleId", description = "角色ID", required = true)
//            @PathVariable Long roleId) {
//        try {
//            log.info("获取角色权限列表请求，角色ID: {}", roleId);
//            AjaxResult result = roleService.getRolePermissions(roleId);
//
//            if (result.isSuccess()) {
//                log.info("获取角色权限列表成功，角色ID: {}", roleId);
//            } else {
//                log.warn("获取角色权限列表失败，角色ID: {}", roleId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取角色权限列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取角色权限失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "更新角色权限",
//        description = "更新指定角色的权限配置"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "更新成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "角色不存在"),
//        @ApiResponse(responseCode = "400", description = "权限参数错误"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PutMapping("/{roleId}/permissions")
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult updateRolePermissions(
//            @Parameter(name = "roleId", description = "角色ID", required = true)
//            @PathVariable Long roleId,
//            @Parameter(name = "permissionIds", description = "权限ID列表", required = true)
//            @RequestBody Long[] permissionIds) {
//        try {
//            log.info("更新角色权限请求，角色ID: {}, 权限数量: {}", roleId, permissionIds.length);
//            AjaxResult result = roleService.updateRolePermissions(roleId, permissionIds);
//
//            if (result.isSuccess()) {
//                log.info("更新角色权限成功，角色ID: {}", roleId);
//            } else {
//                log.warn("更新角色权限失败，角色ID: {}", roleId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("更新角色权限时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("更新角色权限失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取角色分页列表",
//        description = "分页查询系统中的角色信息"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/page")
//    public AjaxResult getRolePageList(
//            @Parameter(name = "params", description = "分页查询参数，包含pageNum, pageSize等")
//            @RequestParam Map<String, Object> params) {
//        try {
//            log.info("获取角色分页列表请求，查询参数: {}", params);
//            AjaxResult result = roleService.getRolePageList(params);
//
//            if (result.isSuccess()) {
//                log.info("获取角色分页列表成功");
//            } else {
//                log.warn("获取角色分页列表失败，原因: {}", result.get("msg"));
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取角色分页列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取角色分页列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "获取用户角色列表",
//        description = "查询指定用户拥有的角色列表"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "获取成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "用户不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @GetMapping("/user/{userId}")
//    public AjaxResult getUserRoles(
//            @Parameter(name = "userId", description = "用户ID", required = true)
//            @PathVariable Long userId) {
//        try {
//            log.info("获取用户角色列表请求，用户ID: {}", userId);
//            AjaxResult result = roleService.getUserRoles(userId);
//
//            if (result.isSuccess()) {
//                log.info("获取用户角色列表成功，用户ID: {}", userId);
//            } else {
//                log.warn("获取用户角色列表失败，用户ID: {}", userId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("获取用户角色列表时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("获取用户角色列表失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "分配用户角色",
//        description = "为指定用户分配角色"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "分配成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "用户或角色不存在"),
//        @ApiResponse(responseCode = "400", description = "参数错误"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @PostMapping("/user/{userId}/assign")
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult assignUserRole(
//            @Parameter(name = "userId", description = "用户ID", required = true)
//            @PathVariable Long userId,
//            @Parameter(name = "roleIds", description = "角色ID列表", required = true)
//            @RequestBody Long[] roleIds) {
//        try {
//            log.info("分配用户角色请求，用户ID: {}, 角色数量: {}", userId, roleIds.length);
//            AjaxResult result = roleService.updateUserRoles(userId, roleIds);
//
//            if (result.isSuccess()) {
//                log.info("分配用户角色成功，用户ID: {}", userId);
//            } else {
//                log.warn("分配用户角色失败，用户ID: {}", userId);
//            }
//
//            return result;
//        } catch (Exception e) {
//            log.error("分配用户角色时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("分配用户角色失败: " + e.getMessage());
//        }
//    }
//
//    @Operation(
//        summary = "移除用户角色",
//        description = "移除指定用户的某个角色"
//    )
//    @ApiResponses(value = {
//        @ApiResponse(responseCode = "200", description = "移除成功",
//                    content = @Content(schema = @Schema(implementation = AjaxResult.class))),
//        @ApiResponse(responseCode = "404", description = "用户或角色不存在"),
//        @ApiResponse(responseCode = "500", description = "服务器内部错误")
//    })
//    @DeleteMapping("/user/{userId}/remove/{roleId}")
//    @PreAuthorize("hasRole('ADMIN')")
//    public AjaxResult removeUserRole(
//            @Parameter(name = "userId", description = "用户ID", required = true)
//            @PathVariable Long userId,
//            @Parameter(name = "roleId", description = "角色ID", required = true)
//            @PathVariable Long roleId) {
//        try {
//            log.info("移除用户角色请求，用户ID: {}, 角色ID: {}", userId, roleId);
//            // 实现移除用户角色的逻辑
//            return AjaxResult.success("移除用户角色成功");
//        } catch (Exception e) {
//            log.error("移除用户角色时发生异常: {}", e.getMessage(), e);
//            return AjaxResult.error("移除用户角色失败: " + e.getMessage());
//        }
//    }
//}