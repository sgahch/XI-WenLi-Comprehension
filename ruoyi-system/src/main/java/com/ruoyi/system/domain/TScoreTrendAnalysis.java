package com.ruoyi.system.domain;

import java.math.BigDecimal;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 成绩趋势分析对象 t_score_trend_analysis
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public class TScoreTrendAnalysis extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 学号 */
    @Excel(name = "学号")
    private String studentId;

    /** 姓名 */
    @Excel(name = "姓名")
    private String studentName;

    /** 分析类型（1智育趋势，2德育趋势，3体育趋势，4美育趋势，5劳育趋势，6综合趋势） */
    @Excel(name = "分析类型", readConverterExp = "1=智育趋势,2=德育趋势,3=体育趋势,4=美育趋势,5=劳育趋势,6=综合趋势")
    private Integer analysisType;

    /** 趋势数据，格式：{"semesters":["2023-2024-1","2023-2024-2"],"scores":[85.5,87.2],"ranks":[15,12]} */
    private String trendData;

    /** 平均成绩 */
    @Excel(name = "平均成绩")
    private BigDecimal avgScore;

    /** 最高成绩 */
    @Excel(name = "最高成绩")
    private BigDecimal maxScore;

    /** 最低成绩 */
    @Excel(name = "最低成绩")
    private BigDecimal minScore;

    /** 趋势方向（1上升，0平稳，-1下降） */
    @Excel(name = "趋势方向", readConverterExp = "1=上升,0=平稳,-1=下降")
    private Integer trendDirection;

    /** 提升幅度（百分比） */
    @Excel(name = "提升幅度")
    private BigDecimal improvementRate;

    /** 班级ID */
    @Excel(name = "班级ID")
    private String classId;

    /** 专业ID */
    @Excel(name = "专业ID")
    private String majorId;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setStudentId(String studentId) 
    {
        this.studentId = studentId;
    }

    public String getStudentId() 
    {
        return studentId;
    }
    public void setStudentName(String studentName) 
    {
        this.studentName = studentName;
    }

    public String getStudentName() 
    {
        return studentName;
    }
    public void setAnalysisType(Integer analysisType) 
    {
        this.analysisType = analysisType;
    }

    public Integer getAnalysisType() 
    {
        return analysisType;
    }
    public void setTrendData(String trendData) 
    {
        this.trendData = trendData;
    }

    public String getTrendData() 
    {
        return trendData;
    }
    public void setAvgScore(BigDecimal avgScore) 
    {
        this.avgScore = avgScore;
    }

    public BigDecimal getAvgScore() 
    {
        return avgScore;
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
    public void setTrendDirection(Integer trendDirection) 
    {
        this.trendDirection = trendDirection;
    }

    public Integer getTrendDirection() 
    {
        return trendDirection;
    }
    public void setImprovementRate(BigDecimal improvementRate) 
    {
        this.improvementRate = improvementRate;
    }

    public BigDecimal getImprovementRate() 
    {
        return improvementRate;
    }
    public void setClassId(String classId) 
    {
        this.classId = classId;
    }

    public String getClassId() 
    {
        return classId;
    }
    public void setMajorId(String majorId) 
    {
        this.majorId = majorId;
    }

    public String getMajorId() 
    {
        return majorId;
    }

    @Override
    public String toString() {
        return "TScoreTrendAnalysis{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", studentName='" + studentName + '\'' +
                ", analysisType=" + analysisType +
                ", trendData='" + trendData + '\'' +
                ", avgScore=" + avgScore +
                ", maxScore=" + maxScore +
                ", minScore=" + minScore +
                ", trendDirection=" + trendDirection +
                ", improvementRate=" + improvementRate +
                ", classId='" + classId + '\'' +
                ", majorId='" + majorId + '\'' +
                '}';
    }
}