package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * AI聊天消息实体
 * 用于存储用户和AI的交互消息
 * 
 * @author Ynchen
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AiChatMessage 
{
    /**
     * 消息时间戳
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime timestamp;
    
    /**
     * 消息类型：user-用户消息，ai-AI回复
     */
    private String type;
    
    /**
     * 消息内容
     */
    private String content;
    
    /**
     * 创建用户消息
     */
    public static AiChatMessage createUserMessage(String content) 
    {
        return new AiChatMessage(LocalDateTime.now(), "user", content);
    }
    
    /**
     * 创建AI消息
     */
    public static AiChatMessage createAiMessage(String content) 
    {
        return new AiChatMessage(LocalDateTime.now(), "ai", content);
    }
}