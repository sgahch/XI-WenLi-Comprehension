package com.ruoyi.system.service;

import com.ruoyi.system.domain.EvaluationAttachment;
import java.util.List;

/**
 * 综测附件Service接口
 * 
 * @author ruoyi
 * @date 2025-11-02
 */
public interface IEvaluationAttachmentService 
{
    /**
     * 新增附件
     * 
     * @param attachment 附件信息
     * @return 结果
     */
    int insertEvaluationAttachment(EvaluationAttachment attachment);

    /**
     * 批量新增附件
     * 
     * @param attachments 附件列表
     * @return 结果
     */
    int insertBatch(List<EvaluationAttachment> attachments);

    /**
     * 根据详情ID数组删除附件
     * 
     * @param detailIds 详情ID数组
     * @return 结果
     */
    int deleteByDetailIds(Long[] detailIds);

    /**
     * 根据详情ID查询所有附件
     * 
     * @param detailId 详情ID
     * @return 附件列表
     */
    List<EvaluationAttachment> selectByDetailId(Long detailId);

    /**
     * 根据详情ID和附件类型查询附件列表
     * 
     * @param detailId 详情ID
     * @param attachmentType 附件类型
     * @return 附件列表
     */
    List<EvaluationAttachment> selectByDetailIdAndType(Long detailId, String attachmentType);

    /**
     * 查询成绩截图
     * 
     * @param detailId 详情ID
     * @return 成绩截图列表
     */
    List<EvaluationAttachment> selectGradeScreenshots(Long detailId);

    /**
     * 查询证书材料
     * 
     * @param detailId 详情ID
     * @return 证书材料列表
     */
    List<EvaluationAttachment> selectCertificates(Long detailId);

    /**
     * 根据提交ID查询所有附件(包含所有详情的附件)
     * 
     * @param submissionId 提交ID
     * @return 附件列表
     */
    List<EvaluationAttachment> selectBySubmissionId(Long submissionId);

    /**
     * 根据提交ID和附件类型查询附件
     * 
     * @param submissionId 提交ID
     * @param attachmentType 附件类型
     * @return 附件列表
     */
    List<EvaluationAttachment> selectBySubmissionIdAndType(Long submissionId, String attachmentType);
}

