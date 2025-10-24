package com.ruoyi.system.ai;

import com.ruoyi.common.ai.DashscopeOpenAiCompatibleChatModel;
import dev.langchain4j.model.chat.ChatLanguageModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TestLangChain4jConfig {

    @Bean
    public ChatLanguageModel chatLanguageModel(
            @Value("${langchain4j.community.dashscope.chat-model.api-key}") String apiKey,
            @Value("${langchain4j.community.dashscope.chat-model.model-name:qwen3-max}") String modelName,
            @Value("${langchain4j.community.dashscope.chat-model.log-request:false}") boolean logRequest,
            @Value("${langchain4j.community.dashscope.chat-model.log-responses:false}") boolean logResponses
    ) {
        return DashscopeOpenAiCompatibleChatModel.builder()
                .apiKey(apiKey)
                .baseUrl("https://dashscope.aliyuncs.com/compatible-mode/v1")
                .modelName(modelName)
                .logRequests(logRequest)
                .logResponses(logResponses)
                .build();
    }
}