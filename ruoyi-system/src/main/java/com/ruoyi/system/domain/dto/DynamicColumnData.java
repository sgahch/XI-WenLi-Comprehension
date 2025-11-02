package com.ruoyi.system.domain.dto;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 动态列数据DTO
 * 用于存储每个学生的动态列数据
 * 
 * @author ruoyi
 * @date 2025-11-02
 */
public class DynamicColumnData {
    
    /** 学生ID */
    private Long studentId;
    
    /** 学生姓名 */
    private String studentName;
    
    /** 学号 */
    private String studentCode;
    
    /** 班级名称 */
    private String className;
    
    // ==================== F1 德育素质测评 ====================
    
    /** F1基础分 */
    private BigDecimal f1BaseScore = BigDecimal.ZERO;
    
    /** F1加分项(动态) - key: 加分项名称, value: 分数 */
    private Map<String, BigDecimal> f1BonusItems = new LinkedHashMap<>();
    
    /** F1扣分项(动态) - key: 扣分项名称, value: 分数(负数) */
    private Map<String, BigDecimal> f1DeductionItems = new LinkedHashMap<>();
    
    /** F1总分 */
    private BigDecimal f1TotalScore = BigDecimal.ZERO;
    
    // ==================== F2a 智育素质测评基础分 ====================
    
    /** F2a课程成绩(动态) - key: 课程名称, value: 成绩 */
    private Map<String, BigDecimal> f2aCourseScores = new LinkedHashMap<>();
    
    /** F2a智育成绩(加权平均或其他算法) */
    private BigDecimal f2aAverageScore = BigDecimal.ZERO;
    
    /** F2a总分 */
    private BigDecimal f2aTotalScore = BigDecimal.ZERO;
    
    /** F2a班级排名 */
    private Integer f2aClassRank;
    
    // ==================== F2b 智育素质测评奖励分 ====================
    
    /** F2b竞赛项目(动态) - key: 竞赛名称, value: 分数 */
    private Map<String, BigDecimal> f2bCompetitionScores = new LinkedHashMap<>();
    
    /** F2b总分 */
    private BigDecimal f2bTotalScore = BigDecimal.ZERO;
    
    // ==================== F3 素质发展测评 ====================
    
    /** 体育成绩 */
    private BigDecimal physicalScore = BigDecimal.ZERO;
    
    /** 体测成绩 */
    private BigDecimal physicalTestScore = BigDecimal.ZERO;
    
    /** 体育正向加分 */
    private BigDecimal physicalBonusScore = BigDecimal.ZERO;
    
    /** 体育反向减分 */
    private BigDecimal physicalDeductionScore = BigDecimal.ZERO;
    
    /** 体育总分 */
    private BigDecimal physicalTotalScore = BigDecimal.ZERO;
    
    /** 艺术教育 */
    private BigDecimal artEducationScore = BigDecimal.ZERO;
    
    /** 艺术实践 */
    private BigDecimal artPracticeScore = BigDecimal.ZERO;
    
    /** 美育总分 */
    private BigDecimal aestheticTotalScore = BigDecimal.ZERO;
    
    /** 劳动教育 */
    private BigDecimal laborEducationScore = BigDecimal.ZERO;
    
    /** 劳育正向加分 */
    private BigDecimal laborBonusScore = BigDecimal.ZERO;
    
    /** 劳育反向减分 */
    private BigDecimal laborDeductionScore = BigDecimal.ZERO;
    
    /** 劳育总分 */
    private BigDecimal laborTotalScore = BigDecimal.ZERO;
    
    /** F3总分 */
    private BigDecimal f3TotalScore = BigDecimal.ZERO;
    
    // ==================== 综测汇总 ====================
    
    /** 综测合计 */
    private BigDecimal totalScore = BigDecimal.ZERO;
    
    /** 综测排名 */
    private Integer totalRank;
    
    // ==================== Getters and Setters ====================
    
    public Long getStudentId() {
        return studentId;
    }
    
    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getStudentCode() {
        return studentCode;
    }
    
    public void setStudentCode(String studentCode) {
        this.studentCode = studentCode;
    }
    
    public String getClassName() {
        return className;
    }
    
    public void setClassName(String className) {
        this.className = className;
    }
    
    public BigDecimal getF1BaseScore() {
        return f1BaseScore;
    }
    
    public void setF1BaseScore(BigDecimal f1BaseScore) {
        this.f1BaseScore = f1BaseScore;
    }
    
    public Map<String, BigDecimal> getF1BonusItems() {
        return f1BonusItems;
    }
    
    public void setF1BonusItems(Map<String, BigDecimal> f1BonusItems) {
        this.f1BonusItems = f1BonusItems;
    }
    
    public Map<String, BigDecimal> getF1DeductionItems() {
        return f1DeductionItems;
    }
    
    public void setF1DeductionItems(Map<String, BigDecimal> f1DeductionItems) {
        this.f1DeductionItems = f1DeductionItems;
    }
    
    public BigDecimal getF1TotalScore() {
        return f1TotalScore;
    }
    
    public void setF1TotalScore(BigDecimal f1TotalScore) {
        this.f1TotalScore = f1TotalScore;
    }
    
    public Map<String, BigDecimal> getF2aCourseScores() {
        return f2aCourseScores;
    }
    
    public void setF2aCourseScores(Map<String, BigDecimal> f2aCourseScores) {
        this.f2aCourseScores = f2aCourseScores;
    }
    
    public BigDecimal getF2aAverageScore() {
        return f2aAverageScore;
    }
    
    public void setF2aAverageScore(BigDecimal f2aAverageScore) {
        this.f2aAverageScore = f2aAverageScore;
    }
    
    public BigDecimal getF2aTotalScore() {
        return f2aTotalScore;
    }
    
    public void setF2aTotalScore(BigDecimal f2aTotalScore) {
        this.f2aTotalScore = f2aTotalScore;
    }
    
    public Integer getF2aClassRank() {
        return f2aClassRank;
    }
    
    public void setF2aClassRank(Integer f2aClassRank) {
        this.f2aClassRank = f2aClassRank;
    }
    
    public Map<String, BigDecimal> getF2bCompetitionScores() {
        return f2bCompetitionScores;
    }
    
    public void setF2bCompetitionScores(Map<String, BigDecimal> f2bCompetitionScores) {
        this.f2bCompetitionScores = f2bCompetitionScores;
    }
    
    public BigDecimal getF2bTotalScore() {
        return f2bTotalScore;
    }
    
    public void setF2bTotalScore(BigDecimal f2bTotalScore) {
        this.f2bTotalScore = f2bTotalScore;
    }
    
    public BigDecimal getPhysicalScore() {
        return physicalScore;
    }
    
    public void setPhysicalScore(BigDecimal physicalScore) {
        this.physicalScore = physicalScore;
    }
    
    public BigDecimal getPhysicalTestScore() {
        return physicalTestScore;
    }
    
    public void setPhysicalTestScore(BigDecimal physicalTestScore) {
        this.physicalTestScore = physicalTestScore;
    }
    
    public BigDecimal getPhysicalBonusScore() {
        return physicalBonusScore;
    }
    
    public void setPhysicalBonusScore(BigDecimal physicalBonusScore) {
        this.physicalBonusScore = physicalBonusScore;
    }
    
    public BigDecimal getPhysicalDeductionScore() {
        return physicalDeductionScore;
    }
    
    public void setPhysicalDeductionScore(BigDecimal physicalDeductionScore) {
        this.physicalDeductionScore = physicalDeductionScore;
    }
    
    public BigDecimal getPhysicalTotalScore() {
        return physicalTotalScore;
    }
    
    public void setPhysicalTotalScore(BigDecimal physicalTotalScore) {
        this.physicalTotalScore = physicalTotalScore;
    }
    
    public BigDecimal getArtEducationScore() {
        return artEducationScore;
    }
    
    public void setArtEducationScore(BigDecimal artEducationScore) {
        this.artEducationScore = artEducationScore;
    }
    
    public BigDecimal getArtPracticeScore() {
        return artPracticeScore;
    }
    
    public void setArtPracticeScore(BigDecimal artPracticeScore) {
        this.artPracticeScore = artPracticeScore;
    }
    
    public BigDecimal getAestheticTotalScore() {
        return aestheticTotalScore;
    }
    
    public void setAestheticTotalScore(BigDecimal aestheticTotalScore) {
        this.aestheticTotalScore = aestheticTotalScore;
    }
    
    public BigDecimal getLaborEducationScore() {
        return laborEducationScore;
    }
    
    public void setLaborEducationScore(BigDecimal laborEducationScore) {
        this.laborEducationScore = laborEducationScore;
    }
    
    public BigDecimal getLaborBonusScore() {
        return laborBonusScore;
    }
    
    public void setLaborBonusScore(BigDecimal laborBonusScore) {
        this.laborBonusScore = laborBonusScore;
    }
    
    public BigDecimal getLaborDeductionScore() {
        return laborDeductionScore;
    }
    
    public void setLaborDeductionScore(BigDecimal laborDeductionScore) {
        this.laborDeductionScore = laborDeductionScore;
    }
    
    public BigDecimal getLaborTotalScore() {
        return laborTotalScore;
    }
    
    public void setLaborTotalScore(BigDecimal laborTotalScore) {
        this.laborTotalScore = laborTotalScore;
    }
    
    public BigDecimal getF3TotalScore() {
        return f3TotalScore;
    }
    
    public void setF3TotalScore(BigDecimal f3TotalScore) {
        this.f3TotalScore = f3TotalScore;
    }
    
    public BigDecimal getTotalScore() {
        return totalScore;
    }
    
    public void setTotalScore(BigDecimal totalScore) {
        this.totalScore = totalScore;
    }
    
    public Integer getTotalRank() {
        return totalRank;
    }
    
    public void setTotalRank(Integer totalRank) {
        this.totalRank = totalRank;
    }
}

