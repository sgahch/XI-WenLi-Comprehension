package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生总成绩对象 t_student_total_score
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
public class TStudentTotalScore extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 总成绩ID */
    private Long id;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 测评体系ID */
    @Excel(name = "测评体系ID")
    private Long systemId;

    /** 总分 */
    @Excel(name = "总分")
    private BigDecimal totalScore;

    /** 思想品德分 */
    @Excel(name = "思想品德分")
    private BigDecimal moralScore;

    /** 学习成绩分 */
    @Excel(name = "学习成绩分")
    private BigDecimal studyScore;

    /** 社会实践分 */
    @Excel(name = "社会实践分")
    private BigDecimal practiceScore;

    /** 创新创业分 */
    @Excel(name = "创新创业分")
    private BigDecimal innovationScore;

    /** 其他加分 */
    @Excel(name = "其他加分")
    private BigDecimal otherScore;

    /** 排名 */
    @Excel(name = "排名")
    private Long ranking;

    /** 学年 */
    @Excel(name = "学年")
    private String academicYear;

    /** 学期 */
    @Excel(name = "学期")
    private Long semester;

    /** 状态：0-计算中，1-已完成，2-已公示 */
    @Excel(name = "状态：0-计算中，1-已完成，2-已公示")
    private Long status;

    /** 计算时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "计算时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date calculateTime;

    /** 发布时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发布时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publishTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setStudentId(Long studentId) 
    {
        this.studentId = studentId;
    }

    public Long getStudentId() 
    {
        return studentId;
    }

    public void setSystemId(Long systemId) 
    {
        this.systemId = systemId;
    }

    public Long getSystemId() 
    {
        return systemId;
    }

    public void setTotalScore(BigDecimal totalScore) 
    {
        this.totalScore = totalScore;
    }

    public BigDecimal getTotalScore() 
    {
        return totalScore;
    }

    public void setMoralScore(BigDecimal moralScore) 
    {
        this.moralScore = moralScore;
    }

    public BigDecimal getMoralScore() 
    {
        return moralScore;
    }

    public void setStudyScore(BigDecimal studyScore) 
    {
        this.studyScore = studyScore;
    }

    public BigDecimal getStudyScore() 
    {
        return studyScore;
    }

    public void setPracticeScore(BigDecimal practiceScore) 
    {
        this.practiceScore = practiceScore;
    }

    public BigDecimal getPracticeScore() 
    {
        return practiceScore;
    }

    public void setInnovationScore(BigDecimal innovationScore) 
    {
        this.innovationScore = innovationScore;
    }

    public BigDecimal getInnovationScore() 
    {
        return innovationScore;
    }

    public void setOtherScore(BigDecimal otherScore) 
    {
        this.otherScore = otherScore;
    }

    public BigDecimal getOtherScore() 
    {
        return otherScore;
    }

    public void setRanking(Long ranking) 
    {
        this.ranking = ranking;
    }

    public Long getRanking() 
    {
        return ranking;
    }

    public void setAcademicYear(String academicYear) 
    {
        this.academicYear = academicYear;
    }

    public String getAcademicYear() 
    {
        return academicYear;
    }

    public void setSemester(Long semester) 
    {
        this.semester = semester;
    }

    public Long getSemester() 
    {
        return semester;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setCalculateTime(Date calculateTime) 
    {
        this.calculateTime = calculateTime;
    }

    public Date getCalculateTime() 
    {
        return calculateTime;
    }

    public void setPublishTime(Date publishTime) 
    {
        this.publishTime = publishTime;
    }

    public Date getPublishTime() 
    {
        return publishTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("studentId", getStudentId())
            .append("systemId", getSystemId())
            .append("totalScore", getTotalScore())
            .append("moralScore", getMoralScore())
            .append("studyScore", getStudyScore())
            .append("practiceScore", getPracticeScore())
            .append("innovationScore", getInnovationScore())
            .append("otherScore", getOtherScore())
            .append("ranking", getRanking())
            .append("academicYear", getAcademicYear())
            .append("semester", getSemester())
            .append("status", getStatus())
            .append("calculateTime", getCalculateTime())
            .append("publishTime", getPublishTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
