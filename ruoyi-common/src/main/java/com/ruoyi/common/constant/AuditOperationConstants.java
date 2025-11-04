package com.ruoyi.common.constant;

/**
 * 审核操作常量
 * 
 * @author ruoyi
 */
public class AuditOperationConstants 
{
    /** 提交 */
    public static final String SUBMIT = "SUBMIT";
    
    /** 审核通过 */
    public static final String APPROVE = "APPROVE";
    
    /** 审核驳回 */
    public static final String REJECT = "REJECT";
    
    /**
     * 获取操作描述
     * 
     * @param operation 操作类型
     * @return 操作描述
     */
    public static String getOperationDesc(String operation) 
    {
        if (operation == null) 
        {
            return "未知操作";
        }
        
        switch (operation) 
        {
            case "SUBMIT":
                return "提交";
            case "APPROVE":
                return "审核通过";
            case "REJECT":
                return "审核驳回";
            default:
                return "未知操作";
        }
    }
    
    /**
     * 检查操作是否有效
     * 
     * @param operation 操作类型
     * @return 是否有效
     */
    public static boolean isValidOperation(String operation) 
    {
        return SUBMIT.equals(operation) || APPROVE.equals(operation) || REJECT.equals(operation);
    }
}

