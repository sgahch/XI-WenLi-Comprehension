package com.ruoyi.evaluation.mapper;

import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

/**
 * 综合测评规则Mapper接口
 * 
 * @author ruoyi
 * @date 2025-11-03
 */
public interface EvaluationRuleMapper 
{
    /**
     * 根据维度查询规则列表
     * 
     * @param params 查询参数（包含dimension）
     * @return 规则列表
     */
    List<Map<String, Object>> selectRulesByDimension(Map<String, Object> params);
}

