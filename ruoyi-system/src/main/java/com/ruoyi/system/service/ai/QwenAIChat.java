package com.ruoyi.system.service.ai;

import dev.langchain4j.model.chat.ChatLanguageModel; // 1. 导入正确的类
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
@Slf4j
public class QwenAIChat {

    @Resource
    private ChatLanguageModel chatLanguageModel;

    public String chat(String message) {
        // 直接使用 ChatLanguageModel 的快捷方法
        String aiResponseText = chatLanguageModel.chat(message);
        log.info("User Message: [{}], AI Response: [{}]", message, aiResponseText);
        return aiResponseText;
    }
}