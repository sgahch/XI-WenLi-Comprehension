package com.ruoyi.common.config;

import io.minio.MinioClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
// Added: OkHttp client to configure timeouts and pooling for MinIO
import okhttp3.ConnectionPool;
import okhttp3.OkHttpClient;

import java.util.concurrent.TimeUnit;

/**
 * @author Ynchen
 * <p>
 * 创建时间：2023/12/26 16:01
 */
@Configuration
public class MinioConfig {

    @Value("${minio.endpoint}")
    private String endpoint;

    @Value("${minio.accessKey}")
    private String accessKey;

    @Value("${minio.secretKey}")
    private String secretKey;

    // Added: configurable timeouts and connection pool with safe defaults
    @Value("${minio.connectTimeoutMs:10000}")
    private int connectTimeoutMs;

    @Value("${minio.readTimeoutMs:30000}")
    private int readTimeoutMs;

    @Value("${minio.writeTimeoutMs:30000}")
    private int writeTimeoutMs;

    @Value("${minio.maxIdleConnections:10}")
    private int maxIdleConnections;

    @Value("${minio.keepAliveDurationMs:300000}")
    private long keepAliveDurationMs;

    @Bean
    public OkHttpClient minioOkHttpClient() {
        // Modified: build OkHttp client used by MinIO for better production stability
        return new OkHttpClient.Builder()
                .connectTimeout(connectTimeoutMs, TimeUnit.MILLISECONDS)
                .readTimeout(readTimeoutMs, TimeUnit.MILLISECONDS)
                .writeTimeout(writeTimeoutMs, TimeUnit.MILLISECONDS)
                .connectionPool(new ConnectionPool(maxIdleConnections, keepAliveDurationMs, TimeUnit.MILLISECONDS))
                .build();
    }

    @Bean
    public MinioClient minioClient(OkHttpClient minioOkHttpClient) {
        // Modified: attach OkHttp client to MinIO client
        return MinioClient.builder()
                .endpoint(endpoint)
                .credentials(accessKey, secretKey)
                .httpClient(minioOkHttpClient)
                .build();
    }
}
