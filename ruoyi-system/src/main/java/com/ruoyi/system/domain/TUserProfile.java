package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生档案管理对象 t_user_profile
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public class TUserProfile extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 档案ID */
    private Long id;

    /** 关联sys_user表的用户ID */
    @Excel(name = "关联sys_user表的用户ID")
    private Long userId;

    /** 学号 */
    @Excel(name = "学号")
    private String studentId;

    /** 学院名称 */
    @Excel(name = "学院名称")
    private String college;

    /** 专业 */
    @Excel(name = "专业")
    private String major;

    /** 年级 */
    @Excel(name = "年级")
    private String grade;

    /** 班级名称 */
    @Excel(name = "班级名称")
    private String className;

    /** 性别：0-男，1-女，2-未知 */
    @Excel(name = "性别：0-男，1-女，2-未知")
    private Long gender;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthDate;

    /** 政治面貌 */
    @Excel(name = "政治面貌")
    private String politicalStatus;

    /** 入学日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "入学日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date enrollmentDate;

    /** 宿舍 */
    @Excel(name = "宿舍")
    private String dormitory;

    /** 家庭地址 */
    @Excel(name = "家庭地址")
    private String homeAddress;

    /** 紧急联系人 */
    @Excel(name = "紧急联系人")
    private String emergencyContact;

    /** 紧急联系电话 */
    @Excel(name = "紧急联系电话")
    private String emergencyPhone;

    /** 状态：0-禁用，1-启用 */
    @Excel(name = "状态：0-禁用，1-启用")
    private Long status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setStudentId(String studentId) 
    {
        this.studentId = studentId;
    }

    public String getStudentId() 
    {
        return studentId;
    }

    public void setCollege(String college) 
    {
        this.college = college;
    }

    public String getCollege() 
    {
        return college;
    }

    public void setMajor(String major) 
    {
        this.major = major;
    }

    public String getMajor() 
    {
        return major;
    }

    public void setGrade(String grade) 
    {
        this.grade = grade;
    }

    public String getGrade() 
    {
        return grade;
    }

    public void setClassName(String className) 
    {
        this.className = className;
    }

    public String getClassName() 
    {
        return className;
    }

    public void setGender(Long gender) 
    {
        this.gender = gender;
    }

    public Long getGender() 
    {
        return gender;
    }

    public void setBirthDate(Date birthDate) 
    {
        this.birthDate = birthDate;
    }

    public Date getBirthDate() 
    {
        return birthDate;
    }

    public void setPoliticalStatus(String politicalStatus) 
    {
        this.politicalStatus = politicalStatus;
    }

    public String getPoliticalStatus() 
    {
        return politicalStatus;
    }

    public void setEnrollmentDate(Date enrollmentDate) 
    {
        this.enrollmentDate = enrollmentDate;
    }

    public Date getEnrollmentDate() 
    {
        return enrollmentDate;
    }

    public void setDormitory(String dormitory) 
    {
        this.dormitory = dormitory;
    }

    public String getDormitory() 
    {
        return dormitory;
    }

    public void setHomeAddress(String homeAddress) 
    {
        this.homeAddress = homeAddress;
    }

    public String getHomeAddress() 
    {
        return homeAddress;
    }

    public void setEmergencyContact(String emergencyContact) 
    {
        this.emergencyContact = emergencyContact;
    }

    public String getEmergencyContact() 
    {
        return emergencyContact;
    }

    public void setEmergencyPhone(String emergencyPhone) 
    {
        this.emergencyPhone = emergencyPhone;
    }

    public String getEmergencyPhone() 
    {
        return emergencyPhone;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("studentId", getStudentId())
            .append("college", getCollege())
            .append("major", getMajor())
            .append("grade", getGrade())
            .append("className", getClassName())
            .append("gender", getGender())
            .append("birthDate", getBirthDate())
            .append("politicalStatus", getPoliticalStatus())
            .append("enrollmentDate", getEnrollmentDate())
            .append("dormitory", getDormitory())
            .append("homeAddress", getHomeAddress())
            .append("emergencyContact", getEmergencyContact())
            .append("emergencyPhone", getEmergencyPhone())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
