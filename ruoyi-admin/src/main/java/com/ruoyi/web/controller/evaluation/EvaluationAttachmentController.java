package com.ruoyi.web.controller.evaluation;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.constant.AttachmentTypeConstants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.framework.config.ServerConfig;
import com.ruoyi.system.domain.EvaluationAttachment;
import com.ruoyi.system.domain.EvaluationSubmissionDetail;
import com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper;
import com.ruoyi.system.service.IEvaluationAttachmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 综测附件Controller
 * 
 * @author ruoyi
 * @date 2025-11-02
 */
@RestController
@RequestMapping("/evaluation/attachment")
public class EvaluationAttachmentController extends BaseController
{
    @Autowired
    private IEvaluationAttachmentService evaluationAttachmentService;

    @Autowired
    private ServerConfig serverConfig;

    @Autowired
    private EvaluationSubmissionDetailMapper evaluationSubmissionDetailMapper;

    /**
     * 上传附件（支持附件类型参数）
     *
     * @param file 文件
     * @param submissionId 填报ID（可选）
     * @param detailId 详情ID（可选）
     * @param attachmentType 附件类型：CERTIFICATE-证书材料，GRADE_SCREENSHOT-成绩截图
     * @return 附件信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:upload')")
    @Log(title = "附件上传", businessType = BusinessType.INSERT)
    @PostMapping("/upload")
    public AjaxResult uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "submissionId", required = false) Long submissionId,
            @RequestParam(value = "detailId", required = false) Long detailId,
            @RequestParam(value = "attachmentType", required = false, defaultValue = "CERTIFICATE") String attachmentType)
    {
        try
        {
            // 验证参数
            if (submissionId == null && detailId == null)
            {
                return error("缺少必要参数：submissionId 或 detailId");
            }

            // 验证附件类型
            if (!AttachmentTypeConstants.CERTIFICATE.equals(attachmentType)
                && !AttachmentTypeConstants.GRADE_SCREENSHOT.equals(attachmentType))
            {
                return error("不支持的附件类型：" + attachmentType);
            }

            // 如果提供了submissionId但没有detailId，查找智育维度的detail
            if (submissionId != null && detailId == null && AttachmentTypeConstants.GRADE_SCREENSHOT.equals(attachmentType))
            {
                List<EvaluationSubmissionDetail> details = evaluationSubmissionDetailMapper.selectBySubmissionId(submissionId);

                for (EvaluationSubmissionDetail detail : details)
                {
                    // 解析ruleSnapshot JSON，查找dimension字段
                    String ruleSnapshotStr = detail.getRuleSnapshot();
                    if (ruleSnapshotStr != null && !ruleSnapshotStr.isEmpty())
                    {
                        try
                        {
                            JSONObject ruleSnapshot = JSONObject.parseObject(ruleSnapshotStr);
                            String dimension = ruleSnapshot.getString("dimension");
                            if ("intellectual".equals(dimension))
                            {
                                detailId = detail.getId();
                                break;
                            }
                        }
                        catch (Exception e)
                        {
                            logger.warn("解析ruleSnapshot失败: " + e.getMessage());
                        }
                    }
                }

                // 如果还是没有找到，返回错误
                if (detailId == null)
                {
                    return error("该填报记录中没有智育维度的成果，请先添加智育成果后再上传成绩截图");
                }
            }

            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath() + "/evaluation";
            
            // 根据附件类型设置不同的文件类型限制
            String[] allowedExtension;
            if (AttachmentTypeConstants.GRADE_SCREENSHOT.equals(attachmentType))
            {
                // 成绩截图只允许图片格式
                allowedExtension = new String[]{"jpg", "jpeg", "png"};
            }
            else
            {
                // 证书材料允许多种格式
                allowedExtension = new String[]{"pdf", "jpg", "jpeg", "png", "doc", "docx"};
            }
            
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file, allowedExtension);
            String url = serverConfig.getUrl() + fileName;
            
            // 构建附件对象
            EvaluationAttachment attachment = new EvaluationAttachment();
            attachment.setDetailId(detailId);
            attachment.setFileName(fileName);
            attachment.setOriginalName(file.getOriginalFilename());
            attachment.setFilePath(fileName);
            attachment.setFileSize(file.getSize());
            attachment.setFileType(getFileExtension(file.getOriginalFilename()));
            attachment.setAttachmentType(attachmentType);
            attachment.setUrl(url);
            attachment.setUploadBy(SecurityUtils.getUserId());
            attachment.setUploadTime(DateUtils.getNowDate());
            attachment.setCreateTime(DateUtils.getNowDate());
            attachment.setUpdateTime(DateUtils.getNowDate());
            
            // 保存附件记录
            evaluationAttachmentService.insertEvaluationAttachment(attachment);
            
            // 返回结果
            Map<String, Object> result = new HashMap<>();
            result.put("id", attachment.getId());
            result.put("url", url);
            result.put("fileName", fileName);
            result.put("originalName", file.getOriginalFilename());
            result.put("fileSize", file.getSize());
            result.put("fileType", attachment.getFileType());
            result.put("attachmentType", attachmentType);
            
            return success(result);
        }
        catch (Exception e)
        {
            logger.error("附件上传失败", e);
            return error("附件上传失败：" + e.getMessage());
        }
    }

    /**
     * 查询成绩截图
     *
     * @param detailId 详情ID
     * @return 成绩截图列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:query')")
    @GetMapping("/grade-screenshot/{detailId}")
    public AjaxResult getGradeScreenshots(@PathVariable("detailId") Long detailId)
    {
        logger.info("=== [后端] 收到查询成绩截图请求 ===");
        logger.info("请求参数 detailId: {}", detailId);

        try
        {
            List<EvaluationAttachment> screenshots = evaluationAttachmentService.selectGradeScreenshots(detailId);
            logger.info("✅ 查询成功，返回 {} 张成绩截图", screenshots.size());

            if (screenshots.isEmpty())
            {
                logger.warn("⚠️ 未找到成绩截图，detailId: {}", detailId);
                logger.warn("可能的原因:");
                logger.warn("  1. 该详情ID对应的记录没有上传成绩截图");
                logger.warn("  2. 附件的 attachmentType 不是 GRADE_SCREENSHOT");
                logger.warn("  3. 附件的 detailId 与请求的 detailId 不匹配");
            }
            else
            {
                logger.info("成绩截图列表:");
                for (int i = 0; i < screenshots.size(); i++)
                {
                    EvaluationAttachment att = screenshots.get(i);
                    logger.info("  [{}] ID: {}, 文件名: {}, URL: {}, detailId: {}, attachmentType: {}",
                        i + 1, att.getId(), att.getFileName(), att.getUrl(), att.getDetailId(), att.getAttachmentType());
                }
            }

            return success(screenshots);
        }
        catch (Exception e)
        {
            logger.error("❌ 查询成绩截图失败", e);
            return error("查询成绩截图失败：" + e.getMessage());
        }
    }

    /**
     * 查询证书材料
     * 
     * @param detailId 详情ID
     * @return 证书材料列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:query')")
    @GetMapping("/certificate/{detailId}")
    public AjaxResult getCertificates(@PathVariable("detailId") Long detailId)
    {
        try
        {
            List<EvaluationAttachment> certificates = evaluationAttachmentService.selectCertificates(detailId);
            return success(certificates);
        }
        catch (Exception e)
        {
            logger.error("查询证书材料失败", e);
            return error("查询证书材料失败：" + e.getMessage());
        }
    }

    /**
     * 根据详情ID查询所有附件
     * 
     * @param detailId 详情ID
     * @return 附件列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:query')")
    @GetMapping("/detail/{detailId}")
    public AjaxResult getByDetailId(@PathVariable("detailId") Long detailId)
    {
        try
        {
            List<EvaluationAttachment> attachments = evaluationAttachmentService.selectByDetailId(detailId);
            return success(attachments);
        }
        catch (Exception e)
        {
            logger.error("查询附件失败", e);
            return error("查询附件失败：" + e.getMessage());
        }
    }

    /**
     * 根据提交ID查询所有附件
     * 
     * @param submissionId 提交ID
     * @return 附件列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:query')")
    @GetMapping("/submission/{submissionId}")
    public AjaxResult getBySubmissionId(@PathVariable("submissionId") Long submissionId)
    {
        try
        {
            List<EvaluationAttachment> attachments = evaluationAttachmentService.selectBySubmissionId(submissionId);
            return success(attachments);
        }
        catch (Exception e)
        {
            logger.error("查询附件失败", e);
            return error("查询附件失败：" + e.getMessage());
        }
    }

    /**
     * 根据提交ID和附件类型查询附件
     * 
     * @param submissionId 提交ID
     * @param attachmentType 附件类型
     * @return 附件列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:query')")
    @GetMapping("/submission/{submissionId}/type/{attachmentType}")
    public AjaxResult getBySubmissionIdAndType(
            @PathVariable("submissionId") Long submissionId,
            @PathVariable("attachmentType") String attachmentType)
    {
        try
        {
            List<EvaluationAttachment> attachments = evaluationAttachmentService.selectBySubmissionIdAndType(
                submissionId, attachmentType);
            return success(attachments);
        }
        catch (Exception e)
        {
            logger.error("查询附件失败", e);
            return error("查询附件失败：" + e.getMessage());
        }
    }

    /**
     * 删除附件
     * 
     * @param detailIds 详情ID数组
     * @return 结果
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:remove')")
    @Log(title = "附件删除", businessType = BusinessType.DELETE)
    @DeleteMapping("/{detailIds}")
    public AjaxResult remove(@PathVariable Long[] detailIds)
    {
        try
        {
            return toAjax(evaluationAttachmentService.deleteByDetailIds(detailIds));
        }
        catch (Exception e)
        {
            logger.error("删除附件失败", e);
            return error("删除附件失败：" + e.getMessage());
        }
    }

    /**
     * 获取文件扩展名
     */
    private String getFileExtension(String filename)
    {
        if (filename == null || filename.lastIndexOf(".") == -1)
        {
            return "";
        }
        return filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();
    }
}

