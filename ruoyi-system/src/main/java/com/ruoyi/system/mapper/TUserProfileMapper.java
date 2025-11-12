package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.TUserProfile;

import java.util.List;


/**
 * 学生档案管理Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public interface TUserProfileMapper 
{
    /**
     * 查询学生档案管理
     * 
     * @param id 学生档案管理主键
     * @return 学生档案管理
     */
    public TUserProfile selectTUserProfileById(Long id);

    /**
     * 查询学生档案管理列表
     * 
     * @param tUserProfile 学生档案管理
     * @return 学生档案管理集合
     */
    public List<TUserProfile> selectTUserProfileList(TUserProfile tUserProfile);

    /**
     * 新增学生档案管理
     * 
     * @param tUserProfile 学生档案管理
     * @return 结果
     */
    public int insertTUserProfile(TUserProfile tUserProfile);

    /**
     * 修改学生档案管理
     * 
     * @param tUserProfile 学生档案管理
     * @return 结果
     */
    public int updateTUserProfile(TUserProfile tUserProfile);

    /**
     * 删除学生档案管理
     * 
     * @param id 学生档案管理主键
     * @return 结果
     */
    public int deleteTUserProfileById(Long id);

    /**
     * 批量删除学生档案管理
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTUserProfileByIds(Long[] ids);

    /**
     * 根据用户ID查询学生档案
     *
     * @param userId 用户ID
     * @return 学生档案
     */
    public TUserProfile selectTUserProfileByUserId(Long userId);
}
