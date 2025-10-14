package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TCollegeInfoMapper;
import com.ruoyi.system.domain.TCollegeInfo;
import com.ruoyi.system.service.ITCollegeInfoService;

/**
 * 学院信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
@Service
public class TCollegeInfoServiceImpl implements ITCollegeInfoService 
{
    @Autowired
    private TCollegeInfoMapper tCollegeInfoMapper;

    /**
     * 查询学院信息
     * 
     * @param id 学院信息主键
     * @return 学院信息
     */
    @Override
    public TCollegeInfo selectTCollegeInfoById(Long id)
    {
        return tCollegeInfoMapper.selectTCollegeInfoById(id);
    }

    /**
     * 查询学院信息列表
     * 
     * @param tCollegeInfo 学院信息
     * @return 学院信息
     */
    @Override
    public List<TCollegeInfo> selectTCollegeInfoList(TCollegeInfo tCollegeInfo)
    {
        return tCollegeInfoMapper.selectTCollegeInfoList(tCollegeInfo);
    }

    /**
     * 新增学院信息
     * 
     * @param tCollegeInfo 学院信息
     * @return 结果
     */
    @Override
    public int insertTCollegeInfo(TCollegeInfo tCollegeInfo)
    {
        tCollegeInfo.setCreateTime(DateUtils.getNowDate());
        return tCollegeInfoMapper.insertTCollegeInfo(tCollegeInfo);
    }

    /**
     * 修改学院信息
     * 
     * @param tCollegeInfo 学院信息
     * @return 结果
     */
    @Override
    public int updateTCollegeInfo(TCollegeInfo tCollegeInfo)
    {
        tCollegeInfo.setUpdateTime(DateUtils.getNowDate());
        return tCollegeInfoMapper.updateTCollegeInfo(tCollegeInfo);
    }

    /**
     * 批量删除学院信息
     * 
     * @param ids 需要删除的学院信息主键
     * @return 结果
     */
    @Override
    public int deleteTCollegeInfoByIds(Long[] ids)
    {
        return tCollegeInfoMapper.deleteTCollegeInfoByIds(ids);
    }

    /**
     * 删除学院信息信息
     * 
     * @param id 学院信息主键
     * @return 结果
     */
    @Override
    public int deleteTCollegeInfoById(Long id)
    {
        return tCollegeInfoMapper.deleteTCollegeInfoById(id);
    }
}
