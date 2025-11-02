package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.EvaluationSubmissionDetail;
import java.util.List;

/**
 * 综测填报详情Mapper接口
 */
public interface EvaluationSubmissionDetailMapper {
    /**
     * 根据submissionId删除详情
     */
    int deleteBySubmissionId(Long submissionId);

    /**
     * 新增单条详情（使用主键回填）
     */
    int insertEvaluationSubmissionDetail(EvaluationSubmissionDetail detail);

    /**
     * 批量新增详情
     */
    int insertBatch(List<EvaluationSubmissionDetail> details);
}