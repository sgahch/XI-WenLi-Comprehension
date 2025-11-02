package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 综测填报对象 evaluation_submission
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
@Setter
@Getter
public class EvaluationSubmission extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 填报ID */
    private Long id;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 学生用户ID */
    @Excel(name = "学生用户ID")
    private Long userId;

    /** 学年 */
    @Excel(name = "学年")
    private String academicYear;

    /** 学期 */
    @Excel(name = "学期")
    private Integer semester;

    /** 班级ID */
    @Excel(name = "班级ID")
    private Long classId;

    /** 填报状态 */
    @Excel(name = "填报状态")
    private Integer status;

    /** 德育分数 */
    @Excel(name = "德育分数")
    private BigDecimal moralScore;

    /** 智育分数 */
    @Excel(name = "智育分数")
    private BigDecimal intellectualScore;

    /** 体育分数 */
    @Excel(name = "体育分数")
    private BigDecimal physicalScore;

    /** 美育分数 */
    @Excel(name = "美育分数")
    private BigDecimal aestheticScore;

    /** 劳育分数 */
    @Excel(name = "劳育分数")
    private BigDecimal laborScore;

    /** 总分 */
    @Excel(name = "总分")
    private BigDecimal totalScore;

    /** 自我评价 */
    @Excel(name = "自我评价")
    private String selfEvaluation;

    /** 提交时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "提交时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

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

    /** 填报详情列表 */
    private List<EvaluationSubmissionDetail> details;

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("academicYear", getAcademicYear())
            .append("semester", getSemester())
            .append("classId", getClassId())
            .append("status", getStatus())
            .append("moralScore", getMoralScore())
            .append("intellectualScore", getIntellectualScore())
            .append("physicalScore", getPhysicalScore())
            .append("aestheticScore", getAestheticScore())
            .append("laborScore", getLaborScore())
            .append("totalScore", getTotalScore())
            .append("selfEvaluation", getSelfEvaluation())
            .append("submitTime", getSubmitTime())
            .append("auditTime", getAuditTime())
            .append("auditBy", getAuditBy())
            .append("auditComment", getAuditComment())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}