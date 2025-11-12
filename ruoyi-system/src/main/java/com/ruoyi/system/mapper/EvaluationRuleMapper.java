package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EvaluationRule;

/**
 * 计分规则Mapper接口
 * 
 * @author ruoyi
 * @date 2025-11-09
 */
public interface EvaluationRuleMapper 
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
     * 删除计分规则
     * 
     * @param id 计分规则主键
     * @return 结果
     */
    public int deleteEvaluationRuleById(Long id);

    /**
     * 批量删除计分规则
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEvaluationRuleByIds(Long[] ids);

    /**
     * 根据维度查询规则列表（用于前端级联选择器）
     *
     * @param params 查询参数（包含dimension）
     * @return 规则列表
     */
    List<Map<String, Object>> selectRulesByDimension(@Param("dimension") String dimension);
}
