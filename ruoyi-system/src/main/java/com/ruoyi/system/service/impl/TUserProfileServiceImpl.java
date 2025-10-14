package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TUserProfileMapper;
import com.ruoyi.system.domain.TUserProfile;
import com.ruoyi.system.service.ITUserProfileService;

/**
 * 学生档案管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
@Service
public class TUserProfileServiceImpl implements ITUserProfileService 
{
    @Autowired
    private TUserProfileMapper tUserProfileMapper;

    /**
     * 查询学生档案管理
     * 
     * @param id 学生档案管理主键
     * @return 学生档案管理
     */
    @Override
    public TUserProfile selectTUserProfileById(Long id)
    {
        return tUserProfileMapper.selectTUserProfileById(id);
    }

    /**
     * 查询学生档案管理列表
     * 
     * @param tUserProfile 学生档案管理
     * @return 学生档案管理
     */
    @Override
    public List<TUserProfile> selectTUserProfileList(TUserProfile tUserProfile)
    {
        return tUserProfileMapper.selectTUserProfileList(tUserProfile);
    }

    /**
     * 新增学生档案管理
     * 
     * @param tUserProfile 学生档案管理
     * @return 结果
     */
    @Override
    public int insertTUserProfile(TUserProfile tUserProfile)
    {
        tUserProfile.setCreateTime(DateUtils.getNowDate());
        return tUserProfileMapper.insertTUserProfile(tUserProfile);
    }

    /**
     * 修改学生档案管理
     * 
     * @param tUserProfile 学生档案管理
     * @return 结果
     */
    @Override
    public int updateTUserProfile(TUserProfile tUserProfile)
    {
        tUserProfile.setUpdateTime(DateUtils.getNowDate());
        return tUserProfileMapper.updateTUserProfile(tUserProfile);
    }

    /**
     * 批量删除学生档案管理
     * 
     * @param ids 需要删除的学生档案管理主键
     * @return 结果
     */
    @Override
    public int deleteTUserProfileByIds(Long[] ids)
    {
        return tUserProfileMapper.deleteTUserProfileByIds(ids);
    }

    /**
     * 删除学生档案管理信息
     * 
     * @param id 学生档案管理主键
     * @return 结果
     */
    @Override
    public int deleteTUserProfileById(Long id)
    {
        return tUserProfileMapper.deleteTUserProfileById(id);
    }
}
