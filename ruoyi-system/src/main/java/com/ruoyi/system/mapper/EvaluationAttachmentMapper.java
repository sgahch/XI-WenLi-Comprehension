package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.EvaluationAttachment;
import java.util.List;

/**
 * 综测附件Mapper接口
 */
public interface EvaluationAttachmentMapper {
    /**
     * 根据详情ID数组删除附件
     */
    int deleteByDetailIds(Long[] detailIds);

    /**
     * 新增附件
     */
    int insertEvaluationAttachment(EvaluationAttachment attachment);

    /**
     * 批量新增附件
     */
    int insertBatch(List<EvaluationAttachment> attachments);
}