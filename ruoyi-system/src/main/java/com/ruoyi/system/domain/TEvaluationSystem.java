package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 测评体系对象 t_evaluation_system
 * 
 * @author ynchen
 * @date 2025-10-01
 */
public class TEvaluationSystem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 测评体系ID */
    private Long id;

    /** 测评体系名称 */
    @Excel(name = "测评体系名称")
    private String systemName;

    /** 学年，如2023-2024 */
    @Excel(name = "学年，如2023-2024")
    private String academicYear;

    /** 学期：1-第一学期，2-第二学期 */
    @Excel(name = "学期：1-第一学期，2-第二学期")
    private Long semester;

    /** 测评体系描述 */
    @Excel(name = "测评体系描述")
    private String description;

    /** 状态：0-未启用，1-已启用，2-已结束 */
    @Excel(name = "状态：0-未启用，1-已启用，2-已结束")
    private Long status;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 创建者ID */
    @Excel(name = "创建者ID")
    private Long creatorId;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setSystemName(String systemName) 
    {
        this.systemName = systemName;
    }

    public String getSystemName() 
    {
        return systemName;
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

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setStartTime(Date startTime) 
    {
        this.startTime = startTime;
    }

    public Date getStartTime() 
    {
        return startTime;
    }

    public void setEndTime(Date endTime) 
    {
        this.endTime = endTime;
    }

    public Date getEndTime() 
    {
        return endTime;
    }

    public void setCreatorId(Long creatorId) 
    {
        this.creatorId = creatorId;
    }

    public Long getCreatorId() 
    {
        return creatorId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("systemName", getSystemName())
            .append("academicYear", getAcademicYear())
            .append("semester", getSemester())
            .append("description", getDescription())
            .append("status", getStatus())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("creatorId", getCreatorId())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
