package com.ruoyi.system.service;

import com.ruoyi.system.domain.TUserProfile;
import com.ruoyi.system.domain.vo.StudentImportVO;

import java.util.List;


/**
 * 学生档案管理Service接口
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public interface ITUserProfileService 
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
     * 批量删除学生档案管理
     * 
     * @param ids 需要删除的学生档案管理主键集合
     * @return 结果
     */
    public int deleteTUserProfileByIds(Long[] ids);

    /**
     * 删除学生档案管理信息
     *
     * @param id 学生档案管理主键
     * @return 结果
     */
    public int deleteTUserProfileById(Long id);

    /**
     * 批量导入学生数据
     *
     * @param studentList 学生数据列表
     * @param updateSupport 是否更新已存在的学生数据
     * @param operName 操作用户
     * @return 导入结果消息
     */
    public String importStudents(List<StudentImportVO> studentList, Boolean updateSupport, String operName);
}
