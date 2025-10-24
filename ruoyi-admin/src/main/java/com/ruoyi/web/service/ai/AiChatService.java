package com.ruoyi.web.service.ai;

import com.ruoyi.system.domain.AiChatHistory;
import com.ruoyi.system.service.AiChatHistoryService;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.service.ai.QwenAIChat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * AI 聊天服务
 * 
 * @author ruoyi
 */
@Service
@Slf4j
public class AiChatService 
{
    @Autowired
    private QwenAIChat qwenAIChat;
    
    @Autowired
    private AiChatHistoryService aiChatHistoryService;

    /**
     * AI 聊天
     * 
     * @param message 用户消息
     * @return AI 回复
     */
    public String chat(String message) 
    {
        if (message == null || message.trim().isEmpty()) 
        {
            return "请输入有效的消息内容";
        }
        
        try 
        {
            // 获取当前用户ID
            Long userId = SecurityUtils.getUserId();
            log.info("收到用户消息，用户ID: {}, 消息: {}", userId, message);
            
            // 保存用户消息到Redis
            aiChatHistoryService.addUserMessage(userId, message);
            
            // 调用AI服务获取回复
            String reply = qwenAIChat.chat(message);
            log.info("AI 回复，用户ID: {}, 回复长度: {}", userId, reply.length());
            
            // 保存AI回复到Redis
            aiChatHistoryService.addAiMessage(userId, reply);
            
            return reply;
        }
        catch (Exception e) 
        {
            log.error("AI 聊天服务异常", e);
            throw new RuntimeException("AI 聊天服务暂时不可用，请稍后重试", e);
        }
    }
    
    /**
     * 获取用户聊天历史记录
     * 
     * @return 聊天历史记录
     */
    public AiChatHistory getChatHistory() 
    {
        try 
        {
            Long userId = SecurityUtils.getUserId();
            return aiChatHistoryService.getChatHistory(userId);
        }
        catch (Exception e) 
        {
            log.error("获取聊天历史记录异常", e);
            throw new RuntimeException("获取聊天历史记录失败", e);
        }
    }
    
    /**
     * 清除用户聊天历史记录
     */
    public void clearChatHistory() 
    {
        try 
        {
            Long userId = SecurityUtils.getUserId();
            aiChatHistoryService.clearChatHistory(userId);
            log.info("清除用户聊天历史记录，用户ID: {}", userId);
        }
        catch (Exception e) 
        {
            log.error("清除聊天历史记录异常", e);
            throw new RuntimeException("清除聊天历史记录失败", e);
        }
    }
}