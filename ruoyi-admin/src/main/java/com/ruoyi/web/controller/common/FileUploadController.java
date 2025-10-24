package com.ruoyi.web.controller.common;

import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.UploadEnum;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.config.RuoYiConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;

/**
 * @author Ynchen
 * 文件上传控制器
 */
@Slf4j
@RestController
@RequestMapping("/file")
public class FileUploadController {

    /**
     * 上传用户头像
     *
     * @param file 头像文件
     * @return 头像URL
     */
    @PostMapping("/upload/avatar")
    public AjaxResult uploadAvatar(@RequestParam("file") MultipartFile file) {
        try {
            log.info("接收到头像上传请求，文件名: {}, 文件大小: {}", file.getOriginalFilename(), file.getSize());

            if (file.isEmpty()) {
                log.error("上传文件为空");
                return AjaxResult.error("上传文件为空");
            }

            // 使用 UploadEnum 的目录，保持 /profile/** 路径
            String baseDir = RuoYiConfig.getProfile() + "/" + UploadEnum.USER_AVATAR.getDir();
            String url = FileUploadUtils.upload(baseDir, file);
            log.info("用户头像上传成功: {}", url);
            return AjaxResult.success("头像上传成功", url);
        } catch (Exception e) {
            log.error("用户头像上传失败: {}", e.getMessage(), e);
            return AjaxResult.error("头像上传失败: " + e.getMessage());
        }
    }

    /**
     * 通用文件上传接口
     *
     * @param file       文件
     * @param uploadType 上传类型 (USER_AVATAR, ARTICLE_COVER, etc.)
     * @return 文件URL
     */
    @PostMapping("/upload")
    public AjaxResult uploadFile(@RequestParam("file") MultipartFile file,
                                             @RequestParam("uploadType") String uploadType) {
        try {
            UploadEnum uploadEnum = UploadEnum.valueOf(uploadType);
            String baseDir = RuoYiConfig.getProfile() + "/" + uploadEnum.getDir();
            String url = FileUploadUtils.upload(baseDir, file);
            log.info("文件上传成功: {} -> {}", uploadType, url);
            return AjaxResult.success(url, "文件上传成功");
        } catch (IllegalArgumentException e) {
            log.error("不支持的上传类型: {}", uploadType);
            return AjaxResult.error("不支持的上传类型: " + uploadType);
        } catch (Exception e) {
            log.error("文件上传失败: {}", e.getMessage(), e);
            return AjaxResult.error("文件上传失败: " + e.getMessage());
        }
    }

    /**
     * 删除文件
     *
     * @param fileUrl 文件URL
     * @return 删除结果
     */
    @DeleteMapping("/delete")
    public AjaxResult deleteFile(@RequestParam("fileUrl") String fileUrl) {
        try {
            // 从 /profile/** URL 中提取 MinIO 对象路径
            String objectName = com.ruoyi.common.utils.StringUtils.substringAfter(fileUrl, com.ruoyi.common.constant.Constants.RESOURCE_PREFIX + "/");
            io.minio.MinioClient minioClient = com.ruoyi.common.utils.spring.SpringUtils.getBean(io.minio.MinioClient.class);
            String bucketName = com.ruoyi.common.utils.spring.SpringUtils.getRequiredProperty("minio.bucketName");
            minioClient.removeObject(io.minio.RemoveObjectArgs.builder().bucket(bucketName).object(objectName).build());
            log.info("文件删除成功: {}", fileUrl);
            return AjaxResult.success("文件删除成功", true);
        } catch (Exception e) {
            log.error("文件删除异常: {}", e.getMessage(), e);
            return AjaxResult.error("文件删除异常: " + e.getMessage());
        }
    }
}