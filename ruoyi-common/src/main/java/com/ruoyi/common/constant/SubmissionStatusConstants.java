package com.ruoyi.common.constant;

/**
 * 综测填报状态常量
 * 
 * @author ruoyi
 */
public class SubmissionStatusConstants 
{
    /** 草稿 */
    public static final Integer DRAFT = 0;
    
    /** 待班委审核 */
    public static final Integer PENDING_MONITOR_AUDIT = 1;
    
    /** 待辅导员审核 */
    public static final Integer PENDING_COUNSELOR_AUDIT = 2;
    
    /** 已通过 */
    public static final Integer APPROVED = 3;
    
    /** 已驳回 */
    public static final Integer REJECTED = 4;
    
    /**
     * 获取状态描述
     * 
     * @param status 状态值
     * @return 状态描述
     */
    public static String getStatusDesc(Integer status) 
    {
        if (status == null) 
        {
            return "未知状态";
        }
        
        switch (status) 
        {
            case 0:
                return "草稿";
            case 1:
                return "待班委审核";
            case 2:
                return "待辅导员审核";
            case 3:
                return "已通过";
            case 4:
                return "已驳回";
            default:
                return "未知状态";
        }
    }
    
    /**
     * 检查状态是否有效
     * 
     * @param status 状态值
     * @return 是否有效
     */
    public static boolean isValidStatus(Integer status) 
    {
        return status != null && status >= 0 && status <= 4;
    }
    
    /**
     * 检查是否可以提交审核
     * 
     * @param status 当前状态
     * @return 是否可以提交
     */
    public static boolean canSubmit(Integer status) 
    {
        return DRAFT.equals(status) || REJECTED.equals(status);
    }
    
    /**
     * 检查是否可以编辑
     * 
     * @param status 当前状态
     * @return 是否可以编辑
     */
    public static boolean canEdit(Integer status) 
    {
        return DRAFT.equals(status) || REJECTED.equals(status);
    }
    
    /**
     * 检查是否在审核中
     * 
     * @param status 当前状态
     * @return 是否在审核中
     */
    public static boolean isInAudit(Integer status) 
    {
        return PENDING_MONITOR_AUDIT.equals(status) || PENDING_COUNSELOR_AUDIT.equals(status);
    }
    
    /**
     * 检查是否已完成（通过或驳回）
     * 
     * @param status 当前状态
     * @return 是否已完成
     */
    public static boolean isCompleted(Integer status) 
    {
        return APPROVED.equals(status) || REJECTED.equals(status);
    }
}

