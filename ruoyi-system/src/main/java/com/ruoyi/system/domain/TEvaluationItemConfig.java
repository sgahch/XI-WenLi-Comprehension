package com.ruoyi.system.domain;

import java.math.BigDecimal;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 综测评分项目配置对象 t_evaluation_item_config
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public class TEvaluationItemConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 维度类型（1智育，2德育，3体育，4美育，5劳育） */
    @Excel(name = "维度类型", readConverterExp = "1=智育,2=德育,3=体育,4=美育,5=劳育")
    private Integer dimensionType;

    /** 项目编码 */
    @Excel(name = "项目编码")
    private String itemCode;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String itemName;

    /** 项目描述 */
    @Excel(name = "项目描述")
    private String itemDescription;

    /** 最高分值 */
    @Excel(name = "最高分值")
    private BigDecimal maxScore;

    /** 最低分值 */
    @Excel(name = "最低分值")
    private BigDecimal minScore;

    /** 默认分值 */
    @Excel(name = "默认分值")
    private BigDecimal defaultScore;

    /** 评分类型（1数值型，2等级型，3布尔型） */
    @Excel(name = "评分类型", readConverterExp = "1=数值型,2=等级型,3=布尔型")
    private Integer scoreType;

    /** 评分选项（等级型时使用） */
    private String scoreOptions;

    /** 权重系数 */
    @Excel(name = "权重系数")
    private BigDecimal weight;

    /** 排序序号 */
    @Excel(name = "排序序号")
    private Integer sortOrder;

    /** 是否必填（0否，1是） */
    @Excel(name = "是否必填", readConverterExp = "0=否,1=是")
    private Integer isRequired;

    /** 是否启用（0否，1是） */
    @Excel(name = "是否启用", readConverterExp = "0=否,1=是")
    private Integer isActive;

    /** 适用年级（JSON数组） */
    @Excel(name = "适用年级")
    private String applicableGrades;

    /** 适用专业（JSON数组） */
    @Excel(name = "适用专业")
    private String applicableMajors;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setDimensionType(Integer dimensionType) 
    {
        this.dimensionType = dimensionType;
    }

    public Integer getDimensionType() 
    {
        return dimensionType;
    }
    public void setItemCode(String itemCode) 
    {
        this.itemCode = itemCode;
    }

    public String getItemCode() 
    {
        return itemCode;
    }
    public void setItemName(String itemName) 
    {
        this.itemName = itemName;
    }

    public String getItemName() 
    {
        return itemName;
    }
    public void setItemDescription(String itemDescription) 
    {
        this.itemDescription = itemDescription;
    }

    public String getItemDescription() 
    {
        return itemDescription;
    }
    public void setMaxScore(BigDecimal maxScore) 
    {
        this.maxScore = maxScore;
    }

    public BigDecimal getMaxScore() 
    {
        return maxScore;
    }
    public void setMinScore(BigDecimal minScore) 
    {
        this.minScore = minScore;
    }

    public BigDecimal getMinScore() 
    {
        return minScore;
    }
    public void setDefaultScore(BigDecimal defaultScore) 
    {
        this.defaultScore = defaultScore;
    }

    public BigDecimal getDefaultScore() 
    {
        return defaultScore;
    }
    public void setScoreType(Integer scoreType) 
    {
        this.scoreType = scoreType;
    }

    public Integer getScoreType() 
    {
        return scoreType;
    }
    public void setScoreOptions(String scoreOptions) 
    {
        this.scoreOptions = scoreOptions;
    }

    public String getScoreOptions() 
    {
        return scoreOptions;
    }
    public void setWeight(BigDecimal weight) 
    {
        this.weight = weight;
    }

    public BigDecimal getWeight() 
    {
        return weight;
    }
    public void setSortOrder(Integer sortOrder) 
    {
        this.sortOrder = sortOrder;
    }

    public Integer getSortOrder() 
    {
        return sortOrder;
    }
    public void setIsRequired(Integer isRequired) 
    {
        this.isRequired = isRequired;
    }

    public Integer getIsRequired() 
    {
        return isRequired;
    }
    public void setIsActive(Integer isActive) 
    {
        this.isActive = isActive;
    }

    public Integer getIsActive() 
    {
        return isActive;
    }
    public void setApplicableGrades(String applicableGrades) 
    {
        this.applicableGrades = applicableGrades;
    }

    public String getApplicableGrades() 
    {
        return applicableGrades;
    }
    public void setApplicableMajors(String applicableMajors) 
    {
        this.applicableMajors = applicableMajors;
    }

    public String getApplicableMajors() 
    {
        return applicableMajors;
    }

    @Override
    public String toString() {
        return "TEvaluationItemConfig{" +
                "id=" + id +
                ", dimensionType=" + dimensionType +
                ", itemCode='" + itemCode + '\'' +
                ", itemName='" + itemName + '\'' +
                ", itemDescription='" + itemDescription + '\'' +
                ", maxScore=" + maxScore +
                ", minScore=" + minScore +
                ", defaultScore=" + defaultScore +
                ", scoreType=" + scoreType +
                ", scoreOptions='" + scoreOptions + '\'' +
                ", weight=" + weight +
                ", sortOrder=" + sortOrder +
                ", isRequired=" + isRequired +
                ", isActive=" + isActive +
                ", applicableGrades='" + applicableGrades + '\'' +
                ", applicableMajors='" + applicableMajors + '\'' +
                '}';
    }
}