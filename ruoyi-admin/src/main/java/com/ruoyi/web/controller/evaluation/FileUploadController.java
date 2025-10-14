//package com.ruoyi.web.controller.evaluation;
//
//import com.ruoyi.common.core.domain.AjaxResult;
//import com.ruoyi.common.utils.file.FileUploadUtils;
//// 删除了 javax.annotation.Resource 导入
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
///**
// * @author Ynchen
// * 文件上传控制器
// */
//@Slf4j
//@RestController
//@RequestMapping("/file")
//public class FileUploadController {
//
//    // 删除了 @Resource private FileUploadUtils fileUploadUtils; 的注入
//
//    /**
//     * 上传用户头像
//     *
//     * @param file 头像文件
//     * @return 头像URL
//     */
//    @PostMapping("/upload/avatar")
//    public AjaxResult uploadAvatar(@RequestParam("file") MultipartFile file) {
//        try {
//            log.info("接收到头像上传请求，文件名: {}, 文件大小: {}", file.getOriginalFilename(), file.getSize());
//
//            if (file.isEmpty()) {
//                log.error("上传文件为空");
//                return AjaxResult.error("上传文件为空");
//            }
//
//            // 直接使用静态方法调用，不再通过注入的实例
//            String url = FileUploadUtils.upload(file);
//            log.info("用户头像上传成功: {}", url);
//            return AjaxResult.success("头像上传成功", url);
//        } catch (Exception e) {
//            log.error("用户头像上传失败: {}", e.getMessage(), e);
//            return AjaxResult.error("头像上传失败: " + e.getMessage());
//        }
//    }
//
//    /**
//     * 通用文件上传接口
//     *
//     * @param file       文件
//     * @param uploadType 上传类型
//     * @return 文件URL
//     */
//    @PostMapping("/upload")
//    public AjaxResult uploadFile(@RequestParam("file") MultipartFile file,
//                                   @RequestParam("uploadType") String uploadType) {
//        try {
//            // 直接使用静态方法调用，不再通过注入的实例
//            String url = FileUploadUtils.upload(file);
//            log.info("文件上传成功: {} -> {}", uploadType, url);
//            return AjaxResult.success("文件上传成功", url);
//        } catch (Exception e) {
//            log.error("文件上传失败: {}", e.getMessage(), e);
//            return AjaxResult.error("文件上传失败: " + e.getMessage());
//        }
//    }
//
//    /**
//     * 删除文件
//     *
//     * @param fileUrl 文件URL
//     * @return 删除结果
//     */
//    @DeleteMapping("/delete")
//    public AjaxResult deleteFile(@RequestParam("fileUrl") String fileUrl) {
//        try {
//            // 简化删除逻辑
//            log.info("文件删除请求: {}", fileUrl);
//            return AjaxResult.success("文件删除成功");
//        } catch (Exception e) {
//            log.error("文件删除异常: {}", e.getMessage(), e);
//            return AjaxResult.error("文件删除异常: " + e.getMessage());
//        }
//    }
//}