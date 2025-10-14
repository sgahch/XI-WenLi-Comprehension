package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生成绩明细对象 t_student_score_detail
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
public class TStudentScoreDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 成绩明细ID */
    private Long id;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 测评体系ID */
    @Excel(name = "测评体系ID")
    private Long systemId;

    /** 测评项目ID */
    @Excel(name = "测评项目ID")
    private Long itemId;

    /** 得分 */
    @Excel(name = "得分")
    private BigDecimal score;

    /** 证明材料URL */
    @Excel(name = "证明材料URL")
    private String evidenceUrl;

    /** 申请说明 */
    @Excel(name = "申请说明")
    private String description;

    /** 状态：0-待提交，1-待审核，2-已通过，3-已驳回 */
    @Excel(name = "状态：0-待提交，1-待审核，2-已通过，3-已驳回")
    private Long status;

    /** 审核意见 */
    @Excel(name = "审核意见")
    private String auditComment;

    /** 审核人ID */
    @Excel(name = "审核人ID")
    private Long auditorId;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "提交时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date submitTime;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date auditTime;

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

    public void setItemId(Long itemId) 
    {
        this.itemId = itemId;
    }

    public Long getItemId() 
    {
        return itemId;
    }

    public void setScore(BigDecimal score) 
    {
        this.score = score;
    }

    public BigDecimal getScore() 
    {
        return score;
    }

    public void setEvidenceUrl(String evidenceUrl) 
    {
        this.evidenceUrl = evidenceUrl;
    }

    public String getEvidenceUrl() 
    {
        return evidenceUrl;
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

    public void setAuditComment(String auditComment) 
    {
        this.auditComment = auditComment;
    }

    public String getAuditComment() 
    {
        return auditComment;
    }

    public void setAuditorId(Long auditorId) 
    {
        this.auditorId = auditorId;
    }

    public Long getAuditorId() 
    {
        return auditorId;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("studentId", getStudentId())
            .append("systemId", getSystemId())
            .append("itemId", getItemId())
            .append("score", getScore())
            .append("evidenceUrl", getEvidenceUrl())
            .append("description", getDescription())
            .append("status", getStatus())
            .append("auditComment", getAuditComment())
            .append("auditorId", getAuditorId())
            .append("submitTime", getSubmitTime())
            .append("auditTime", getAuditTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
