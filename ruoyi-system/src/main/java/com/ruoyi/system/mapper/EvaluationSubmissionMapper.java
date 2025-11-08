package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.EvaluationSubmission;

/**
 * 综测填报Mapper接口
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public interface EvaluationSubmissionMapper 
{
    /**
     * 查询综测填报
     * 
     * @param id 综测填报主键
     * @return 综测填报
     */
    public EvaluationSubmission selectEvaluationSubmissionById(Long id);

    /**
     * 查询综测填报列表
     * 
     * @param evaluationSubmission 综测填报
     * @return 综测填报集合
     */
    public List<EvaluationSubmission> selectEvaluationSubmissionList(EvaluationSubmission evaluationSubmission);

    /**
     * 新增综测填报
     * 
     * @param evaluationSubmission 综测填报
     * @return 结果
     */
    public int insertEvaluationSubmission(EvaluationSubmission evaluationSubmission);

    /**
     * 修改综测填报
     * 
     * @param evaluationSubmission 综测填报
     * @return 结果
     */
    public int updateEvaluationSubmission(EvaluationSubmission evaluationSubmission);

    /**
     * 删除综测填报
     * 
     * @param id 综测填报主键
     * @return 结果
     */
    public int deleteEvaluationSubmissionById(Long id);

    /**
     * 批量删除综测填报
     * 
     * @param ids 需要删除的综测填报主键数组
     * @return 结果
     */
    public int deleteEvaluationSubmissionByIds(Long[] ids);

    /**
     * 统计填报数量
     * 
     * @param evaluationSubmission 查询条件
     * @return 数量
     */
    public int countSubmissions(EvaluationSubmission evaluationSubmission);

    /**
     * 按状态统计
     *
     * @param evaluationSubmission 查询条件
     * @return 状态统计列表
     */
    public List<Map<String, Object>> countByStatus(EvaluationSubmission evaluationSubmission);

    /**
     * 获取平均分统计
     * 
     * @param evaluationSubmission 查询条件
     * @return 平均分统计
     */
    public Map<String, Object> getAverageScores(EvaluationSubmission evaluationSubmission);
}