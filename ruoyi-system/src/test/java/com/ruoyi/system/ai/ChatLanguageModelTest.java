package com.ruoyi.system.ai;

import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.SystemMessage;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.chat.response.ChatResponse;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(classes = {TestLangChain4jConfig.class})
class ChatLanguageModelTest {

    @Resource
    private ChatLanguageModel chatLanguageModel;

    @Test
    void should_send_messages_and_return_response() {
        List<ChatMessage> messages = Arrays.asList(
                SystemMessage.from("你是严谨的中文写作助手"),
                UserMessage.from("请用中文回答：鲁迅是谁？简短说明")
        );

        ChatResponse response = chatLanguageModel.chat(messages);
        assertThat(response.aiMessage().text()).isNotBlank();
    }
}