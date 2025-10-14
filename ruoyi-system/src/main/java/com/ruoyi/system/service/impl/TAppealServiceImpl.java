package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TAppealMapper;
import com.ruoyi.system.domain.TAppeal;
import com.ruoyi.system.service.ITAppealService;

/**
 * 申诉Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
@Service
public class TAppealServiceImpl implements ITAppealService 
{
    @Autowired
    private TAppealMapper tAppealMapper;

    /**
     * 查询申诉
     * 
     * @param id 申诉主键
     * @return 申诉
     */
    @Override
    public TAppeal selectTAppealById(Long id)
    {
        return tAppealMapper.selectTAppealById(id);
    }

    /**
     * 查询申诉列表
     * 
     * @param tAppeal 申诉
     * @return 申诉
     */
    @Override
    public List<TAppeal> selectTAppealList(TAppeal tAppeal)
    {
        return tAppealMapper.selectTAppealList(tAppeal);
    }

    /**
     * 新增申诉
     * 
     * @param tAppeal 申诉
     * @return 结果
     */
    @Override
    public int insertTAppeal(TAppeal tAppeal)
    {
        tAppeal.setCreateTime(DateUtils.getNowDate());
        return tAppealMapper.insertTAppeal(tAppeal);
    }

    /**
     * 修改申诉
     * 
     * @param tAppeal 申诉
     * @return 结果
     */
    @Override
    public int updateTAppeal(TAppeal tAppeal)
    {
        return tAppealMapper.updateTAppeal(tAppeal);
    }

    /**
     * 批量删除申诉
     * 
     * @param ids 需要删除的申诉主键
     * @return 结果
     */
    @Override
    public int deleteTAppealByIds(Long[] ids)
    {
        return tAppealMapper.deleteTAppealByIds(ids);
    }

    /**
     * 删除申诉信息
     * 
     * @param id 申诉主键
     * @return 结果
     */
    @Override
    public int deleteTAppealById(Long id)
    {
        return tAppealMapper.deleteTAppealById(id);
    }
}
