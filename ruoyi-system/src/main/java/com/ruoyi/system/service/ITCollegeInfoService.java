package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TCollegeInfo;

/**
 * 学院信息Service接口
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public interface ITCollegeInfoService 
{
    /**
     * 查询学院信息
     * 
     * @param id 学院信息主键
     * @return 学院信息
     */
    public TCollegeInfo selectTCollegeInfoById(Long id);

    /**
     * 查询学院信息列表
     * 
     * @param tCollegeInfo 学院信息
     * @return 学院信息集合
     */
    public List<TCollegeInfo> selectTCollegeInfoList(TCollegeInfo tCollegeInfo);

    /**
     * 新增学院信息
     * 
     * @param tCollegeInfo 学院信息
     * @return 结果
     */
    public int insertTCollegeInfo(TCollegeInfo tCollegeInfo);

    /**
     * 修改学院信息
     * 
     * @param tCollegeInfo 学院信息
     * @return 结果
     */
    public int updateTCollegeInfo(TCollegeInfo tCollegeInfo);

    /**
     * 批量删除学院信息
     * 
     * @param ids 需要删除的学院信息主键集合
     * @return 结果
     */
    public int deleteTCollegeInfoByIds(Long[] ids);

    /**
     * 删除学院信息信息
     * 
     * @param id 学院信息主键
     * @return 结果
     */
    public int deleteTCollegeInfoById(Long id);
}
