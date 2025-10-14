package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 申诉对象 t_appeal
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
public class TAppeal extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 申诉ID */
    private Long id;

    /** 关联加分记录ID */
    @Excel(name = "关联加分记录ID")
    private Long recordId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 申诉理由 */
    @Excel(name = "申诉理由")
    private String appealReason;

    /** 状态：0-待处理，1-已同意，2-已拒绝 */
    @Excel(name = "状态：0-待处理，1-已同意，2-已拒绝")
    private Long status;

    /** 处理结果 */
    @Excel(name = "处理结果")
    private String processResult;

    /** 处理人ID */
    @Excel(name = "处理人ID")
    private Long processBy;

    /** 处理时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "处理时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date processTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setRecordId(Long recordId) 
    {
        this.recordId = recordId;
    }

    public Long getRecordId() 
    {
        return recordId;
    }

    public void setStudentId(Long studentId) 
    {
        this.studentId = studentId;
    }

    public Long getStudentId() 
    {
        return studentId;
    }

    public void setAppealReason(String appealReason) 
    {
        this.appealReason = appealReason;
    }

    public String getAppealReason() 
    {
        return appealReason;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setProcessResult(String processResult) 
    {
        this.processResult = processResult;
    }

    public String getProcessResult() 
    {
        return processResult;
    }

    public void setProcessBy(Long processBy) 
    {
        this.processBy = processBy;
    }

    public Long getProcessBy() 
    {
        return processBy;
    }

    public void setProcessTime(Date processTime) 
    {
        this.processTime = processTime;
    }

    public Date getProcessTime() 
    {
        return processTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("recordId", getRecordId())
            .append("studentId", getStudentId())
            .append("appealReason", getAppealReason())
            .append("status", getStatus())
            .append("processResult", getProcessResult())
            .append("processBy", getProcessBy())
            .append("createTime", getCreateTime())
            .append("processTime", getProcessTime())
            .toString();
    }
}
