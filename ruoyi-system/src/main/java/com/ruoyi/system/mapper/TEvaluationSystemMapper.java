package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TEvaluationSystem;

/**
 * 测评体系Mapper接口
 * 
 * @author ynchen
 * @date 2025-10-01
 */
public interface TEvaluationSystemMapper 
{
    /**
     * 查询测评体系
     * 
     * @param id 测评体系主键
     * @return 测评体系
     */
    public TEvaluationSystem selectTEvaluationSystemById(Long id);

    /**
     * 查询测评体系列表
     * 
     * @param tEvaluationSystem 测评体系
     * @return 测评体系集合
     */
    public List<TEvaluationSystem> selectTEvaluationSystemList(TEvaluationSystem tEvaluationSystem);

    /**
     * 新增测评体系
     * 
     * @param tEvaluationSystem 测评体系
     * @return 结果
     */
    public int insertTEvaluationSystem(TEvaluationSystem tEvaluationSystem);

    /**
     * 修改测评体系
     * 
     * @param tEvaluationSystem 测评体系
     * @return 结果
     */
    public int updateTEvaluationSystem(TEvaluationSystem tEvaluationSystem);

    /**
     * 删除测评体系
     * 
     * @param id 测评体系主键
     * @return 结果
     */
    public int deleteTEvaluationSystemById(Long id);

    /**
     * 批量删除测评体系
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTEvaluationSystemByIds(Long[] ids);
}
