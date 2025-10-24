package com.ruoyi.system.utils;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.system.service.ISysUserService;

/**
 * AI聊天工具类
 * 
 * @author ruoyi
 */
public class AiChatUtils 
{
    /**
     * Redis键前缀
     */
    public static final String AI_CHAT_KEY_PREFIX = "ai_chat:";
    
    /**
     * 生成业务ID
     * 格式：用户ID_用户姓名_用户部门
     * 
     * @param userId 用户ID
     * @return 业务ID
     */
    public static String generateBusinessId(Long userId) 
    {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为空");
        }
        
        try {
            // 获取用户服务
            ISysUserService userService = SpringUtils.getBean(ISysUserService.class);
            SysUser user = userService.selectUserById(userId);
            
            if (user == null) {
                throw new IllegalArgumentException("用户不存在：" + userId);
            }
            
            // 获取用户部门名称
            String deptName = user.getDept() != null ? user.getDept().getDeptName() : "未知部门";
            
            // 生成业务ID：用户ID_用户姓名_用户部门
            return String.format("%d_%s_%s", userId, user.getUserName(), deptName);
        } catch (Exception e) {
            // 如果获取用户信息失败，使用默认格式
            return String.format("%d_未知用户_未知部门", userId);
        }
    }
    
    /**
     * 生成Redis键
     * 
     * @param businessId 业务ID
     * @return Redis键
     */
    public static String generateRedisKey(String businessId) 
    {
        return AI_CHAT_KEY_PREFIX + businessId;
    }
    
    /**
     * 从业务ID中提取用户ID
     * 
     * @param businessId 业务ID（格式：用户ID_用户姓名_用户部门）
     * @return 用户ID
     */
    public static Long extractUserIdFromBusinessId(String businessId) 
    {
        if (businessId == null || businessId.trim().isEmpty()) {
            throw new IllegalArgumentException("业务ID不能为空");
        }
        
        String[] parts = businessId.split("_");
        if (parts.length < 3) {
            throw new IllegalArgumentException("业务ID格式错误：" + businessId);
        }
        
        try {
            return Long.parseLong(parts[0]);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("业务ID中的用户ID格式错误：" + businessId, e);
        }
    }
    
    /**
     * 验证业务ID格式
     * 
     * @param businessId 业务ID
     * @return 是否有效
     */
    public static boolean isValidBusinessId(String businessId) 
    {
        if (businessId == null || businessId.trim().isEmpty()) {
            return false;
        }
        
        String[] parts = businessId.split("_");
        if (parts.length < 3) {
            return false;
        }
        
        try {
            Long.parseLong(parts[0]);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}