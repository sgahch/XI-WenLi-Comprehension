package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 考评加分记录对象 t_score_record
 * 
 * @author ruoyi
 * @date 2025-09-28
 */
public class TScoreRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long id;

    /** 用户ID（关联sys_user） */
    @Excel(name = "用户ID", readConverterExp = "关=联sys_user")
    private Long userId;

    /** 关联规则ID */
    @Excel(name = "关联规则ID")
    private Long ruleId;

    /** 材料存储路径 */
    @Excel(name = "材料存储路径")
    private String materialPath;

    /** 材料类型：PDF/JPG/PNG */
    @Excel(name = "材料类型：PDF/JPG/PNG")
    private String materialType;

    /** 加分事由 */
    @Excel(name = "加分事由")
    private String reason;

    /** 状态：0-待班委审核，1-待辅导员审核，2-已通过，3-已拒绝 */
    @Excel(name = "状态：0-待班委审核，1-待辅导员审核，2-已通过，3-已拒绝")
    private Long status;

    /** 最终加分值 */
    @Excel(name = "最终加分值")
    private BigDecimal score;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "提交时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date submitTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setRuleId(Long ruleId) 
    {
        this.ruleId = ruleId;
    }

    public Long getRuleId() 
    {
        return ruleId;
    }

    public void setMaterialPath(String materialPath) 
    {
        this.materialPath = materialPath;
    }

    public String getMaterialPath() 
    {
        return materialPath;
    }

    public void setMaterialType(String materialType) 
    {
        this.materialType = materialType;
    }

    public String getMaterialType() 
    {
        return materialType;
    }

    public void setReason(String reason) 
    {
        this.reason = reason;
    }

    public String getReason() 
    {
        return reason;
    }

    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    public void setScore(BigDecimal score) 
    {
        this.score = score;
    }

    public BigDecimal getScore() 
    {
        return score;
    }

    public void setSubmitTime(Date submitTime) 
    {
        this.submitTime = submitTime;
    }

    public Date getSubmitTime() 
    {
        return submitTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("ruleId", getRuleId())
            .append("materialPath", getMaterialPath())
            .append("materialType", getMaterialType())
            .append("reason", getReason())
            .append("status", getStatus())
            .append("score", getScore())
            .append("submitTime", getSubmitTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
