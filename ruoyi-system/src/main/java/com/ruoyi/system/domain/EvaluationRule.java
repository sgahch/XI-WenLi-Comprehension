package com.ruoyi.system.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 计分规则对象 evaluation_rule
 * 
 * @author ruoyi
 * @date 2025-11-09
 */
public class EvaluationRule extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 规则ID */
    private Long id;

    /** 维度：moral(德), intellectual(智), physical(体), aesthetic(美), labor(劳) */
    @Excel(name = "维度：moral(德), intellectual(智), physical(体), aesthetic(美), labor(劳)")
    private String dimension;

    /** 学院ID，关联sys_dept.dept_id，用于区分不同学院的评分标准。NULL表示通用规则，适用于所有学院 */
    @Excel(name = "学院ID，关联sys_dept.dept_id，用于区分不同学院的评分标准。NULL表示通用规则，适用于所有学院")
    private Long collegeId;

    /** 大类：如学科竞赛、社会实践、文体活动等 */
    @Excel(name = "大类：如学科竞赛、社会实践、文体活动等")
    private String category;

    /** 项目名称：如全国大学生数学建模竞赛 */
    @Excel(name = "项目名称：如全国大学生数学建模竞赛")
    private String itemName;

    /** 等级：如国家级一等奖、省级三等奖等 */
    @Excel(name = "等级：如国家级一等奖、省级三等奖等")
    private String level;

    /** 课程代码 */
    @Excel(name = "课程代码")
    private String courseCode;

    /** 学分 */
    @Excel(name = "学分")
    private BigDecimal credit;

    /** 绩点 */
    @Excel(name = "绩点")
    private BigDecimal gradePoint;

    /** 分数 */
    @Excel(name = "分数")
    private BigDecimal score;

    /** 是否必须上传附件：0-否，1-是 */
    @Excel(name = "是否必须上传附件：0-否，1-是")
    private Long requireAttachment;

    /** 允许的附件类型 */
    @Excel(name = "允许的附件类型")
    private String attachmentTypes;

    /** 规则描述 */
    @Excel(name = "规则描述")
    private String description;

    /** 状态：0-禁用，1-启用 */
    @Excel(name = "状态：0-禁用，1-启用")
    private Long isEnabled;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setDimension(String dimension) 
    {
        this.dimension = dimension;
    }

    public String getDimension() 
    {
        return dimension;
    }

    public void setCollegeId(Long collegeId) 
    {
        this.collegeId = collegeId;
    }

    public Long getCollegeId() 
    {
        return collegeId;
    }

    public void setCategory(String category) 
    {
        this.category = category;
    }

    public String getCategory() 
    {
        return category;
    }

    public void setItemName(String itemName) 
    {
        this.itemName = itemName;
    }

    public String getItemName() 
    {
        return itemName;
    }

    public void setLevel(String level) 
    {
        this.level = level;
    }

    public String getLevel() 
    {
        return level;
    }

    public void setCourseCode(String courseCode) 
    {
        this.courseCode = courseCode;
    }

    public String getCourseCode() 
    {
        return courseCode;
    }

    public void setCredit(BigDecimal credit) 
    {
        this.credit = credit;
    }

    public BigDecimal getCredit() 
    {
        return credit;
    }

    public void setGradePoint(BigDecimal gradePoint) 
    {
        this.gradePoint = gradePoint;
    }

    public BigDecimal getGradePoint() 
    {
        return gradePoint;
    }

    public void setScore(BigDecimal score) 
    {
        this.score = score;
    }

    public BigDecimal getScore() 
    {
        return score;
    }

    public void setRequireAttachment(Long requireAttachment) 
    {
        this.requireAttachment = requireAttachment;
    }

    public Long getRequireAttachment() 
    {
        return requireAttachment;
    }

    public void setAttachmentTypes(String attachmentTypes) 
    {
        this.attachmentTypes = attachmentTypes;
    }

    public String getAttachmentTypes() 
    {
        return attachmentTypes;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setIsEnabled(Long isEnabled) 
    {
        this.isEnabled = isEnabled;
    }

    public Long getIsEnabled() 
    {
        return isEnabled;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("dimension", getDimension())
            .append("collegeId", getCollegeId())
            .append("category", getCategory())
            .append("itemName", getItemName())
            .append("level", getLevel())
            .append("courseCode", getCourseCode())
            .append("credit", getCredit())
            .append("gradePoint", getGradePoint())
            .append("score", getScore())
            .append("requireAttachment", getRequireAttachment())
            .append("attachmentTypes", getAttachmentTypes())
            .append("description", getDescription())
            .append("isEnabled", getIsEnabled())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
