package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.EvaluationAttachment;
import org.apache.ibatis.annotations.Param;
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

    /**
     * 根据详情ID和附件类型查询附件列表
     *
     * @param detailId 详情ID
     * @param attachmentType 附件类型
     * @return 附件列表
     */
    List<EvaluationAttachment> selectByDetailIdAndType(@Param("detailId") Long detailId,
                                                        @Param("attachmentType") String attachmentType);

    /**
     * 根据详情ID查询所有附件
     *
     * @param detailId 详情ID
     * @return 附件列表
     */
    List<EvaluationAttachment> selectByDetailId(@Param("detailId") Long detailId);
}