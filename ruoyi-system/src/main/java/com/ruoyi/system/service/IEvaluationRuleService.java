package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EvaluationRule;

/**
 * 计分规则Service接口
 * 
 * @author ruoyi
 * @date 2025-11-09
 */
public interface IEvaluationRuleService 
{
    /**
     * 查询计分规则
     * 
     * @param id 计分规则主键
     * @return 计分规则
     */
    public EvaluationRule selectEvaluationRuleById(Long id);

    /**
     * 查询计分规则列表
     * 
     * @param evaluationRule 计分规则
     * @return 计分规则集合
     */
    public List<EvaluationRule> selectEvaluationRuleList(EvaluationRule evaluationRule);

    /**
     * 新增计分规则
     * 
     * @param evaluationRule 计分规则
     * @return 结果
     */
    public int insertEvaluationRule(EvaluationRule evaluationRule);

    /**
     * 修改计分规则
     * 
     * @param evaluationRule 计分规则
     * @return 结果
     */
    public int updateEvaluationRule(EvaluationRule evaluationRule);

    /**
     * 批量删除计分规则
     * 
     * @param ids 需要删除的计分规则主键集合
     * @return 结果
     */
    public int deleteEvaluationRuleByIds(Long[] ids);

    /**
     * 删除计分规则信息
     * 
     * @param id 计分规则主键
     * @return 结果
     */
    public int deleteEvaluationRuleById(Long id);
}
