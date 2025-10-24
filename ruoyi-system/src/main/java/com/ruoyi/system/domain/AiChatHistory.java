package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.system.domain.AiChatMessage;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * AI聊天历史记录实体
 * 
 * @author ruoyi
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AiChatHistory 
{
    /**
     * 业务ID（用户ID+姓名+部门）
     */
    private String businessId;
    
    /**
     * 用户ID
     */
    private Long userId;
    
    /**
     * 用户姓名
     */
    private String userName;
    
    /**
     * 用户部门
     */
    private String deptName;
    
    /**
     * 聊天消息列表
     */
    private List<AiChatMessage> messages;
    
    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    
    /**
     * 最后更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
    
    /**
     * 构造函数
     */
    public AiChatHistory(String businessId, Long userId, String userName, String deptName) 
    {
        this.businessId = businessId;
        this.userId = userId;
        this.userName = userName;
        this.deptName = deptName;
        this.messages = new ArrayList<>();
        this.createTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }
    
    /**
     * 添加消息
     */
    public void addMessage(AiChatMessage message) 
    {
        if (this.messages == null) {
            this.messages = new ArrayList<>();
        }
        this.messages.add(message);
        this.updateTime = LocalDateTime.now();
    }
    
    /**
     * 获取消息数量
     */
    public int getMessageCount() 
    {
        return this.messages != null ? this.messages.size() : 0;
    }
}