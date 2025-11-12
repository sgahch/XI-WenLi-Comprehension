package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import com.ruoyi.system.domain.TUserProfile;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.mapper.TUserProfileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 综测权限服务实现类
 *
 * @author ruoyi
 * @date 2024-12-19
 */
@Service
public class EvaluationPermissionService
{
    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private TUserProfileMapper userProfileMapper;
    /**
     * 检查用户是否有综测学生权限
     */
    public boolean isEvaluationStudent()
    {
        return SecurityUtils.hasRole("evaluation_student");
    }

    /**
     * 检查用户是否有综测教师权限
     */
    public boolean isEvaluationTeacher()
    {
        return SecurityUtils.hasRole("evaluation_teacher");
    }

    /**
     * 检查用户是否有综测管理员权限
     */
    public boolean isEvaluationAdmin()
    {
        return SecurityUtils.hasRole("evaluation_admin");
    }

    /**
     * 检查用户是否可以查看指定学生的成绩数据
     * 
     * @param studentId 学生ID
     * @return 是否有权限
     */
    public boolean canViewStudentScore(String studentId)
    {
        // 管理员可以查看所有数据
        if (isEvaluationAdmin())
        {
            return true;
        }

        // 无论拥有哪些角色，用户都可以查看自己的数据
        SysUser currentUser = SecurityUtils.getLoginUser().getUser();
        String currentUserName = currentUser != null ? currentUser.getUserName() : null;
        String currentUserIdStr = currentUser != null ? String.valueOf(currentUser.getUserId()) : null;
        if (StringUtils.equals(currentUserName, studentId) || StringUtils.equals(currentUserIdStr, studentId))
        {
            return true;
        }

        // 学生只能查看自己的数据（已在上方自查覆盖）
        if (isEvaluationStudent())
        {
            return false;
        }

        // 教师可以查看本班级学生数据（需要根据具体业务逻辑实现）
        if (isEvaluationTeacher())
        {
            return canTeacherViewStudent(studentId);
        }

        return false;
    }

    /**
     * 检查用户是否可以编辑指定学生的成绩数据
     * 
     * @param studentId 学生ID
     * @return 是否有权限
     */
    public boolean canEditStudentScore(String studentId)
    {
        // 管理员可以编辑所有数据
        if (isEvaluationAdmin())
        {
            return true;
        }

        // 无论拥有哪些角色，用户都可以编辑自己的数据
        SysUser currentUser = SecurityUtils.getLoginUser().getUser();
        String currentUserName = currentUser != null ? currentUser.getUserName() : null;
        String currentUserIdStr = currentUser != null ? String.valueOf(currentUser.getUserId()) : null;
        if (StringUtils.equals(currentUserName, studentId) || StringUtils.equals(currentUserIdStr, studentId))
        {
            return true;
        }

        // 学生只能编辑自己的数据（已在上方自查覆盖）
        if (isEvaluationStudent())
        {
            return false;
        }

        // 教师可以编辑本班级学生数据（通常限制为审核场景）
        if (isEvaluationTeacher())
        {
            return canTeacherEditStudent(studentId);
        }

        return false;
    }

    /**
     * 检查用户是否可以审核指定学生的成绩数据
     * 
     * @param studentId 学生ID
     * @return 是否有权限
     */
    public boolean canAuditStudentScore(String studentId)
    {
        // 只有教师和管理员可以审核
        if (isEvaluationAdmin())
        {
            return true;
        }

        if (isEvaluationTeacher())
        {
            return canTeacherViewStudent(studentId);
        }

        return false;
    }

    /**
     * 根据用户权限过滤成绩数据列表
     * 
     * @param scoreList 原始成绩列表
     * @return 过滤后的成绩列表
     */
    public List<TSemesterScoreDetail> filterScoreDataByPermission(List<TSemesterScoreDetail> scoreList)
    {
        if (scoreList == null || scoreList.isEmpty())
        {
            return scoreList;
        }

        // 管理员可以查看所有数据
        if (isEvaluationAdmin())
        {
            return scoreList;
        }

        SysUser currentUser = SecurityUtils.getLoginUser().getUser();
        String currentUserName = currentUser != null ? currentUser.getUserName() : null;
        String currentUserIdStr = currentUser != null ? String.valueOf(currentUser.getUserId()) : null;

        // 教师：允许查看本班级学生数据，同时始终包含自己的记录
        if (isEvaluationTeacher())
        {
            return scoreList.stream()
                    .filter(score -> StringUtils.equals(score.getStudentId(), currentUserName)
                            || StringUtils.equals(score.getStudentId(), currentUserIdStr)
                            || canTeacherViewStudent(score.getStudentId()))
                    .collect(Collectors.toList());
        }

        // 学生或其他角色：始终只返回自己的记录
        return scoreList.stream()
                .filter(score -> StringUtils.equals(score.getStudentId(), currentUserName)
                        || StringUtils.equals(score.getStudentId(), currentUserIdStr))
                .collect(Collectors.toList());
    }

    /**
     * 检查教师是否可以查看指定学生数据
     *
     * @param studentId 学生ID
     * @return 是否有权限
     */
    private boolean canTeacherViewStudent(String studentId)
    {
        SysUser currentUser = SecurityUtils.getLoginUser().getUser();
        if (currentUser == null || currentUser.getDeptId() == null)
        {
            return false;
        }

        // 方案1: 通过sys_user表的dept_id判断（假设学生的dept_id对应其班级）
        // 先尝试通过userName查询学生用户
        SysUser studentUser = sysUserMapper.selectUserByUserName(studentId);
        if (studentUser != null && studentUser.getDeptId() != null)
        {
            // 教师和学生在同一部门（班级），则有权限
            if (currentUser.getDeptId().equals(studentUser.getDeptId()))
            {
                return true;
            }
        }

        // 方案2: 如果方案1未匹配，尝试通过userId查询
        try
        {
            Long studentUserId = Long.parseLong(studentId);
            studentUser = sysUserMapper.selectUserById(studentUserId);
            if (studentUser != null && studentUser.getDeptId() != null)
            {
                if (currentUser.getDeptId().equals(studentUser.getDeptId()))
                {
                    return true;
                }
            }
        }
        catch (NumberFormatException e)
        {
            // studentId不是数字，忽略此方案
        }

        // 方案3: 通过t_user_profile表的className判断（如果教师的部门名称与学生的班级名称匹配）
        TUserProfile profile = new TUserProfile();
        profile.setStudentId(studentId);
        List<TUserProfile> profiles = userProfileMapper.selectTUserProfileList(profile);
        if (profiles != null && !profiles.isEmpty())
        {
            String studentClassName = profiles.get(0).getClassName();
            if (StringUtils.isNotEmpty(studentClassName) && currentUser.getDept() != null)
            {
                // 如果教师的部门名称与学生的班级名称匹配
                if (studentClassName.equals(currentUser.getDept().getDeptName()))
                {
                    return true;
                }
            }
        }

        // 默认不允许访问
        return false;
    }

    /**
     * 检查教师是否可以编辑指定学生数据
     * 
     * @param studentId 学生ID
     * @return 是否有权限
     */
    private boolean canTeacherEditStudent(String studentId)
    {
        // 教师通常只能审核，不能直接编辑学生数据
        // 除非是特殊情况（如数据纠错）
        return false;
    }

    /**
     * 获取当前用户的数据权限范围SQL条件
     * 
     * @param tableAlias 表别名
     * @return SQL条件字符串
     */
    public String getDataScopeCondition(String tableAlias)
    {
        StringBuilder condition = new StringBuilder();
        
        // 管理员无限制
        if (isEvaluationAdmin())
        {
            return "";
        }

        SysUser currentUser = SecurityUtils.getLoginUser().getUser();

        // 始终允许用户查看/查询自己的数据
        if (currentUser != null)
        {
            condition.append(" AND (")
                    .append(tableAlias).append(".student_id = '").append(currentUser.getUserName()).append("'")
                    .append(" OR ")
                    .append(tableAlias).append(".student_id = '").append(String.valueOf(currentUser.getUserId())).append("')");
        }

        // 教师只能查看本班级数据
        if (isEvaluationTeacher() && currentUser != null)
        {
            // 方案1: 基于教师的dept_id，查看同一部门（班级）的学生数据
            // 假设学生数据表中有class_id字段，且class_id对应sys_user的dept_id
            if (currentUser.getDeptId() != null)
            {
                // 允许查看class_id与教师dept_id匹配的数据
                condition.append(" OR ").append(tableAlias).append(".class_id = '")
                        .append(currentUser.getDeptId()).append("'");

                // 同时支持通过class_name匹配（如果教师的部门名称对应班级名称）
                if (currentUser.getDept() != null && StringUtils.isNotEmpty(currentUser.getDept().getDeptName()))
                {
                    condition.append(" OR ").append(tableAlias).append(".class_name = '")
                            .append(currentUser.getDept().getDeptName()).append("'");
                }
            }
        }

        return condition.toString();
    }

    /**
     * 检查用户是否有导入权限
     */
    public boolean canImportData()
    {
        return isEvaluationAdmin() || isEvaluationTeacher();
    }

    /**
     * 检查用户是否有导出权限
     */
    public boolean canExportData()
    {
        return isEvaluationAdmin() || isEvaluationTeacher();
    }

    /**
     * 检查用户是否有统计查询权限
     */
    public boolean canViewStatistics()
    {
        return isEvaluationAdmin() || isEvaluationTeacher();
    }

    /**
     * 检查用户是否有配置管理权限
     */
    public boolean canManageConfig()
    {
        return isEvaluationAdmin();
    }
}