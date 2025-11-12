package com.ruoyi.system.service.impl;

import java.util.List;
import javax.validation.Validator;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.vo.StudentImportVO;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysDeptService deptService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    protected Validator validator;

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

    /**
     * 批量导入学生数据
     *
     * @param studentList 学生数据列表
     * @param updateSupport 是否更新已存在的学生数据
     * @param operName 操作用户
     * @return 导入结果消息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importStudents(List<StudentImportVO> studentList, Boolean updateSupport, String operName)
    {
        if (StringUtils.isNull(studentList) || studentList.size() == 0)
        {
            throw new ServiceException("导入学生数据不能为空！");
        }

        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();

        // 获取初始密码配置
        String initPassword = configService.selectConfigByKey("sys.user.initPassword");

        for (StudentImportVO studentVO : studentList)
        {
            try
            {
                // 数据验证
                validateStudentData(studentVO);

                // 根据专业名称和班级查找部门ID
                Long deptId = findDeptIdByMajorAndClass(studentVO.getMajorName(), studentVO.getClassName());
                if (deptId == null)
                {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、学号 " + studentVO.getStudentId() +
                        " 导入失败：未找到专业[" + studentVO.getMajorName() + "]班级[" + studentVO.getClassName() + "]对应的部门");
                    continue;
                }

                // 根据身份分配角色
                Long[] roleIds = mapIdentityToRoles(studentVO.getIdentity());

                // 检查用户是否已存在
                SysUser existingUser = userService.selectUserByUserName(studentVO.getStudentId());

                if (existingUser == null)
                {
                    // 创建新用户
                    SysUser newUser = convertToSysUser(studentVO, deptId, roleIds, initPassword, operName);
                    userService.insertUser(newUser);

                    // 创建学生档案（仅学生和班委）
                    if (isStudentRole(roleIds))
                    {
                        TUserProfile profile = convertToUserProfile(studentVO, newUser.getUserId(), deptId);
                        tUserProfileMapper.insertTUserProfile(profile);
                    }

                    successNum++;
                    successMsg.append("<br/>" + successNum + "、学号 " + studentVO.getStudentId() + " 导入成功");
                }
                else if (updateSupport)
                {
                    // 更新已存在用户
                    SysUser updateUser = convertToSysUser(studentVO, deptId, roleIds, null, operName);
                    updateUser.setUserId(existingUser.getUserId());
                    updateUser.setUpdateBy(operName);
                    userService.updateUser(updateUser);

                    // 更新或创建学生档案
                    if (isStudentRole(roleIds))
                    {
                        TUserProfile existingProfile = tUserProfileMapper.selectTUserProfileByUserId(existingUser.getUserId());
                        if (existingProfile != null)
                        {
                            TUserProfile updateProfile = convertToUserProfile(studentVO, existingUser.getUserId(), deptId);
                            updateProfile.setId(existingProfile.getId());
                            updateProfile.setUpdateTime(DateUtils.getNowDate());
                            tUserProfileMapper.updateTUserProfile(updateProfile);
                        }
                        else
                        {
                            TUserProfile newProfile = convertToUserProfile(studentVO, existingUser.getUserId(), deptId);
                            tUserProfileMapper.insertTUserProfile(newProfile);
                        }
                    }

                    successNum++;
                    successMsg.append("<br/>" + successNum + "、学号 " + studentVO.getStudentId() + " 更新成功");
                }
                else
                {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、学号 " + studentVO.getStudentId() + " 已存在");
                }
            }
            catch (Exception e)
            {
                failureNum++;
                String msg = "<br/>" + failureNum + "、学号 " + studentVO.getStudentId() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
            }
        }

        if (failureNum > 0)
        {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        }
        else
        {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

    /**
     * 验证学生数据
     */
    private void validateStudentData(StudentImportVO studentVO) throws Exception
    {
        if (StringUtils.isEmpty(studentVO.getStudentId()))
        {
            throw new ServiceException("学号不能为空");
        }
        if (StringUtils.isEmpty(studentVO.getName()))
        {
            throw new ServiceException("姓名不能为空");
        }
        if (StringUtils.isEmpty(studentVO.getMajorName()))
        {
            throw new ServiceException("专业名称不能为空");
        }
        if (StringUtils.isEmpty(studentVO.getClassName()))
        {
            throw new ServiceException("班级不能为空");
        }
        if (StringUtils.isEmpty(studentVO.getIdentity()))
        {
            throw new ServiceException("身份不能为空");
        }
    }

    /**
     * 根据专业名称和班级查找部门ID
     * 逻辑：先查找专业部门，再在其子部门中查找班级
     * 支持双向模糊匹配和常见别名
     */
    private Long findDeptIdByMajorAndClass(String majorName, String className)
    {
        // 查询所有部门
        SysDept queryDept = new SysDept();
        queryDept.setStatus("0"); // 正常状态
        List<SysDept> allDepts = deptService.selectDeptList(queryDept);

        // 专业名称标准化（处理常见别名）
        String normalizedMajorName = normalizeMajorName(majorName);

        // 第一步：查找专业部门（支持双向模糊匹配）
        SysDept majorDept = null;
        for (SysDept dept : allDepts)
        {
            String deptName = dept.getDeptName();
            // 双向模糊匹配：A包含B 或 B包含A
            if (deptName.contains(normalizedMajorName) || normalizedMajorName.contains(deptName))
            {
                majorDept = dept;
                break;
            }
        }

        if (majorDept == null)
        {
            return null;
        }

        // 第二步：在专业部门的子部门中查找班级
        for (SysDept dept : allDepts)
        {
            // 检查是否是专业部门的子部门，并且部门名称包含班级名
            if (dept.getAncestors() != null &&
                dept.getAncestors().contains(majorDept.getDeptId().toString()) &&
                dept.getDeptName().contains(className))
            {
                return dept.getDeptId();
            }
        }

        return null;
    }

    /**
     * 专业名称标准化（处理常见别名）
     */
    private String normalizeMajorName(String majorName)
    {
        if (StringUtils.isEmpty(majorName))
        {
            return majorName;
        }

        // 处理常见别名映射
        if (majorName.contains("计算机科学与技术") || majorName.contains("计算机科学"))
        {
            return "计算机科学与技术";  // 匹配数据库中的实际名称
        }

        // 可以继续添加其他专业的别名映射
        // 例如：
        // if (majorName.contains("软件工程")) return "软件工程";
        // if (majorName.contains("人工智能")) return "人工智能";

        return majorName;
    }

    /**
     * 根据身份映射角色ID
     */
    private Long[] mapIdentityToRoles(String identity)
    {
        if (StringUtils.isEmpty(identity))
        {
            throw new ServiceException("身份不能为空");
        }

        switch (identity.trim())
        {
            case "学生":
                return new Long[]{100L}; // 学生角色
            case "班委":
                return new Long[]{100L, 101L}; // 学生+班委双角色
            case "辅导员":
                return new Long[]{102L}; // 辅导员角色
            default:
                throw new ServiceException("身份[" + identity + "]不合法，只能是：学生、班委、辅导员");
        }
    }

    /**
     * 判断是否包含学生角色
     */
    private boolean isStudentRole(Long[] roleIds)
    {
        if (roleIds == null || roleIds.length == 0)
        {
            return false;
        }
        for (Long roleId : roleIds)
        {
            if (roleId == 100L || roleId == 101L) // 学生或班委
            {
                return true;
            }
        }
        return false;
    }

    /**
     * 将StudentImportVO转换为SysUser
     */
    private SysUser convertToSysUser(StudentImportVO studentVO, Long deptId, Long[] roleIds,
                                      String password, String operName)
    {
        SysUser user = new SysUser();
        user.setUserName(studentVO.getStudentId()); // 学号作为登录账号
        // nickName 存储真实姓名（导入后用户可自行修改昵称）
        user.setNickName(studentVO.getName());
        user.setDeptId(deptId);
        user.setRoleIds(roleIds);

        // 性别转换：男=0, 女=1, 未知=2
        if (StringUtils.isNotEmpty(studentVO.getSex()))
        {
            if ("男".equals(studentVO.getSex()))
            {
                user.setSex("0");
            }
            else if ("女".equals(studentVO.getSex()))
            {
                user.setSex("1");
            }
            else
            {
                user.setSex("2");
            }
        }
        else
        {
            user.setSex("2"); // 默认未知
        }

        user.setEmail(studentVO.getEmail());
        user.setPhonenumber(studentVO.getPhonenumber());
        user.setStatus("0"); // 正常状态

        // 设置密码（仅新建用户时）
        if (StringUtils.isNotEmpty(password))
        {
            user.setPassword(SecurityUtils.encryptPassword(password));
        }

        user.setCreateBy(operName);

        return user;
    }

    /**
     * 将StudentImportVO转换为TUserProfile
     */
    private TUserProfile convertToUserProfile(StudentImportVO studentVO, Long userId, Long deptId)
    {
        TUserProfile profile = new TUserProfile();
        profile.setUserId(userId);
        profile.setStudentId(studentVO.getStudentId());
        profile.setDeptId(deptId); // 设置部门ID

        // 从部门信息解析学院、专业、班级
        SysDept classDept = deptService.selectDeptById(deptId);
        if (classDept != null)
        {
            profile.setClassName(classDept.getDeptName()); // 班级名称

            // 获取专业（父部门）
            if (classDept.getParentId() != null && classDept.getParentId() != 0)
            {
                SysDept majorDept = deptService.selectDeptById(classDept.getParentId());
                if (majorDept != null)
                {
                    profile.setMajor(majorDept.getDeptName()); // 专业名称

                    // 获取学院（专业的父部门）
                    if (majorDept.getParentId() != null && majorDept.getParentId() != 0)
                    {
                        SysDept collegeDept = deptService.selectDeptById(majorDept.getParentId());
                        if (collegeDept != null)
                        {
                            profile.setCollege(collegeDept.getDeptName()); // 学院名称
                        }
                    }
                }
            }
        }

        // 从学号推断年级（假设学号格式：2507240101，前2位是年级）
        if (StringUtils.isNotEmpty(studentVO.getStudentId()) && studentVO.getStudentId().length() >= 2)
        {
            try
            {
                String gradePrefix = studentVO.getStudentId().substring(0, 2);
                Integer.parseInt(gradePrefix); // 验证是否为数字
                profile.setGrade("20" + gradePrefix); // 例如：25 -> 2025
            }
            catch (Exception e)
            {
                // 如果解析失败，不设置年级
            }
        }

        profile.setPoliticalStatus(studentVO.getPoliticalStatus());
        profile.setEnrollmentDate(studentVO.getEnrollmentDate());
        profile.setStatus(1L); // 默认启用状态
        profile.setCreateTime(DateUtils.getNowDate());

        return profile;
    }
}
