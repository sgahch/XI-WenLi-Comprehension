package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.AiChatHistory;
import com.ruoyi.web.service.ai.AiChatService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * AI 聊天控制器
 * 
 * @author ruoyi
 */
@Api("AI聊天接口")
@RestController
@RequestMapping("/ai")
@Slf4j
public class AiChatController extends BaseController
{
    @Autowired
    private AiChatService aiChatService;

    /**
     * AI 聊天接口
     */
    @ApiOperation("AI聊天")
    @PostMapping("/chat")
    public AjaxResult chat(@ApiParam("聊天请求") @RequestBody ChatRequest request)
    {
        try 
        {
            String reply = aiChatService.chat(request.getMessage());
            return AjaxResult.success(Map.of("reply", reply));
        }
        catch (Exception e)
        {
            log.error("AI聊天异常", e);
            return AjaxResult.error("AI聊天服务暂时不可用，请稍后重试");
        }
    }
    
    /**
     * 获取聊天历史记录
     */
    @ApiOperation("获取聊天历史记录")
    @GetMapping("/history")
    public AjaxResult getChatHistory()
    {
        try 
        {
            AiChatHistory history = aiChatService.getChatHistory();
            return AjaxResult.success(history);
        }
        catch (Exception e)
        {
            log.error("获取聊天历史记录异常", e);
            return AjaxResult.error("获取聊天历史记录失败");
        }
    }
    
    /**
     * 清除聊天历史记录
     */
    @ApiOperation("清除聊天历史记录")
    @DeleteMapping("/history")
    public AjaxResult clearChatHistory()
    {
        try 
        {
            aiChatService.clearChatHistory();
            return AjaxResult.success("聊天历史记录已清除");
        }
        catch (Exception e)
        {
            log.error("清除聊天历史记录异常", e);
            return AjaxResult.error("清除聊天历史记录失败");
        }
    }

    /**
     * 聊天请求实体
     */
    @lombok.Setter
    @Getter
    public static class ChatRequest
    {
        private String message;

    }
}