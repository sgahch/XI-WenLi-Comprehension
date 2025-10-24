package com.ruoyi.web.controller.common;

import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.utils.StringUtils;
import io.minio.GetObjectArgs;
import io.minio.MinioClient;
import io.minio.StatObjectArgs;
import io.minio.StatObjectResponse;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;

/**
 * Modified: New resource controller to stream objects from MinIO under /profile/**
 * Reason: After refactoring uploads to MinIO, we keep frontend URLs unchanged
 * (e.g., /profile/avatar/2025/10/18/xxx.jpg) by serving them via this controller.
 */
@RestController
@RequestMapping(Constants.RESOURCE_PREFIX)
public class MinioResourceController {

    private final MinioClient minioClient;

    @Value("${minio.bucketName}")
    private String bucketName;

    public MinioResourceController(MinioClient minioClient) {
        this.minioClient = minioClient;
    }

    @Anonymous
    @GetMapping("/**")
    public void getResource(HttpServletRequest request, HttpServletResponse response) {
        try {
            String fullPath = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
            String matchingPattern = (String) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
            String objectPath = new AntPathMatcher().extractPathWithinPattern(matchingPattern, fullPath);

            if (StringUtils.isEmpty(objectPath)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            StatObjectResponse stat = minioClient.statObject(
                    StatObjectArgs.builder().bucket(bucketName).object(objectPath).build()
            );

            String contentType = stat.contentType();
            if (StringUtils.isNotEmpty(contentType)) {
                response.setContentType(contentType);
            } else {
                response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            }
            // Optional: cache static resources for 1 day
            response.setHeader("Cache-Control", "public, max-age=86400");

            try (InputStream is = minioClient.getObject(
                    GetObjectArgs.builder().bucket(bucketName).object(objectPath).build())) {
                IOUtils.copy(is, response.getOutputStream());
                response.flushBuffer();
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}