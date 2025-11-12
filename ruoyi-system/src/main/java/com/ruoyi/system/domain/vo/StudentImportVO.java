package com.ruoyi.system.domain.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excel.ColumnType;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 学生批量导入VO对象
 * 用于Excel批量导入学生花名册
 * 
 * @author ruoyi
 * @date 2025-11-12
 */
public class StudentImportVO
{
    private static final long serialVersionUID = 1L;

    /** 专业名称 */
    @Excel(name = "专业名称", prompt = "如：软件工程、计算机科学与技术")
    private String majorName;

    /** 班级 */
    @Excel(name = "班级", prompt = "如：2401、2402")
    private String className;

    /** 姓名（真实姓名，导入后用户可自行修改昵称） */
    @Excel(name = "姓名")
    private String name;

    /** 学号（或教职工号） */
    @Excel(name = "学号（或教职工号）", prompt = "学生填写学号如2507240101，教职工填写工号如T20240001")
    private String studentId;

    /** 手机号码 */
    @Excel(name = "手机号码", cellType = ColumnType.TEXT)
    private String phonenumber;

    /** 用户性别 */
    @Excel(name = "用户性别", readConverterExp = "男=0,女=1,未知=2")
    private String sex;

    /** 身份（学生、班委、辅导员） */
    @Excel(name = "身份（学生、班委、辅导员）", prompt = "填写：学生 或 班委 或 辅导员")
    private String identity;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 政治面貌 */
    @Excel(name = "政治面貌", prompt = "如：群众、团员、党员")
    private String politicalStatus;

    /** 入学日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "入学日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date enrollmentDate;

    public String getMajorName()
    {
        return majorName;
    }

    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getStudentId()
    {
        return studentId;
    }

    public void setStudentId(String studentId)
    {
        this.studentId = studentId;
    }

    public String getPhonenumber()
    {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber)
    {
        this.phonenumber = phonenumber;
    }

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    public String getIdentity()
    {
        return identity;
    }

    public void setIdentity(String identity)
    {
        this.identity = identity;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getPoliticalStatus()
    {
        return politicalStatus;
    }

    public void setPoliticalStatus(String politicalStatus)
    {
        this.politicalStatus = politicalStatus;
    }

    public Date getEnrollmentDate()
    {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Date enrollmentDate)
    {
        this.enrollmentDate = enrollmentDate;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("majorName", getMajorName())
            .append("className", getClassName())
            .append("name", getName())
            .append("studentId", getStudentId())
            .append("phonenumber", getPhonenumber())
            .append("sex", getSex())
            .append("identity", getIdentity())
            .append("email", getEmail())
            .append("politicalStatus", getPoliticalStatus())
            .append("enrollmentDate", getEnrollmentDate())
            .toString();
    }
}

