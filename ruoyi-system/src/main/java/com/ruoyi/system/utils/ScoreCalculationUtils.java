package com.ruoyi.system.utils;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;

import com.ruoyi.system.domain.TEvaluationItemConfig;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

/**
 * 成绩计算工具类
 * 
 * @author ruoyi
 * @date 2024-01-15
 */
public class ScoreCalculationUtils {

    /**
     * 德智体美劳维度权重配置（默认权重）
     */
    private static final BigDecimal DEFAULT_MORAL_WEIGHT = new BigDecimal("0.15");      // 德育权重 15%
    private static final BigDecimal DEFAULT_INTELLECTUAL_WEIGHT = new BigDecimal("0.50"); // 智育权重 50%
    private static final BigDecimal DEFAULT_PHYSICAL_WEIGHT = new BigDecimal("0.15");     // 体育权重 15%
    private static final BigDecimal DEFAULT_AESTHETIC_WEIGHT = new BigDecimal("0.10");    // 美育权重 10%
    private static final BigDecimal DEFAULT_LABOR_WEIGHT = new BigDecimal("0.10");        // 劳育权重 10%

    /**
     * 计算综合成绩
     * 
     * @param scoreDetail 成绩明细对象
     * @return 综合成绩
     */
    public static BigDecimal calculateComprehensiveScore(TSemesterScoreDetail scoreDetail) {
        if (scoreDetail == null) {
            return BigDecimal.ZERO;
        }

        BigDecimal moralScore = scoreDetail.getMoralScore() != null ? scoreDetail.getMoralScore() : BigDecimal.ZERO;
        BigDecimal intellectualScore = scoreDetail.getIntellectualScore() != null ? scoreDetail.getIntellectualScore() : BigDecimal.ZERO;
        BigDecimal physicalScore = scoreDetail.getPhysicalScore() != null ? scoreDetail.getPhysicalScore() : BigDecimal.ZERO;
        BigDecimal aestheticScore = scoreDetail.getAestheticScore() != null ? scoreDetail.getAestheticScore() : BigDecimal.ZERO;
        BigDecimal laborScore = scoreDetail.getLaborScore() != null ? scoreDetail.getLaborScore() : BigDecimal.ZERO;

        // 计算加权综合成绩
        BigDecimal comprehensiveScore = moralScore.multiply(DEFAULT_MORAL_WEIGHT)
                .add(intellectualScore.multiply(DEFAULT_INTELLECTUAL_WEIGHT))
                .add(physicalScore.multiply(DEFAULT_PHYSICAL_WEIGHT))
                .add(aestheticScore.multiply(DEFAULT_AESTHETIC_WEIGHT))
                .add(laborScore.multiply(DEFAULT_LABOR_WEIGHT));

        return comprehensiveScore.setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * 根据评分项目配置计算维度成绩
     * 
     * @param detailScores 详细项目得分JSON字符串
     * @param itemConfigs 评分项目配置列表
     * @param dimensionType 维度类型
     * @return 维度成绩
     */
    public static BigDecimal calculateDimensionScore(String detailScores, List<TEvaluationItemConfig> itemConfigs, String dimensionType) {
        if (!StringUtils.hasText(detailScores) || itemConfigs == null || itemConfigs.isEmpty()) {
            return BigDecimal.ZERO;
        }

        try {
            JSONObject scoresJson = JSON.parseObject(detailScores);
            BigDecimal totalScore = BigDecimal.ZERO;
            BigDecimal totalWeight = BigDecimal.ZERO;

            for (TEvaluationItemConfig config : itemConfigs) {
                if (!String.valueOf(config.getDimensionType()).equals(dimensionType) || !Integer.valueOf(1).equals(config.getIsActive())) {
                    continue;
                }

                String itemCode = config.getItemCode();
                if (scoresJson.containsKey(itemCode)) {
                    BigDecimal itemScore = scoresJson.getBigDecimal(itemCode);
                    BigDecimal weight = config.getWeight() != null ? config.getWeight() : BigDecimal.ONE;
                    
                    if (itemScore != null) {
                        // 检查分数范围
                        if (itemScore.compareTo(config.getMinScore()) < 0) {
                            itemScore = config.getMinScore();
                        } else if (itemScore.compareTo(config.getMaxScore()) > 0) {
                            itemScore = config.getMaxScore();
                        }
                        
                        totalScore = totalScore.add(itemScore.multiply(weight));
                        totalWeight = totalWeight.add(weight);
                    }
                }
            }

            // 如果总权重为0，返回0分
            if (totalWeight.compareTo(BigDecimal.ZERO) == 0) {
                return BigDecimal.ZERO;
            }

            // 计算加权平均分
            return totalScore.divide(totalWeight, 2, RoundingMode.HALF_UP);
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    /**
     * 验证成绩数据有效性
     * 
     * @param scoreDetail 成绩明细对象
     * @return 验证结果消息，null表示验证通过
     */
    public static String validateScoreData(TSemesterScoreDetail scoreDetail) {
        if (scoreDetail == null) {
            return "成绩数据不能为空";
        }

        if (!StringUtils.hasText(scoreDetail.getStudentId())) {
            return "学号不能为空";
        }

        if (!StringUtils.hasText(scoreDetail.getStudentName())) {
            return "学生姓名不能为空";
        }

        if (!StringUtils.hasText(scoreDetail.getAcademicYear())) {
            return "学年不能为空";
        }

        if (scoreDetail.getSemester() == null) {
            return "学期不能为空";
        }

        // 验证成绩范围（0-100分）
        if (scoreDetail.getMoralScore() != null && 
            (scoreDetail.getMoralScore().compareTo(BigDecimal.ZERO) < 0 || 
             scoreDetail.getMoralScore().compareTo(new BigDecimal("100")) > 0)) {
            return "德育成绩必须在0-100分之间";
        }

        if (scoreDetail.getIntellectualScore() != null && 
            (scoreDetail.getIntellectualScore().compareTo(BigDecimal.ZERO) < 0 || 
             scoreDetail.getIntellectualScore().compareTo(new BigDecimal("100")) > 0)) {
            return "智育成绩必须在0-100分之间";
        }

        if (scoreDetail.getPhysicalScore() != null && 
            (scoreDetail.getPhysicalScore().compareTo(BigDecimal.ZERO) < 0 || 
             scoreDetail.getPhysicalScore().compareTo(new BigDecimal("100")) > 0)) {
            return "体育成绩必须在0-100分之间";
        }

        if (scoreDetail.getAestheticScore() != null && 
            (scoreDetail.getAestheticScore().compareTo(BigDecimal.ZERO) < 0 || 
             scoreDetail.getAestheticScore().compareTo(new BigDecimal("100")) > 0)) {
            return "美育成绩必须在0-100分之间";
        }

        if (scoreDetail.getLaborScore() != null && 
            (scoreDetail.getLaborScore().compareTo(BigDecimal.ZERO) < 0 || 
             scoreDetail.getLaborScore().compareTo(new BigDecimal("100")) > 0)) {
            return "劳育成绩必须在0-100分之间";
        }

        return null; // 验证通过
    }

    /**
     * 计算班级排名百分比
     * 
     * @param currentScore 当前学生成绩
     * @param classScores 班级所有学生成绩列表
     * @return 排名百分比（0-100）
     */
    public static BigDecimal calculateRankingPercentile(BigDecimal currentScore, List<BigDecimal> classScores) {
        if (currentScore == null || classScores == null || classScores.isEmpty()) {
            return BigDecimal.ZERO;
        }

        long betterCount = classScores.stream()
                .filter(score -> score != null && score.compareTo(currentScore) > 0)
                .count();

        BigDecimal percentile = new BigDecimal(betterCount)
                .divide(new BigDecimal(classScores.size()), 4, RoundingMode.HALF_UP)
                .multiply(new BigDecimal("100"));

        return new BigDecimal("100").subtract(percentile).setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * 检查成绩数据一致性
     * 
     * @param scoreDetail 成绩明细对象
     * @return 一致性检查结果消息，null表示检查通过
     */
    public static String checkDataConsistency(TSemesterScoreDetail scoreDetail) {
        if (scoreDetail == null) {
            return "成绩数据不能为空";
        }

        // 检查综合成绩是否与各维度成绩匹配
        BigDecimal calculatedScore = calculateComprehensiveScore(scoreDetail);
        BigDecimal recordedScore = scoreDetail.getTotalScore();

        if (recordedScore != null && calculatedScore != null) {
            BigDecimal difference = calculatedScore.subtract(recordedScore).abs();
            if (difference.compareTo(new BigDecimal("0.01")) > 0) {
                return String.format("综合成绩不一致：计算值%.2f，记录值%.2f", 
                    calculatedScore.doubleValue(), recordedScore.doubleValue());
            }
        }

        // 检查班级排名和专业排名的合理性
        if (scoreDetail.getClassRank() != null && scoreDetail.getClassRank() <= 0) {
            return "班级排名必须大于0";
        }

        if (scoreDetail.getMajorRank() != null && scoreDetail.getMajorRank() <= 0) {
            return "专业排名必须大于0";
        }

        return null; // 检查通过
    }

    /**
     * 更新成绩排名
     * 
     * @param scoreDetails 成绩明细列表
     * @param rankingType 排名类型（class-班级排名，major-专业排名）
     */
    public static void updateRankings(List<TSemesterScoreDetail> scoreDetails, String rankingType) {
        if (scoreDetails == null || scoreDetails.isEmpty()) {
            return;
        }

        // 按综合成绩降序排序
        scoreDetails.sort((a, b) -> {
            BigDecimal scoreA = a.getTotalScore() != null ? a.getTotalScore() : BigDecimal.ZERO;
            BigDecimal scoreB = b.getTotalScore() != null ? b.getTotalScore() : BigDecimal.ZERO;
            return scoreB.compareTo(scoreA);
        });

        // 更新排名
        for (int i = 0; i < scoreDetails.size(); i++) {
            TSemesterScoreDetail detail = scoreDetails.get(i);
            int ranking = i + 1;
            
            if ("class".equals(rankingType)) {
                detail.setClassRank(ranking);
            } else if ("major".equals(rankingType)) {
                detail.setMajorRank(ranking);
            }
        }
    }

    /**
     * 计算成绩统计信息
     * 
     * @param scoreDetails 成绩明细列表
     * @return 统计信息Map
     */
    public static Map<String, Object> calculateStatistics(List<TSemesterScoreDetail> scoreDetails) {
        if (scoreDetails == null || scoreDetails.isEmpty()) {
            Map<String, Object> result = new HashMap<>();
            result.put("count", 0);
            result.put("averageScore", BigDecimal.ZERO);
            result.put("maxScore", BigDecimal.ZERO);
            result.put("minScore", BigDecimal.ZERO);
            result.put("passRate", BigDecimal.ZERO);
            return result;
        }

        List<BigDecimal> scores = scoreDetails.stream()
                .map(TSemesterScoreDetail::getTotalScore)
                .filter(score -> score != null)
                .collect(Collectors.toList());

        if (scores.isEmpty()) {
            Map<String, Object> result = new HashMap<>();
            result.put("count", scoreDetails.size());
            result.put("averageScore", BigDecimal.ZERO);
            result.put("maxScore", BigDecimal.ZERO);
            result.put("minScore", BigDecimal.ZERO);
            result.put("passRate", BigDecimal.ZERO);
            return result;
        }

        BigDecimal sum = scores.stream().reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal average = sum.divide(new BigDecimal(scores.size()), 2, RoundingMode.HALF_UP);
        BigDecimal max = scores.stream().max(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
        BigDecimal min = scores.stream().min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
        
        long passCount = scores.stream()
                .filter(score -> score.compareTo(new BigDecimal("60")) >= 0)
                .count();
        BigDecimal passRate = new BigDecimal(passCount)
                .divide(new BigDecimal(scores.size()), 4, RoundingMode.HALF_UP)
                .multiply(new BigDecimal("100"))
                .setScale(2, RoundingMode.HALF_UP);

        Map<String, Object> result = new HashMap<>();
        result.put("count", scoreDetails.size());
        result.put("averageScore", average);
        result.put("maxScore", max);
        result.put("minScore", min);
        result.put("passRate", passRate);
        return result;
    }
}