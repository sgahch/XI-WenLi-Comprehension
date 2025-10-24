package com.ruoyi.system.utils;

import com.ruoyi.system.domain.TSemesterScoreDetail;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 排名更新工具类
 * 
 * @author ruoyi
 * @date 2024-01-15
 */
public class RankingUpdateUtils {

    /**
     * 更新班级排名
     * 
     * @param scoreDetails 同班级的成绩明细列表
     * @return 更新后的成绩明细列表
     */
    public static List<TSemesterScoreDetail> updateClassRankings(List<TSemesterScoreDetail> scoreDetails) {
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return scoreDetails;
        }

        // 按综合成绩降序排序
        List<TSemesterScoreDetail> sortedList = scoreDetails.stream()
                .sorted((a, b) -> {
                    BigDecimal scoreA = a.getTotalScore() != null ? a.getTotalScore() : BigDecimal.ZERO;
                    BigDecimal scoreB = b.getTotalScore() != null ? b.getTotalScore() : BigDecimal.ZERO;
                    int result = scoreB.compareTo(scoreA);
                    
                    // 如果综合成绩相同，按学号升序排序（保证排名的稳定性）
                    if (result == 0) {
                        return a.getStudentId().compareTo(b.getStudentId());
                    }
                    return result;
                })
                .collect(Collectors.toList());

        // 更新排名（处理并列排名）
        updateRankingsWithTies(sortedList, true);

        return sortedList;
    }

    /**
     * 更新专业排名
     * 
     * @param scoreDetails 同专业的成绩明细列表
     * @return 更新后的成绩明细列表
     */
    public static List<TSemesterScoreDetail> updateMajorRankings(List<TSemesterScoreDetail> scoreDetails) {
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return scoreDetails;
        }

        // 按综合成绩降序排序
        List<TSemesterScoreDetail> sortedList = scoreDetails.stream()
                .sorted((a, b) -> {
                    BigDecimal scoreA = a.getTotalScore() != null ? a.getTotalScore() : BigDecimal.ZERO;
                    BigDecimal scoreB = b.getTotalScore() != null ? b.getTotalScore() : BigDecimal.ZERO;
                    int result = scoreB.compareTo(scoreA);
                    
                    // 如果综合成绩相同，按学号升序排序（保证排名的稳定性）
                    if (result == 0) {
                        return a.getStudentId().compareTo(b.getStudentId());
                    }
                    return result;
                })
                .collect(Collectors.toList());

        // 更新排名（处理并列排名）
        updateRankingsWithTies(sortedList, false);

        return sortedList;
    }

    /**
     * 更新排名（处理并列排名情况）
     * 
     * @param sortedList 已排序的成绩列表
     * @param isClassRanking 是否为班级排名
     */
    private static void updateRankingsWithTies(List<TSemesterScoreDetail> sortedList, boolean isClassRanking) {
        if (CollectionUtils.isEmpty(sortedList)) {
            return;
        }

        int currentRank = 1;
        BigDecimal previousScore = null;
        int sameScoreCount = 0;

        for (int i = 0; i < sortedList.size(); i++) {
            TSemesterScoreDetail detail = sortedList.get(i);
            BigDecimal currentScore = detail.getTotalScore() != null ? 
                detail.getTotalScore() : BigDecimal.ZERO;

            // 如果当前成绩与前一个成绩相同，使用相同排名
            if (previousScore != null && currentScore.compareTo(previousScore) == 0) {
                sameScoreCount++;
            } else {
                // 成绩不同，更新排名
                currentRank = i + 1;
                sameScoreCount = 0;
            }

            // 设置排名
            if (isClassRanking) {
                detail.setClassRank(currentRank);
            } else {
                detail.setMajorRank(currentRank);
            }

            previousScore = currentScore;
        }
    }

    /**
     * 批量更新班级排名（按班级分组）
     * 
     * @param scoreDetails 成绩明细列表
     * @return 更新后的成绩明细列表
     */
    public static List<TSemesterScoreDetail> batchUpdateClassRankings(List<TSemesterScoreDetail> scoreDetails) {
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return scoreDetails;
        }

        // 按班级分组
        Map<String, List<TSemesterScoreDetail>> classGroups = scoreDetails.stream()
                .filter(detail -> detail.getClassId() != null)
                .collect(Collectors.groupingBy(TSemesterScoreDetail::getClassId));

        List<TSemesterScoreDetail> updatedList = new ArrayList<>();

        // 为每个班级更新排名
        for (List<TSemesterScoreDetail> classScores : classGroups.values()) {
            List<TSemesterScoreDetail> rankedScores = updateClassRankings(classScores);
            updatedList.addAll(rankedScores);
        }

        return updatedList;
    }

    /**
     * 批量更新专业排名（按专业分组）
     * 
     * @param scoreDetails 成绩明细列表
     * @return 更新后的成绩明细列表
     */
    public static List<TSemesterScoreDetail> batchUpdateMajorRankings(List<TSemesterScoreDetail> scoreDetails) {
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return scoreDetails;
        }

        // 按专业分组
        Map<String, List<TSemesterScoreDetail>> majorGroups = scoreDetails.stream()
                .filter(detail -> detail.getMajorId() != null)
                .collect(Collectors.groupingBy(TSemesterScoreDetail::getMajorId));

        List<TSemesterScoreDetail> updatedList = new ArrayList<>();

        // 为每个专业更新排名
        for (List<TSemesterScoreDetail> majorScores : majorGroups.values()) {
            List<TSemesterScoreDetail> rankedScores = updateMajorRankings(majorScores);
            updatedList.addAll(rankedScores);
        }

        return updatedList;
    }

    /**
     * 获取班级排名统计信息
     * 
     * @param scoreDetails 同班级的成绩明细列表
     * @return 排名统计信息
     */
    public static Map<String, Object> getClassRankingStatistics(List<TSemesterScoreDetail> scoreDetails) {
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return Collections.emptyMap();
        }

        List<BigDecimal> scores = scoreDetails.stream()
                .map(TSemesterScoreDetail::getTotalScore)
                .filter(Objects::nonNull)
                .sorted(Collections.reverseOrder())
                .collect(Collectors.toList());

        if (scores.isEmpty()) {
            return Collections.emptyMap();
        }

        Map<String, Object> statistics = new HashMap<>();
        statistics.put("totalCount", scoreDetails.size());
        statistics.put("validScoreCount", scores.size());
        statistics.put("highestScore", scores.get(0));
        statistics.put("lowestScore", scores.get(scores.size() - 1));
        
        // 计算平均分
        BigDecimal sum = scores.stream().reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal average = sum.divide(new BigDecimal(scores.size()), 2, java.math.RoundingMode.HALF_UP);
        statistics.put("averageScore", average);

        // 计算中位数
        BigDecimal median;
        int size = scores.size();
        if (size % 2 == 0) {
            median = scores.get(size / 2 - 1).add(scores.get(size / 2))
                    .divide(new BigDecimal("2"), 2, java.math.RoundingMode.HALF_UP);
        } else {
            median = scores.get(size / 2);
        }
        statistics.put("medianScore", median);

        return statistics;
    }

    /**
     * 获取专业排名统计信息
     * 
     * @param scoreDetails 同专业的成绩明细列表
     * @return 排名统计信息
     */
    public static Map<String, Object> getMajorRankingStatistics(List<TSemesterScoreDetail> scoreDetails) {
        return getClassRankingStatistics(scoreDetails); // 统计逻辑相同
    }

    /**
     * 计算排名变化趋势
     * 
     * @param currentScores 当前学期成绩列表
     * @param previousScores 上一学期成绩列表
     * @return 排名变化Map，key为学号，value为排名变化（正数表示上升，负数表示下降）
     */
    public static Map<String, Integer> calculateRankingTrends(
            List<TSemesterScoreDetail> currentScores, 
            List<TSemesterScoreDetail> previousScores) {
        
        Map<String, Integer> trends = new HashMap<>();
        
        if (CollectionUtils.isEmpty(currentScores) || CollectionUtils.isEmpty(previousScores)) {
            return trends;
        }

        // 构建当前学期排名映射
        Map<String, Integer> currentRankings = currentScores.stream()
                .filter(detail -> detail.getStudentId() != null && detail.getClassRank() != null)
                .collect(Collectors.toMap(
                    detail -> String.valueOf(detail.getStudentId()),
                    TSemesterScoreDetail::getClassRank,
                    (existing, replacement) -> existing
                ));

         // 构建上一学期排名映射
         Map<String, Integer> previousRankings = previousScores.stream()
                .filter(detail -> detail.getStudentId() != null && detail.getClassRank() != null)
                .collect(Collectors.toMap(
                    detail -> String.valueOf(detail.getStudentId()),
                    TSemesterScoreDetail::getClassRank,
                    (existing, replacement) -> existing
                ));

        // 计算排名变化
        for (String studentId : currentRankings.keySet()) {
            Integer currentRank = currentRankings.get(studentId);
            Integer previousRank = previousRankings.get(studentId);
            
            if (previousRank != null) {
                // 排名变化 = 上一学期排名 - 当前学期排名（正数表示上升）
                int change = previousRank - currentRank;
                trends.put(studentId, change);
            }
        }

        return trends;
    }

    /**
     * 获取排名区间分布
     * 
     * @param scoreDetails 成绩明细列表
     * @return 排名区间分布Map
     */
    public static Map<String, Integer> getRankingDistribution(List<TSemesterScoreDetail> scoreDetails) {
        Map<String, Integer> distribution = new HashMap<>();
        
        if (CollectionUtils.isEmpty(scoreDetails)) {
            return distribution;
        }

        int totalCount = scoreDetails.size();
        
        // 初始化区间
        distribution.put("top10", 0);      // 前10%
        distribution.put("top25", 0);      // 前25%
        distribution.put("top50", 0);      // 前50%
        distribution.put("bottom50", 0);   // 后50%
        distribution.put("bottom25", 0);   // 后25%
        distribution.put("bottom10", 0);   // 后10%

        for (TSemesterScoreDetail detail : scoreDetails) {
            Integer ranking = detail.getClassRank();
            if (ranking == null) {
                continue;
            }

            double percentile = (double) ranking / totalCount;
            
            if (percentile <= 0.1) {
                distribution.merge("top10", 1, Integer::sum);
            }
            if (percentile <= 0.25) {
                distribution.merge("top25", 1, Integer::sum);
            }
            if (percentile <= 0.5) {
                distribution.merge("top50", 1, Integer::sum);
            }
            if (percentile > 0.5) {
                distribution.merge("bottom50", 1, Integer::sum);
            }
            if (percentile > 0.75) {
                distribution.merge("bottom25", 1, Integer::sum);
            }
            if (percentile > 0.9) {
                distribution.merge("bottom10", 1, Integer::sum);
            }
        }

        return distribution;
    }
}