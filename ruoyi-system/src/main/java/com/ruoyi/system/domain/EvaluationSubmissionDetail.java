package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.alibaba.fastjson2.JSONObject;

/**
 * 综测填报详情对象 evaluation_submission_detail
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public class EvaluationSubmissionDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 详情ID */
    private Long id;

    /** 填报ID */
    @Excel(name = "填报ID")
    private Long submissionId;

    /** 规则ID */
    @Excel(name = "规则ID")
    private Long ruleId;

    /** 规则快照（JSON字符串，存储到数据库） */
    @Excel(name = "规则快照")
    private String ruleSnapshot;

    /** 规则快照对象（用于前端，不存储到数据库，仅在查询时使用） */
    private transient JSONObject ruleSnapshotObj;

    /** 申请分数 */
    @Excel(name = "申请分数")
    private BigDecimal applyScore;

    /** 最终分数 */
    @Excel(name = "最终分数")
    private BigDecimal finalScore;

    /** 状态 */
    @Excel(name = "状态")
    private Integer status;

    /** 备注 */
    @Excel(name = "备注")
    private String remark;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    /** 审核人ID */
    @Excel(name = "审核人ID")
    private Long auditBy;

    /** 审核意见 */
    @Excel(name = "审核意见")
    private String auditComment;

    /** 附件列表 */
    private List<EvaluationAttachment> attachments;

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
    public void setRuleId(Long ruleId) 
    {
        this.ruleId = ruleId;
    }

    public Long getRuleId() 
    {
        return ruleId;
    }
    public void setRuleSnapshot(String ruleSnapshot) 
    {
        this.ruleSnapshot = ruleSnapshot;
    }

    public String getRuleSnapshot()
    {
        return ruleSnapshot;
    }
    public void setRuleSnapshotObj(JSONObject ruleSnapshotObj)
    {
        this.ruleSnapshotObj = ruleSnapshotObj;
    }

    public JSONObject getRuleSnapshotObj()
    {
        return ruleSnapshotObj;
    }
    public void setApplyScore(BigDecimal applyScore)
    {
        this.applyScore = applyScore;
    }

    public BigDecimal getApplyScore() 
    {
        return applyScore;
    }
    public void setFinalScore(BigDecimal finalScore) 
    {
        this.finalScore = finalScore;
    }

    public BigDecimal getFinalScore() 
    {
        return finalScore;
    }
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
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
    public void setAuditBy(Long auditBy) 
    {
        this.auditBy = auditBy;
    }

    public Long getAuditBy() 
    {
        return auditBy;
    }
    public void setAuditComment(String auditComment) 
    {
        this.auditComment = auditComment;
    }

    public String getAuditComment() 
    {
        return auditComment;
    }

    public List<EvaluationAttachment> getAttachments() 
    {
        return attachments;
    }

    public void setAttachments(List<EvaluationAttachment> attachments) 
    {
        this.attachments = attachments;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("submissionId", getSubmissionId())
            .append("ruleId", getRuleId())
            .append("ruleSnapshot", getRuleSnapshot())
            .append("applyScore", getApplyScore())
            .append("finalScore", getFinalScore())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("auditTime", getAuditTime())
            .append("auditBy", getAuditBy())
            .append("auditComment", getAuditComment())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}