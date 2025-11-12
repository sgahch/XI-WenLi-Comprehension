package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.EvaluationRuleMapper;
import com.ruoyi.system.domain.EvaluationRule;
import com.ruoyi.system.service.IEvaluationRuleService;

/**
 * 计分规则Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-09
 */
@Service
public class EvaluationRuleServiceImpl implements IEvaluationRuleService 
{
    @Autowired
    private EvaluationRuleMapper evaluationRuleMapper;

    /**
     * 查询计分规则
     * 
     * @param id 计分规则主键
     * @return 计分规则
     */
    @Override
    public EvaluationRule selectEvaluationRuleById(Long id)
    {
        return evaluationRuleMapper.selectEvaluationRuleById(id);
    }

    /**
     * 查询计分规则列表
     * 
     * @param evaluationRule 计分规则
     * @return 计分规则
     */
    @Override
    public List<EvaluationRule> selectEvaluationRuleList(EvaluationRule evaluationRule)
    {
        return evaluationRuleMapper.selectEvaluationRuleList(evaluationRule);
    }

    /**
     * 新增计分规则
     * 
     * @param evaluationRule 计分规则
     * @return 结果
     */
    @Override
    public int insertEvaluationRule(EvaluationRule evaluationRule)
    {
        evaluationRule.setCreateTime(DateUtils.getNowDate());
        return evaluationRuleMapper.insertEvaluationRule(evaluationRule);
    }

    /**
     * 修改计分规则
     * 
     * @param evaluationRule 计分规则
     * @return 结果
     */
    @Override
    public int updateEvaluationRule(EvaluationRule evaluationRule)
    {
        evaluationRule.setUpdateTime(DateUtils.getNowDate());
        return evaluationRuleMapper.updateEvaluationRule(evaluationRule);
    }

    /**
     * 批量删除计分规则
     * 
     * @param ids 需要删除的计分规则主键
     * @return 结果
     */
    @Override
    public int deleteEvaluationRuleByIds(Long[] ids)
    {
        return evaluationRuleMapper.deleteEvaluationRuleByIds(ids);
    }

    /**
     * 删除计分规则信息
     * 
     * @param id 计分规则主键
     * @return 结果
     */
    @Override
    public int deleteEvaluationRuleById(Long id)
    {
        return evaluationRuleMapper.deleteEvaluationRuleById(id);
    }
}
