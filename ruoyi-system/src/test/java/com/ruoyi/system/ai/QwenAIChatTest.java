package com.ruoyi.system.ai;

import com.ruoyi.system.service.ai.QwenAIChat;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(classes = {TestLangChain4jConfig.class, QwenAIChat.class})
class QwenAIChatTest {

    @Resource
    private QwenAIChat qwenAIChat;

    @Test
    void should_return_non_blank_response() {
        String answer = qwenAIChat.chat("用中文简短介绍一下简历的写作要点");
        assertThat(answer).isNotBlank();
        assertThat(answer.length()).isGreaterThan(10);
    }
}