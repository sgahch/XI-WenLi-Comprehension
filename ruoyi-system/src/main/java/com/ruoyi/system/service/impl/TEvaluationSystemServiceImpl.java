package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TEvaluationSystemMapper;
import com.ruoyi.system.domain.TEvaluationSystem;
import com.ruoyi.system.service.ITEvaluationSystemService;

/**
 * 测评体系Service业务层处理
 * 
 * @author ynchen
 * @date 2025-10-01
 */
@Service
public class TEvaluationSystemServiceImpl implements ITEvaluationSystemService 
{
    @Autowired
    private TEvaluationSystemMapper tEvaluationSystemMapper;

    /**
     * 查询测评体系
     * 
     * @param id 测评体系主键
     * @return 测评体系
     */
    @Override
    public TEvaluationSystem selectTEvaluationSystemById(Long id)
    {
        return tEvaluationSystemMapper.selectTEvaluationSystemById(id);
    }

    /**
     * 查询测评体系列表
     * 
     * @param tEvaluationSystem 测评体系
     * @return 测评体系
     */
    @Override
    public List<TEvaluationSystem> selectTEvaluationSystemList(TEvaluationSystem tEvaluationSystem)
    {
        return tEvaluationSystemMapper.selectTEvaluationSystemList(tEvaluationSystem);
    }

    /**
     * 新增测评体系
     * 
     * @param tEvaluationSystem 测评体系
     * @return 结果
     */
    @Override
    public int insertTEvaluationSystem(TEvaluationSystem tEvaluationSystem)
    {
        tEvaluationSystem.setCreateTime(DateUtils.getNowDate());
        return tEvaluationSystemMapper.insertTEvaluationSystem(tEvaluationSystem);
    }

    /**
     * 修改测评体系
     * 
     * @param tEvaluationSystem 测评体系
     * @return 结果
     */
    @Override
    public int updateTEvaluationSystem(TEvaluationSystem tEvaluationSystem)
    {
        tEvaluationSystem.setUpdateTime(DateUtils.getNowDate());
        return tEvaluationSystemMapper.updateTEvaluationSystem(tEvaluationSystem);
    }

    /**
     * 批量删除测评体系
     * 
     * @param ids 需要删除的测评体系主键
     * @return 结果
     */
    @Override
    public int deleteTEvaluationSystemByIds(Long[] ids)
    {
        return tEvaluationSystemMapper.deleteTEvaluationSystemByIds(ids);
    }

    /**
     * 删除测评体系信息
     * 
     * @param id 测评体系主键
     * @return 结果
     */
    @Override
    public int deleteTEvaluationSystemById(Long id)
    {
        return tEvaluationSystemMapper.deleteTEvaluationSystemById(id);
    }
}
