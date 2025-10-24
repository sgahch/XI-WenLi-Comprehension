package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学期成绩明细对象 t_semester_score_detail
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public class TSemesterScoreDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 学号 */
    @Excel(name = "学号")
    private String studentId;

    /** 姓名 */
    @Excel(name = "姓名")
    private String studentName;

    /** 学年（如2023-2024） */
    @Excel(name = "学年")
    private String academicYear;

    /** 学期（1上学期，2下学期） */
    @Excel(name = "学期")
    private Integer semester;

    /** 智育成绩 */
    @Excel(name = "智育成绩")
    private BigDecimal intellectualScore;

    /** 智育排名 */
    @Excel(name = "智育排名")
    private Integer intellectualRank;

    /** 智育详细项目得分（JSON格式） */
    private String intellectualDetails;

    /** 德育成绩 */
    @Excel(name = "德育成绩")
    private BigDecimal moralScore;

    /** 德育排名 */
    @Excel(name = "德育排名")
    private Integer moralRank;

    /** 德育详细项目得分（JSON格式） */
    private String moralDetails;

    /** 体育成绩 */
    @Excel(name = "体育成绩")
    private BigDecimal physicalScore;

    /** 体育排名 */
    @Excel(name = "体育排名")
    private Integer physicalRank;

    /** 体育详细项目得分（JSON格式） */
    private String physicalDetails;

    /** 美育成绩 */
    @Excel(name = "美育成绩")
    private BigDecimal aestheticScore;

    /** 美育排名 */
    @Excel(name = "美育排名")
    private Integer aestheticRank;

    /** 美育详细项目得分（JSON格式） */
    private String aestheticDetails;

    /** 劳育成绩 */
    @Excel(name = "劳育成绩")
    private BigDecimal laborScore;

    /** 劳育排名 */
    @Excel(name = "劳育排名")
    private Integer laborRank;

    /** 劳育详细项目得分（JSON格式） */
    private String laborDetails;

    /** 综合成绩 */
    @Excel(name = "综合成绩")
    private BigDecimal totalScore;

    /** 班级排名 */
    @Excel(name = "班级排名")
    private Integer classRank;

    /** 专业排名 */
    @Excel(name = "专业排名")
    private Integer majorRank;

    /** 班级ID */
    @Excel(name = "班级ID")
    private String classId;

    /** 班级名称 */
    @Excel(name = "班级名称")
    private String className;

    /** 专业ID */
    @Excel(name = "专业ID")
    private String majorId;

    /** 专业名称 */
    @Excel(name = "专业名称")
    private String majorName;

    /** 状态（0草稿，1已提交，2已审核，3已发布） */
    @Excel(name = "状态", readConverterExp = "0=草稿,1=已提交,2=已审核,3=已发布")
    private Integer status;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "提交时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    /** 审核人ID */
    @Excel(name = "审核人ID")
    private String auditorId;

    /** 审核备注 */
    @Excel(name = "审核备注")
    private String auditRemark;






    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setStudentId(String studentId) 
    {
        this.studentId = studentId;
    }

    public String getStudentId() 
    {
        return studentId;
    }
    public void setStudentName(String studentName) 
    {
        this.studentName = studentName;
    }

    public String getStudentName() 
    {
        return studentName;
    }
    public void setAcademicYear(String academicYear) 
    {
        this.academicYear = academicYear;
    }

    public String getAcademicYear() 
    {
        return academicYear;
    }
    public void setSemester(Integer semester) 
    {
        this.semester = semester;
    }

    public Integer getSemester() 
    {
        return semester;
    }
    public void setIntellectualScore(BigDecimal intellectualScore) 
    {
        this.intellectualScore = intellectualScore;
    }

    public BigDecimal getIntellectualScore() 
    {
        return intellectualScore;
    }
    public void setIntellectualRank(Integer intellectualRank) 
    {
        this.intellectualRank = intellectualRank;
    }

    public Integer getIntellectualRank() 
    {
        return intellectualRank;
    }
    public void setIntellectualDetails(String intellectualDetails) 
    {
        this.intellectualDetails = intellectualDetails;
    }

    public String getIntellectualDetails() 
    {
        return intellectualDetails;
    }
    public void setMoralScore(BigDecimal moralScore) 
    {
        this.moralScore = moralScore;
    }

    public BigDecimal getMoralScore() 
    {
        return moralScore;
    }
    public void setMoralRank(Integer moralRank) 
    {
        this.moralRank = moralRank;
    }

    public Integer getMoralRank() 
    {
        return moralRank;
    }
    public void setMoralDetails(String moralDetails) 
    {
        this.moralDetails = moralDetails;
    }

    public String getMoralDetails() 
    {
        return moralDetails;
    }
    public void setPhysicalScore(BigDecimal physicalScore) 
    {
        this.physicalScore = physicalScore;
    }

    public BigDecimal getPhysicalScore() 
    {
        return physicalScore;
    }
    public void setPhysicalRank(Integer physicalRank) 
    {
        this.physicalRank = physicalRank;
    }

    public Integer getPhysicalRank() 
    {
        return physicalRank;
    }
    public void setPhysicalDetails(String physicalDetails) 
    {
        this.physicalDetails = physicalDetails;
    }

    public String getPhysicalDetails() 
    {
        return physicalDetails;
    }
    public void setAestheticScore(BigDecimal aestheticScore) 
    {
        this.aestheticScore = aestheticScore;
    }

    public BigDecimal getAestheticScore() 
    {
        return aestheticScore;
    }
    public void setAestheticRank(Integer aestheticRank) 
    {
        this.aestheticRank = aestheticRank;
    }

    public Integer getAestheticRank() 
    {
        return aestheticRank;
    }
    public void setAestheticDetails(String aestheticDetails) 
    {
        this.aestheticDetails = aestheticDetails;
    }

    public String getAestheticDetails() 
    {
        return aestheticDetails;
    }
    public void setLaborScore(BigDecimal laborScore) 
    {
        this.laborScore = laborScore;
    }

    public BigDecimal getLaborScore() 
    {
        return laborScore;
    }
    public void setLaborRank(Integer laborRank) 
    {
        this.laborRank = laborRank;
    }

    public Integer getLaborRank() 
    {
        return laborRank;
    }
    public void setLaborDetails(String laborDetails) 
    {
        this.laborDetails = laborDetails;
    }

    public String getLaborDetails() 
    {
        return laborDetails;
    }
    public void setTotalScore(BigDecimal totalScore) 
    {
        this.totalScore = totalScore;
    }

    public BigDecimal getTotalScore() 
    {
        return totalScore;
    }
    public void setClassRank(Integer classRank) 
    {
        this.classRank = classRank;
    }

    public Integer getClassRank() 
    {
        return classRank;
    }
    public void setMajorRank(Integer majorRank) 
    {
        this.majorRank = majorRank;
    }

    public Integer getMajorRank() 
    {
        return majorRank;
    }
    public void setClassId(String classId) 
    {
        this.classId = classId;
    }

    public String getClassId() 
    {
        return classId;
    }
    public void setClassName(String className) 
    {
        this.className = className;
    }

    public String getClassName() 
    {
        return className;
    }
    public void setMajorId(String majorId) 
    {
        this.majorId = majorId;
    }

    public String getMajorId() 
    {
        return majorId;
    }
    public void setMajorName(String majorName) 
    {
        this.majorName = majorName;
    }

    public String getMajorName() 
    {
        return majorName;
    }
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }
    public void setSubmitTime(Date submitTime) 
    {
        this.submitTime = submitTime;
    }

    public Date getSubmitTime() 
    {
        return submitTime;
    }
    public void setAuditTime(Date auditTime) 
    {
        this.auditTime = auditTime;
    }

    public Date getAuditTime() 
    {
        return auditTime;
    }
    public void setAuditorId(String auditorId) 
    {
        this.auditorId = auditorId;
    }

    public String getAuditorId() 
    {
        return auditorId;
    }
    public void setAuditRemark(String auditRemark) 
    {
        this.auditRemark = auditRemark;
    }

    public String getAuditRemark() 
    {
        return auditRemark;
    }

    @Override
    public String toString() {
        return "TSemesterScoreDetail{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", studentName='" + studentName + '\'' +
                ", academicYear='" + academicYear + '\'' +
                ", semester=" + semester +
                ", intellectualScore=" + intellectualScore +
                ", intellectualRank=" + intellectualRank +
                ", intellectualDetails='" + intellectualDetails + '\'' +
                ", moralScore=" + moralScore +
                ", moralRank=" + moralRank +
                ", moralDetails='" + moralDetails + '\'' +
                ", physicalScore=" + physicalScore +
                ", physicalRank=" + physicalRank +
                ", physicalDetails='" + physicalDetails + '\'' +
                ", aestheticScore=" + aestheticScore +
                ", aestheticRank=" + aestheticRank +
                ", aestheticDetails='" + aestheticDetails + '\'' +
                ", laborScore=" + laborScore +
                ", laborRank=" + laborRank +
                ", laborDetails='" + laborDetails + '\'' +
                ", totalScore=" + totalScore +
                ", classRank=" + classRank +
                ", majorRank=" + majorRank +
                ", classId='" + classId + '\'' +
                ", className='" + className + '\'' +
                ", majorId='" + majorId + '\'' +
                ", majorName='" + majorName + '\'' +
                ", status=" + status +
                ", submitTime=" + submitTime +
                ", auditTime=" + auditTime +
                ", auditorId='" + auditorId + '\'' +
                ", auditRemark='" + auditRemark + '\'' +
                '}';
    }
}