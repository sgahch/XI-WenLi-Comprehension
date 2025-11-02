package com.ruoyi.system.domain.dto;

/**
 * 审核请求对象
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public class AuditRequest {
    
    /** 填报ID */
    private Long submissionId;
    
    /** 详情ID */
    private Long detailId;
    
    /** 操作类型：APPROVE-通过，REJECT-驳回 */
    private String operation;
    
    /** 审核意见 */
    private String remark;

    public Long getSubmissionId() {
        return submissionId;
    }

    public void setSubmissionId(Long submissionId) {
        this.submissionId = submissionId;
    }

    public Long getDetailId() {
        return detailId;
    }

    public void setDetailId(Long detailId) {
        this.detailId = detailId;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "AuditRequest{" +
                "submissionId=" + submissionId +
                ", detailId=" + detailId +
                ", operation='" + operation + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}