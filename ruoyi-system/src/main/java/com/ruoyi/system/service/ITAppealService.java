package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TAppeal;

/**
 * 申诉Service接口
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public interface ITAppealService 
{
    /**
     * 查询申诉
     * 
     * @param id 申诉主键
     * @return 申诉
     */
    public TAppeal selectTAppealById(Long id);

    /**
     * 查询申诉列表
     * 
     * @param tAppeal 申诉
     * @return 申诉集合
     */
    public List<TAppeal> selectTAppealList(TAppeal tAppeal);

    /**
     * 新增申诉
     * 
     * @param tAppeal 申诉
     * @return 结果
     */
    public int insertTAppeal(TAppeal tAppeal);

    /**
     * 修改申诉
     * 
     * @param tAppeal 申诉
     * @return 结果
     */
    public int updateTAppeal(TAppeal tAppeal);

    /**
     * 批量删除申诉
     * 
     * @param ids 需要删除的申诉主键集合
     * @return 结果
     */
    public int deleteTAppealByIds(Long[] ids);

    /**
     * 删除申诉信息
     * 
     * @param id 申诉主键
     * @return 结果
     */
    public int deleteTAppealById(Long id);
}
