package com.ruoyi.system.domain.dto;

import java.util.List;

/**
 * 批量审核请求对象
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public class BatchAuditRequest {
    
    /** 填报ID列表 */
    private List<Long> submissionIds;
    
    /** 详情ID列表 */
    private List<Long> detailIds;
    
    /** 操作类型：APPROVE-通过，REJECT-驳回 */
    private String operation;
    
    /** 审核意见 */
    private String remark;

    public List<Long> getSubmissionIds() {
        return submissionIds;
    }

    public void setSubmissionIds(List<Long> submissionIds) {
        this.submissionIds = submissionIds;
    }

    public List<Long> getDetailIds() {
        return detailIds;
    }

    public void setDetailIds(List<Long> detailIds) {
        this.detailIds = detailIds;
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
        return "BatchAuditRequest{" +
                "submissionIds=" + submissionIds +
                ", detailIds=" + detailIds +
                ", operation='" + operation + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}