package com.ruoyi.common.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.SystemMessage;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.model.ModelProvider;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.chat.request.ChatRequest;
import dev.langchain4j.model.chat.response.ChatResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

/**
 * Minimal ChatLanguageModel implementation that calls DashScope's OpenAI-compatible endpoint.
 * Avoids dependency on langchain4j-openai to work with Maven mirrors.
 */
public class DashscopeOpenAiCompatibleChatModel implements ChatLanguageModel {

    private final String apiKey;
    private final String modelName;
    private final String baseUrl;
    private final boolean logRequests;
    private final boolean logResponses;

    private final ObjectMapper mapper = new ObjectMapper();

    private DashscopeOpenAiCompatibleChatModel(Builder builder) {
        this.apiKey = builder.apiKey;
        this.modelName = builder.modelName;
        this.baseUrl = builder.baseUrl != null ? builder.baseUrl : "https://dashscope.aliyuncs.com/compatible-mode/v1";
        this.logRequests = builder.logRequests;
        this.logResponses = builder.logResponses;
    }

    public static Builder builder() { return new Builder(); }

    public static class Builder {
        private String apiKey;
        private String modelName = "qwen3-max";
        private String baseUrl;
        private boolean logRequests;
        private boolean logResponses;

        public Builder apiKey(String apiKey) { this.apiKey = apiKey; return this; }
        public Builder modelName(String modelName) { this.modelName = modelName; return this; }
        public Builder baseUrl(String baseUrl) { this.baseUrl = baseUrl; return this; }
        public Builder logRequests(boolean logRequests) { this.logRequests = logRequests; return this; }
        public Builder logResponses(boolean logResponses) { this.logResponses = logResponses; return this; }
        public DashscopeOpenAiCompatibleChatModel build() { return new DashscopeOpenAiCompatibleChatModel(this); }
    }

    @Override
    public ModelProvider provider() {
        return ModelProvider.OTHER;
    }

    @Override
    public ChatResponse doChat(ChatRequest chatRequest) {
        try {
            String url = baseUrl.endsWith("/") ? (baseUrl + "chat/completions") : (baseUrl + "/chat/completions");
            String body = toOpenAiCompatibleBody(chatRequest.messages());
            if (logRequests) {
                System.out.println("[DashScope Request] " + body);
            }
            String responseJson = postJson(url, body);
            if (logResponses) {
                System.out.println("[DashScope Response] " + responseJson);
            }

            // Parse response: choices[0].message.content
            JsonNode root = mapper.readTree(responseJson);
            JsonNode choices = root.path("choices");
            String content = "";
            if (choices.isArray() && choices.size() > 0) {
                JsonNode msg = choices.get(0).path("message");
                content = msg.path("content").asText("");
            }
            AiMessage aiMessage = AiMessage.from(content);
            return ChatResponse.builder().aiMessage(aiMessage).build();
        } catch (IOException e) {
            throw new RuntimeException("DashScope chat request failed: " + e.getMessage(), e);
        }
    }

    private String toOpenAiCompatibleBody(List<ChatMessage> messages) throws IOException {
        List<Map<String, Object>> msgList = new ArrayList<>();
        for (ChatMessage message : messages) {
            Map<String, Object> m = new HashMap<>();
            switch (message.type()) {
                case SYSTEM:
                    m.put("role", "system");
                    m.put("content", ((SystemMessage) message).text());
                    break;
                case USER:
                    UserMessage um = (UserMessage) message;
                    // concatenate all text contents if multiple
                    String text = um.contents().stream()
                            .map(c -> {
                                try {
                                    // Only TextContent is supported in this minimal adapter
                                    // Use Jackson to serialize generic content if needed
                                    return c.toString();
                                } catch (Exception ex) {
                                    return "";
                                }
                            })
                            .collect(Collectors.joining("\n"));
                    if (um.hasSingleText()) {
                        text = um.singleText();
                    }
                    m.put("role", "user");
                    m.put("content", text);
                    break;
                case AI:
                    // treat previous assistant messages as context
                    m.put("role", "assistant");
                    m.put("content", ((AiMessage) message).text());
                    break;
                default:
                    // ignore other types for minimal compatibility
                    continue;
            }
            msgList.add(m);
        }
        Map<String, Object> payload = new HashMap<>();
        payload.put("model", modelName);
        payload.put("messages", msgList);
        return mapper.writeValueAsString(payload);
    }

    private String postJson(String url, String body) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        conn.setRequestProperty("Content-Length", String.valueOf(bytes.length));
        try (OutputStream os = conn.getOutputStream()) {
            os.write(bytes);
        }
        int code = conn.getResponseCode();
        InputStream is = (code >= 200 && code < 300) ? conn.getInputStream() : conn.getErrorStream();
        String response = readFully(is);
        if (code < 200 || code >= 300) {
            throw new IOException("HTTP " + code + ": " + response);
        }
        return response;
    }

    private static String readFully(InputStream is) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            return sb.toString();
        }
    }
}