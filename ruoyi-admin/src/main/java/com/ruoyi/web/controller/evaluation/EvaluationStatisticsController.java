package com.ruoyi.web.controller.evaluation;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import com.ruoyi.system.service.ITSemesterScoreDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 成绩统计与趋势相关接口
 */
@RestController
@RequestMapping("/evaluation/statistics")
public class EvaluationStatisticsController extends BaseController {

    @Autowired
    private ITSemesterScoreDetailService tSemesterScoreDetailService;

    /**
     * 学生成绩趋势
     * 与前端 `GET /evaluation/statistics/trend` 对齐
     * 支持维度：comprehensive(综合)、intellectual(智育)、moral(德育)、physical(体育)、aesthetic(美育)、labor(劳育)
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/trend")
    public AjaxResult getTrend(@RequestParam String studentId,
                               @RequestParam(required = false) String dimension,
                               @RequestParam(required = false) String timeRange) {
        // 1) 查询该学生的所有学期成绩
        TSemesterScoreDetail query = new TSemesterScoreDetail();
        query.setStudentId(studentId);
        List<TSemesterScoreDetail> list = tSemesterScoreDetailService.selectTSemesterScoreDetailList(query);

        if (list == null || list.isEmpty()) {
            Map<String, Object> empty = new HashMap<>();
            empty.put("semesters", Collections.emptyList());
            empty.put("scores", Collections.emptyList());
            empty.put("ranks", Collections.emptyList());
            empty.put("stats", Collections.emptyMap());
            return success(empty);
        }

        // 2) 可选时间范围过滤：格式示例 "2022-2023,2023-2024"
        if (timeRange != null && !timeRange.trim().isEmpty()) {
            Set<String> years = Arrays.stream(timeRange.split(","))
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .collect(Collectors.toSet());
            list = list.stream()
                    .filter(it -> years.contains(it.getAcademicYear()))
                    .collect(Collectors.toList());
        }

        // 3) 排序：按学年字符串升序，再按学期(1/2)升序
        list.sort(Comparator.comparing(TSemesterScoreDetail::getAcademicYear)
                .thenComparing(it -> Optional.ofNullable(it.getSemester()).orElse(0)));

        // 4) 组装 semesters、scores、ranks
        List<String> semesters = new ArrayList<>();
        List<BigDecimal> scores = new ArrayList<>();
        List<Integer> ranks = new ArrayList<>();

        for (TSemesterScoreDetail d : list) {
            String label = d.getAcademicYear() + "-" + Optional.ofNullable(d.getSemester()).orElse(0);
            semesters.add(label);

            BigDecimal score;
            Integer rank;
            String dim = dimension == null ? "comprehensive" : dimension.toLowerCase();
            switch (dim) {
                case "intellectual":
                    score = d.getIntellectualScore();
                    rank = d.getIntellectualRank();
                    break;
                case "moral":
                    score = d.getMoralScore();
                    rank = d.getMoralRank();
                    break;
                case "physical":
                    score = d.getPhysicalScore();
                    rank = d.getPhysicalRank();
                    break;
                case "aesthetic":
                    score = d.getAestheticScore();
                    rank = d.getAestheticRank();
                    break;
                case "labor":
                    score = d.getLaborScore();
                    rank = d.getLaborRank();
                    break;
                case "comprehensive":
                default:
                    score = d.getTotalScore();
                    // 趋势图以班级排名优先，其次专业排名
                    rank = d.getClassRank() != null ? d.getClassRank() : d.getMajorRank();
                    break;
            }

            scores.add(score != null ? score : BigDecimal.ZERO);
            ranks.add(rank);
        }

        // 5) 统计信息：avg/max/min + 简单趋势方向与提升幅度
        BigDecimal avg = average(scores);
        BigDecimal max = max(scores);
        BigDecimal min = min(scores);

        int trendDirection = 0; // 1 上升，0 平稳，-1 下降
        BigDecimal improvementRate = BigDecimal.ZERO;
        if (scores.size() >= 2) {
            BigDecimal first = scores.get(0);
            BigDecimal last = scores.get(scores.size() - 1);
            int cmp = last.compareTo(first);
            if (cmp > 0) trendDirection = 1; else if (cmp < 0) trendDirection = -1; else trendDirection = 0;
            if (first.compareTo(BigDecimal.ZERO) != 0) {
                improvementRate = last.subtract(first)
                                      .divide(first, 4, BigDecimal.ROUND_HALF_UP)
                                      .multiply(BigDecimal.valueOf(100));
            }
        }

        Map<String, Object> stats = new HashMap<>();
        stats.put("avgScore", avg);
        stats.put("maxScore", max);
        stats.put("minScore", min);
        stats.put("trendDirection", trendDirection);
        stats.put("improvementRate", improvementRate);

        Map<String, Object> result = new HashMap<>();
        result.put("semesters", semesters);
        result.put("scores", scores);
        result.put("ranks", ranks);
        result.put("stats", stats);

        return success(result);
    }

    private BigDecimal average(List<BigDecimal> numbers) {
        if (numbers == null || numbers.isEmpty()) return BigDecimal.ZERO;
        BigDecimal sum = BigDecimal.ZERO;
        int count = 0;
        for (BigDecimal n : numbers) {
            if (n != null) {
                sum = sum.add(n);
                count++;
            }
        }
        return count == 0 ? BigDecimal.ZERO : sum.divide(BigDecimal.valueOf(count), 2, BigDecimal.ROUND_HALF_UP);
    }

    private BigDecimal max(List<BigDecimal> numbers) {
        BigDecimal m = null;
        for (BigDecimal n : numbers) {
            if (n == null) continue;
            if (m == null || n.compareTo(m) > 0) m = n;
        }
        return m == null ? BigDecimal.ZERO : m;
    }

    private BigDecimal min(List<BigDecimal> numbers) {
        BigDecimal m = null;
        for (BigDecimal n : numbers) {
            if (n == null) continue;
            if (m == null || n.compareTo(m) < 0) m = n;
        }
        return m == null ? BigDecimal.ZERO : m;
    }
}