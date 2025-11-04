package com.ruoyi.system.service.impl;

import com.ruoyi.common.constant.AttachmentTypeConstants;
import com.ruoyi.system.domain.EvaluationAttachment;
import com.ruoyi.system.domain.EvaluationSubmissionDetail;
import com.ruoyi.system.mapper.EvaluationAttachmentMapper;
import com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper;
import com.ruoyi.system.service.IEvaluationAttachmentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 综测附件Service业务层处理
 *
 * @author ruoyi
 * @date 2025-11-02
 */
@Service
public class EvaluationAttachmentServiceImpl implements IEvaluationAttachmentService
{
    private static final Logger logger = LoggerFactory.getLogger(EvaluationAttachmentServiceImpl.class);

    @Autowired
    private EvaluationAttachmentMapper evaluationAttachmentMapper;

    @Autowired
    private EvaluationSubmissionDetailMapper evaluationSubmissionDetailMapper;

    /**
     * 新增附件
     * 
     * @param attachment 附件信息
     * @return 结果
     */
    @Override
    public int insertEvaluationAttachment(EvaluationAttachment attachment)
    {
        // 如果没有设置附件类型，默认为证书材料
        if (attachment.getAttachmentType() == null || attachment.getAttachmentType().trim().isEmpty()) {
            attachment.setAttachmentType(AttachmentTypeConstants.CERTIFICATE);
        }
        return evaluationAttachmentMapper.insertEvaluationAttachment(attachment);
    }

    /**
     * 批量新增附件
     * 
     * @param attachments 附件列表
     * @return 结果
     */
    @Override
    public int insertBatch(List<EvaluationAttachment> attachments)
    {
        if (attachments == null || attachments.isEmpty()) {
            return 0;
        }
        
        // 为每个附件设置默认类型(如果未设置)
        for (EvaluationAttachment attachment : attachments) {
            if (attachment.getAttachmentType() == null || attachment.getAttachmentType().trim().isEmpty()) {
                attachment.setAttachmentType(AttachmentTypeConstants.CERTIFICATE);
            }
        }
        
        return evaluationAttachmentMapper.insertBatch(attachments);
    }

    /**
     * 根据详情ID数组删除附件
     * 
     * @param detailIds 详情ID数组
     * @return 结果
     */
    @Override
    public int deleteByDetailIds(Long[] detailIds)
    {
        if (detailIds == null || detailIds.length == 0) {
            return 0;
        }
        return evaluationAttachmentMapper.deleteByDetailIds(detailIds);
    }

    /**
     * 根据详情ID查询所有附件
     * 
     * @param detailId 详情ID
     * @return 附件列表
     */
    @Override
    public List<EvaluationAttachment> selectByDetailId(Long detailId)
    {
        if (detailId == null) {
            return new ArrayList<>();
        }
        return evaluationAttachmentMapper.selectByDetailId(detailId);
    }

    /**
     * 根据详情ID和附件类型查询附件列表
     *
     * @param detailId 详情ID
     * @param attachmentType 附件类型
     * @return 附件列表
     */
    @Override
    public List<EvaluationAttachment> selectByDetailIdAndType(Long detailId, String attachmentType)
    {
        logger.info("--- [Service层] 查询附件 ---");
        logger.info("detailId: {}, attachmentType: {}", detailId, attachmentType);

        if (detailId == null) {
            logger.warn("⚠️ detailId 为空，返回空列表");
            return new ArrayList<>();
        }

        List<EvaluationAttachment> result = evaluationAttachmentMapper.selectByDetailIdAndType(detailId, attachmentType);
        logger.info("✅ Mapper 返回 {} 条记录", result.size());

        if (result.isEmpty()) {
            logger.warn("⚠️ 未找到匹配的附件记录");
            logger.warn("请检查数据库 evaluation_attachment 表:");
            logger.warn("  SELECT * FROM evaluation_attachment WHERE detail_id = {} AND attachment_type = '{}'", detailId, attachmentType);
        }

        return result;
    }

    /**
     * 查询成绩截图
     * 
     * @param detailId 详情ID
     * @return 成绩截图列表
     */
    @Override
    public List<EvaluationAttachment> selectGradeScreenshots(Long detailId)
    {
        return selectByDetailIdAndType(detailId, AttachmentTypeConstants.GRADE_SCREENSHOT);
    }

    /**
     * 查询证书材料
     * 
     * @param detailId 详情ID
     * @return 证书材料列表
     */
    @Override
    public List<EvaluationAttachment> selectCertificates(Long detailId)
    {
        return selectByDetailIdAndType(detailId, AttachmentTypeConstants.CERTIFICATE);
    }

    /**
     * 根据提交ID查询所有附件(包含所有详情的附件)
     * 
     * @param submissionId 提交ID
     * @return 附件列表
     */
    @Override
    public List<EvaluationAttachment> selectBySubmissionId(Long submissionId)
    {
        if (submissionId == null) {
            return new ArrayList<>();
        }
        
        // 先查询该提交下的所有详情
        List<EvaluationSubmissionDetail> details = evaluationSubmissionDetailMapper.selectBySubmissionId(submissionId);
        if (details == null || details.isEmpty()) {
            return new ArrayList<>();
        }
        
        // 收集所有附件
        List<EvaluationAttachment> allAttachments = new ArrayList<>();
        for (EvaluationSubmissionDetail detail : details) {
            List<EvaluationAttachment> attachments = evaluationAttachmentMapper.selectByDetailId(detail.getId());
            if (attachments != null && !attachments.isEmpty()) {
                allAttachments.addAll(attachments);
            }
        }
        
        return allAttachments;
    }

    /**
     * 根据提交ID和附件类型查询附件
     * 
     * @param submissionId 提交ID
     * @param attachmentType 附件类型
     * @return 附件列表
     */
    @Override
    public List<EvaluationAttachment> selectBySubmissionIdAndType(Long submissionId, String attachmentType)
    {
        if (submissionId == null) {
            return new ArrayList<>();
        }
        
        // 先查询该提交下的所有详情
        List<EvaluationSubmissionDetail> details = evaluationSubmissionDetailMapper.selectBySubmissionId(submissionId);
        if (details == null || details.isEmpty()) {
            return new ArrayList<>();
        }
        
        // 收集指定类型的附件
        List<EvaluationAttachment> allAttachments = new ArrayList<>();
        for (EvaluationSubmissionDetail detail : details) {
            List<EvaluationAttachment> attachments = evaluationAttachmentMapper.selectByDetailIdAndType(
                detail.getId(), attachmentType);
            if (attachments != null && !attachments.isEmpty()) {
                allAttachments.addAll(attachments);
            }
        }
        
        return allAttachments;
    }
}

