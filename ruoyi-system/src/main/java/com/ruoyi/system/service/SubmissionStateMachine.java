package com.ruoyi.system.service;

import com.ruoyi.common.constant.SubmissionStatusConstants;
import com.ruoyi.common.constant.AuditOperationConstants;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 综测填报状态机管理
 * 负责管理填报记录的状态流转逻辑和权限校验
 * 
 * @author ruoyi
 */
@Component
public class SubmissionStateMachine 
{
    /** 班委角色ID */
    private static final Long MONITOR_ROLE_ID = 101L;
    
    /** 辅导员角色ID */
    private static final Long COUNSELOR_ROLE_ID = 102L;
    
    /** 管理员角色ID */
    private static final Long ADMIN_ROLE_ID = 1L;
    
    /**
     * 计算状态流转后的新状态
     * 
     * @param currentStatus 当前状态
     * @param operation 操作类型
     * @param auditorRoleIds 审核人角色ID列表
     * @return 新状态
     * @throws IllegalStateException 如果状态流转不合法
     */
    public Integer calculateNextStatus(Integer currentStatus, String operation, List<Long> auditorRoleIds) 
    {
        // 验证操作类型
        if (!AuditOperationConstants.isValidOperation(operation)) 
        {
            throw new IllegalArgumentException("无效的审核操作类型: " + operation);
        }
        
        // 验证当前状态
        if (!SubmissionStatusConstants.isValidStatus(currentStatus)) 
        {
            throw new IllegalArgumentException("无效的当前状态: " + currentStatus);
        }
        
        // 驳回操作：直接返回驳回状态
        if (AuditOperationConstants.REJECT.equals(operation)) 
        {
            return SubmissionStatusConstants.REJECTED;
        }
        
        // 审核通过操作：根据当前状态和审核人角色决定下一状态
        if (AuditOperationConstants.APPROVE.equals(operation)) 
        {
            // 待班委审核 -> 待辅导员审核
            if (SubmissionStatusConstants.PENDING_MONITOR_AUDIT.equals(currentStatus)) 
            {
                // 验证审核人是否有班委或管理员权限
                if (!hasMonitorOrAdminRole(auditorRoleIds)) 
                {
                    throw new IllegalStateException("当前用户无权审核此记录（需要班委或管理员权限）");
                }
                return SubmissionStatusConstants.PENDING_COUNSELOR_AUDIT;
            }
            
            // 待辅导员审核 -> 已通过
            if (SubmissionStatusConstants.PENDING_COUNSELOR_AUDIT.equals(currentStatus)) 
            {
                // 验证审核人是否有辅导员或管理员权限
                if (!hasCounselorOrAdminRole(auditorRoleIds)) 
                {
                    throw new IllegalStateException("当前用户无权审核此记录（需要辅导员或管理员权限）");
                }
                return SubmissionStatusConstants.APPROVED;
            }
            
            // 其他状态不允许审核通过
            throw new IllegalStateException("当前状态不允许审核通过操作: " + SubmissionStatusConstants.getStatusDesc(currentStatus));
        }
        
        // 提交操作：草稿或驳回 -> 待班委审核
        if (AuditOperationConstants.SUBMIT.equals(operation)) 
        {
            if (SubmissionStatusConstants.canSubmit(currentStatus)) 
            {
                return SubmissionStatusConstants.PENDING_MONITOR_AUDIT;
            }
            throw new IllegalStateException("当前状态不允许提交操作: " + SubmissionStatusConstants.getStatusDesc(currentStatus));
        }
        
        throw new IllegalStateException("未知的状态流转场景");
    }
    
    /**
     * 验证用户是否有权限审核指定状态的记录
     * 
     * @param currentStatus 当前状态
     * @param auditorRoleIds 审核人角色ID列表
     * @return 是否有权限
     */
    public boolean canAudit(Integer currentStatus, List<Long> auditorRoleIds) 
    {
        if (!SubmissionStatusConstants.isValidStatus(currentStatus)) 
        {
            return false;
        }
        
        // 管理员可以审核任何状态
        if (auditorRoleIds.contains(ADMIN_ROLE_ID)) 
        {
            return true;
        }
        
        // 待班委审核：需要班委权限
        if (SubmissionStatusConstants.PENDING_MONITOR_AUDIT.equals(currentStatus)) 
        {
            return auditorRoleIds.contains(MONITOR_ROLE_ID);
        }
        
        // 待辅导员审核：需要辅导员权限
        if (SubmissionStatusConstants.PENDING_COUNSELOR_AUDIT.equals(currentStatus)) 
        {
            return auditorRoleIds.contains(COUNSELOR_ROLE_ID);
        }
        
        // 其他状态不允许审核
        return false;
    }
    
    /**
     * 验证用户是否有权限审核指定状态的记录（使用当前登录用户）
     * 
     * @param currentStatus 当前状态
     * @return 是否有权限
     */
    public boolean canAudit(Integer currentStatus) 
    {
        List<Long> roleIds = getCurrentUserRoleIds();
        return canAudit(currentStatus, roleIds);
    }
    
    /**
     * 获取当前登录用户的角色ID列表
     * 
     * @return 角色ID列表
     */
    private List<Long> getCurrentUserRoleIds() 
    {
        try 
        {
            List<SysRole> roles = SecurityUtils.getLoginUser().getUser().getRoles();
            return roles.stream()
                    .map(SysRole::getRoleId)
                    .collect(Collectors.toList());
        } 
        catch (Exception e) 
        {
            return Collections.emptyList();
        }
    }
    
    /**
     * 检查是否有班委或管理员角色
     * 
     * @param roleIds 角色ID列表
     * @return 是否有权限
     */
    private boolean hasMonitorOrAdminRole(List<Long> roleIds) 
    {
        return roleIds.contains(MONITOR_ROLE_ID) || roleIds.contains(ADMIN_ROLE_ID);
    }
    
    /**
     * 检查是否有辅导员或管理员角色
     * 
     * @param roleIds 角色ID列表
     * @return 是否有权限
     */
    private boolean hasCounselorOrAdminRole(List<Long> roleIds) 
    {
        return roleIds.contains(COUNSELOR_ROLE_ID) || roleIds.contains(ADMIN_ROLE_ID);
    }
    
    /**
     * 获取状态流转描述
     * 
     * @param oldStatus 原状态
     * @param newStatus 新状态
     * @param operation 操作类型
     * @return 流转描述
     */
    public String getTransitionDescription(Integer oldStatus, Integer newStatus, String operation) 
    {
        String oldDesc = SubmissionStatusConstants.getStatusDesc(oldStatus);
        String newDesc = SubmissionStatusConstants.getStatusDesc(newStatus);
        String opDesc = AuditOperationConstants.getOperationDesc(operation);
        
        return String.format("%s：%s → %s", opDesc, oldDesc, newDesc);
    }
}

