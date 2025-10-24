package com.ruoyi.system.service;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.system.domain.AiChatHistory;
import com.ruoyi.system.domain.AiChatMessage;
import com.ruoyi.system.utils.AiChatUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

/**
 * AI聊天历史记录服务
 * 
 * @author ruoyi
 */
@Service
@Slf4j
public class AiChatHistoryService 
{
    @Autowired
    private RedisCache redisCache;
    
    /**
     * 3天的秒数
     */
    private static final long EXPIRE_DAYS = 3;
    private static final long EXPIRE_SECONDS = EXPIRE_DAYS * 24 * 60 * 60;
    
    /**
     * 获取用户聊天历史记录
     * 
     * @param userId 用户ID
     * @return 聊天历史记录
     */
    public AiChatHistory getChatHistory(Long userId) 
    {
        try {
            String businessId = AiChatUtils.generateBusinessId(userId);
            String redisKey = AiChatUtils.generateRedisKey(businessId);
            AiChatHistory history = redisCache.getCacheObject(redisKey);
            
            if (history == null) {
                // 如果没有历史记录，创建新的
                // 从businessId中解析用户信息
                String[] parts = businessId.split("_");
                String userName = parts.length > 1 ? parts[1] : "未知用户";
                String deptName = parts.length > 2 ? parts[2] : "未知部门";
                
                history = new AiChatHistory(businessId, userId, userName, deptName);
                log.info("为用户 {} 创建新的聊天历史记录", userId);
            }
            
            return history;
        } catch (Exception e) {
            log.error("获取用户聊天历史记录失败，用户ID: {}", userId, e);
            // 返回空的历史记录
            String businessId = AiChatUtils.generateBusinessId(userId);
            String[] parts = businessId.split("_");
            String userName = parts.length > 1 ? parts[1] : "未知用户";
            String deptName = parts.length > 2 ? parts[2] : "未知部门";
            return new AiChatHistory(businessId, userId, userName, deptName);
        }
    }
    
    /**
     * 保存用户聊天历史记录
     * 
     * @param history 聊天历史记录
     */
    public void saveChatHistory(AiChatHistory history) 
    {
        try {
            if (history == null || history.getUserId() == null) {
                log.warn("聊天历史记录为空或用户ID为空，无法保存");
                return;
            }
            
            String businessId = AiChatUtils.generateBusinessId(history.getUserId());
            String redisKey = AiChatUtils.generateRedisKey(businessId);
            history.setUpdateTime(LocalDateTime.now());
            
            // 保存到Redis，设置3天过期时间
            redisCache.setCacheObject(redisKey, history, (int) EXPIRE_SECONDS, TimeUnit.SECONDS);
            
            log.info("保存用户聊天历史记录成功，用户ID: {}, 消息数量: {}", 
                    history.getUserId(), history.getMessageCount());
        } catch (Exception e) {
            log.error("保存用户聊天历史记录失败，用户ID: {}", 
                    history != null ? history.getUserId() : "null", e);
        }
    }
    
    /**
     * 添加用户消息
     * 
     * @param userId 用户ID
     * @param message 用户消息内容
     */
    public void addUserMessage(Long userId, String message) 
    {
        try {
            AiChatHistory history = getChatHistory(userId);
            AiChatMessage chatMessage = AiChatMessage.createUserMessage(message);
            history.addMessage(chatMessage);
            saveChatHistory(history);
            
            log.info("添加用户消息成功，用户ID: {}, 消息内容: {}", userId, message);
        } catch (Exception e) {
            log.error("添加用户消息失败，用户ID: {}, 消息内容: {}", userId, message, e);
        }
    }
    
    /**
     * 添加AI回复消息
     * 
     * @param userId 用户ID
     * @param reply AI回复内容
     */
    public void addAiMessage(Long userId, String reply) 
    {
        try {
            AiChatHistory history = getChatHistory(userId);
            AiChatMessage chatMessage = AiChatMessage.createAiMessage(reply);
            history.addMessage(chatMessage);
            saveChatHistory(history);
            
            log.info("添加AI回复消息成功，用户ID: {}, 回复内容长度: {}", userId, reply.length());
        } catch (Exception e) {
            log.error("添加AI回复消息失败，用户ID: {}, 回复内容长度: {}", 
                    userId, reply != null ? reply.length() : 0, e);
        }
    }
    
    /**
     * 清除用户聊天历史记录
     * 
     * @param userId 用户ID
     */
    public void clearChatHistory(Long userId) 
    {
        try {
            String businessId = AiChatUtils.generateBusinessId(userId);
            String redisKey = AiChatUtils.generateRedisKey(businessId);
            redisCache.deleteObject(redisKey);
            log.info("清除用户聊天历史记录成功，用户ID: {}", userId);
        } catch (Exception e) {
            log.error("清除用户聊天历史记录失败，用户ID: {}", userId, e);
        }
    }
    
    /**
     * 检查用户是否有聊天历史记录
     * 
     * @param userId 用户ID
     * @return 是否存在历史记录
     */
    public boolean hasChatHistory(Long userId) 
    {
        try {
            String businessId = AiChatUtils.generateBusinessId(userId);
            String redisKey = AiChatUtils.generateRedisKey(businessId);
            return redisCache.hasKey(redisKey);
        } catch (Exception e) {
            log.error("检查用户聊天历史记录失败，用户ID: {}", userId, e);
            return false;
        }
    }
}