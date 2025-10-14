package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学院信息对象 t_college_info
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public class TCollegeInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学院ID */
    private Long id;

    /** 学院名称 */
    @Excel(name = "学院名称")
    private String collegeName;

    /** 学院代码 */
    @Excel(name = "学院代码")
    private String collegeCode;

    /** 负责人ID（关联sys_user） */
    @Excel(name = "负责人ID", readConverterExp = "关=联sys_user")
    private Long directorId;

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

    public void setCollegeName(String collegeName) 
    {
        this.collegeName = collegeName;
    }

    public String getCollegeName() 
    {
        return collegeName;
    }

    public void setCollegeCode(String collegeCode) 
    {
        this.collegeCode = collegeCode;
    }

    public String getCollegeCode() 
    {
        return collegeCode;
    }

    public void setDirectorId(Long directorId) 
    {
        this.directorId = directorId;
    }

    public Long getDirectorId() 
    {
        return directorId;
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
            .append("collegeName", getCollegeName())
            .append("collegeCode", getCollegeCode())
            .append("directorId", getDirectorId())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
