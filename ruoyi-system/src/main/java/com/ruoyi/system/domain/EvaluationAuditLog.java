package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 审核日志对象 evaluation_audit_log
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public class EvaluationAuditLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 日志ID */
    private Long id;

    /** 填报ID，关联evaluation_submission.id */
    @Excel(name = "填报ID")
    private Long submissionId;

    /** 详情ID，关联evaluation_submission_detail.id */
    @Excel(name = "详情ID")
    private Long detailId;

    /** 审核人ID，关联sys_user.user_id */
    @Excel(name = "审核人ID")
    private Long auditorId;

    /** 审核人姓名（关联查询字段） */
    @Excel(name = "审核人姓名")
    private String auditorName;

    /** 操作类型：APPROVE-通过，REJECT-驳回，SUBMIT-提交 */
    @Excel(name = "操作类型")
    private String operation;

    /** 原状态 */
    @Excel(name = "原状态")
    private Integer oldStatus;

    /** 新状态 */
    @Excel(name = "新状态")
    private Integer newStatus;

    /** 审核意见/操作说明 */
    @Excel(name = "审核意见")
    private String remark;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    /** IP地址 */
    @Excel(name = "IP地址")
    private String ipAddress;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setSubmissionId(Long submissionId) 
    {
        this.submissionId = submissionId;
    }

    public Long getSubmissionId() 
    {
        return submissionId;
    }
    public void setDetailId(Long detailId) 
    {
        this.detailId = detailId;
    }

    public Long getDetailId() 
    {
        return detailId;
    }
    public void setAuditorId(Long auditorId) 
    {
        this.auditorId = auditorId;
    }

    public Long getAuditorId()
    {
        return auditorId;
    }
    public void setAuditorName(String auditorName)
    {
        this.auditorName = auditorName;
    }

    public String getAuditorName()
    {
        return auditorName;
    }
    public void setOperation(String operation)
    {
        this.operation = operation;
    }

    public String getOperation() 
    {
        return operation;
    }
    public void setOldStatus(Integer oldStatus) 
    {
        this.oldStatus = oldStatus;
    }

    public Integer getOldStatus() 
    {
        return oldStatus;
    }
    public void setNewStatus(Integer newStatus) 
    {
        this.newStatus = newStatus;
    }

    public Integer getNewStatus() 
    {
        return newStatus;
    }
    public void setRemark(String remark) 
    {
        this.remark = remark;
    }

    public String getRemark() 
    {
        return remark;
    }
    public void setAuditTime(Date auditTime) 
    {
        this.auditTime = auditTime;
    }

    public Date getAuditTime() 
    {
        return auditTime;
    }
    public void setIpAddress(String ipAddress) 
    {
        this.ipAddress = ipAddress;
    }

    public String getIpAddress() 
    {
        return ipAddress;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("submissionId", getSubmissionId())
            .append("detailId", getDetailId())
            .append("auditorId", getAuditorId())
            .append("operation", getOperation())
            .append("oldStatus", getOldStatus())
            .append("newStatus", getNewStatus())
            .append("remark", getRemark())
            .append("auditTime", getAuditTime())
            .append("ipAddress", getIpAddress())
            .toString();
    }
}