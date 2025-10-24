package com.ruoyi.system.utils;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import com.ruoyi.system.domain.TEvaluationItemConfig;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * 数据验证工具类
 * 
 * @author ruoyi
 * @date 2024-01-15
 */
public class DataValidationUtils {

    /**
     * 学号格式正则表达式（支持多种格式）
     */
    private static final Pattern STUDENT_ID_PATTERN = Pattern.compile("^[0-9]{8,12}$");

    /**
     * 学年格式正则表达式（如：2023-2024）
     */
    private static final Pattern ACADEMIC_YEAR_PATTERN = Pattern.compile("^\\d{4}-\\d{4}$");

    /**
     * 验证成绩明细数据的完整性
     * 
     * @param scoreDetail 成绩明细对象
     * @return 验证结果列表，空列表表示验证通过
     */
    public static List<String> validateScoreDetailIntegrity(TSemesterScoreDetail scoreDetail) {
        List<String> errors = new ArrayList<>();

        if (scoreDetail == null) {
            errors.add("成绩数据不能为空");
            return errors;
        }

        // 验证必填字段
        if (!StringUtils.hasText(scoreDetail.getStudentId())) {
            errors.add("学号不能为空");
        } else if (!STUDENT_ID_PATTERN.matcher(scoreDetail.getStudentId()).matches()) {
            errors.add("学号格式不正确，应为8-12位数字");
        }

        if (!StringUtils.hasText(scoreDetail.getStudentName())) {
            errors.add("学生姓名不能为空");
        } else if (scoreDetail.getStudentName().length() > 50) {
            errors.add("学生姓名长度不能超过50个字符");
        }

        if (!StringUtils.hasText(scoreDetail.getAcademicYear())) {
            errors.add("学年不能为空");
        } else if (!ACADEMIC_YEAR_PATTERN.matcher(scoreDetail.getAcademicYear()).matches()) {
            errors.add("学年格式不正确，应为YYYY-YYYY格式（如：2023-2024）");
        }

        if (scoreDetail.getSemester() == null) {
            errors.add("学期不能为空");
        } else if (scoreDetail.getSemester() < 1 || scoreDetail.getSemester() > 2) {
            errors.add("学期只能是1或2");
        }

        // 验证班级和专业信息
        if (scoreDetail.getClassId() == null) {
            errors.add("班级ID不能为空");
        }

        if (!StringUtils.hasText(scoreDetail.getClassName())) {
            errors.add("班级名称不能为空");
        }

        if (scoreDetail.getMajorId() == null) {
            errors.add("专业ID不能为空");
        }

        if (!StringUtils.hasText(scoreDetail.getMajorName())) {
            errors.add("专业名称不能为空");
        }

        return errors;
    }

    /**
     * 验证成绩数值的有效性
     * 
     * @param scoreDetail 成绩明细对象
     * @return 验证结果列表，空列表表示验证通过
     */
    public static List<String> validateScoreValues(TSemesterScoreDetail scoreDetail) {
        List<String> errors = new ArrayList<>();

        if (scoreDetail == null) {
            errors.add("成绩数据不能为空");
            return errors;
        }

        // 验证德育成绩
        if (scoreDetail.getMoralScore() != null) {
            String error = validateSingleScore(scoreDetail.getMoralScore(), "德育成绩");
            if (error != null) {
                errors.add(error);
            }
        }

        // 验证智育成绩
        if (scoreDetail.getIntellectualScore() != null) {
            String error = validateSingleScore(scoreDetail.getIntellectualScore(), "智育成绩");
            if (error != null) {
                errors.add(error);
            }
        }

        // 验证体育成绩
        if (scoreDetail.getPhysicalScore() != null) {
            String error = validateSingleScore(scoreDetail.getPhysicalScore(), "体育成绩");
            if (error != null) {
                errors.add(error);
            }
        }

        // 验证美育成绩
        if (scoreDetail.getAestheticScore() != null) {
            String error = validateSingleScore(scoreDetail.getAestheticScore(), "美育成绩");
            if (error != null) {
                errors.add(error);
            }
        }

        // 验证劳育成绩
        if (scoreDetail.getLaborScore() != null) {
            String error = validateSingleScore(scoreDetail.getLaborScore(), "劳育成绩");
            if (error != null) {
                errors.add(error);
            }
        }

        // 验证综合成绩
        if (scoreDetail.getTotalScore() != null) {
            String error = validateSingleScore(scoreDetail.getTotalScore(), "综合成绩");
            if (error != null) {
                errors.add(error);
            }
        }

        return errors;
    }

    /**
     * 验证单个成绩数值
     * 
     * @param score 成绩值
     * @param scoreName 成绩名称
     * @return 错误信息，null表示验证通过
     */
    private static String validateSingleScore(BigDecimal score, String scoreName) {
        if (score == null) {
            return null;
        }

        if (score.compareTo(BigDecimal.ZERO) < 0) {
            return scoreName + "不能为负数";
        }

        if (score.compareTo(new BigDecimal("100")) > 0) {
            return scoreName + "不能超过100分";
        }

        // 检查小数位数（最多2位小数）
        if (score.scale() > 2) {
            return scoreName + "最多保留2位小数";
        }

        return null;
    }

    /**
     * 验证排名数据的合理性
     * 
     * @param scoreDetail 成绩明细对象
     * @return 验证结果列表，空列表表示验证通过
     */
    public static List<String> validateRankingData(TSemesterScoreDetail scoreDetail) {
        List<String> errors = new ArrayList<>();

        if (scoreDetail == null) {
            return errors;
        }

        // 验证班级排名
        if (scoreDetail.getClassRank() != null && scoreDetail.getClassRank() <= 0) {
            errors.add("班级排名必须大于0");
        }

        // 验证专业排名
        if (scoreDetail.getMajorRank() != null && scoreDetail.getMajorRank() <= 0) {
            errors.add("专业排名必须大于0");
        }

        // 验证排名的逻辑关系（专业排名应该大于等于班级排名）
        if (scoreDetail.getClassRank() != null && scoreDetail.getMajorRank() != null) {
            if (scoreDetail.getMajorRank() < scoreDetail.getClassRank()) {
                errors.add("专业排名不能小于班级排名");
            }
        }

        return errors;
    }

    /**
     * 验证详细项目得分JSON数据
     * 
     * @param detailScores 详细项目得分JSON字符串
     * @param itemConfigs 评分项目配置列表
     * @return 验证结果列表，空列表表示验证通过
     */
    public static List<String> validateDetailScores(String detailScores, List<TEvaluationItemConfig> itemConfigs) {
        List<String> errors = new ArrayList<>();

        if (!StringUtils.hasText(detailScores)) {
            return errors; // 允许为空
        }

        try {
            JSONObject scoresJson = JSON.parseObject(detailScores);
            
            if (itemConfigs != null && !itemConfigs.isEmpty()) {
                for (TEvaluationItemConfig config : itemConfigs) {
                    if (!"1".equals(config.getIsActive())) {
                         continue; // 跳过未启用的配置项
                     }

                     String itemCode = config.getItemCode();
                    
                    // 检查必填项
                    if ("1".equals(config.getIsRequired()) && !scoresJson.containsKey(itemCode)) {
                        errors.add(String.format("必填项目[%s]的得分不能为空", config.getItemName()));
                        continue;
                    }

                    // 验证得分范围
                    if (scoresJson.containsKey(itemCode)) {
                        Object scoreObj = scoresJson.get(itemCode);
                        if (scoreObj != null) {
                            try {
                                BigDecimal score = new BigDecimal(scoreObj.toString());
                                
                                if (score.compareTo(config.getMinScore()) < 0) {
                                    errors.add(String.format("项目[%s]得分不能低于%.2f", 
                                        config.getItemName(), config.getMinScore().doubleValue()));
                                }
                                
                                if (score.compareTo(config.getMaxScore()) > 0) {
                                    errors.add(String.format("项目[%s]得分不能超过%.2f", 
                                        config.getItemName(), config.getMaxScore().doubleValue()));
                                }
                            } catch (NumberFormatException e) {
                                errors.add(String.format("项目[%s]得分格式不正确", config.getItemName()));
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            errors.add("详细项目得分JSON格式不正确：" + e.getMessage());
        }

        return errors;
    }

    /**
     * 验证评分项目配置数据
     * 
     * @param itemConfig 评分项目配置对象
     * @return 验证结果列表，空列表表示验证通过
     */
    public static List<String> validateItemConfig(TEvaluationItemConfig itemConfig) {
        List<String> errors = new ArrayList<>();

        if (itemConfig == null) {
            errors.add("评分项目配置不能为空");
            return errors;
        }

        // 验证必填字段
        if (itemConfig.getDimensionType() == null) {
            errors.add("维度类型不能为空");
        } else if (!isValidDimensionType(itemConfig.getDimensionType())) {
            errors.add("维度类型必须是：1智育、2德育、3体育、4美育、5劳育之一");
        }

        if (!StringUtils.hasText(itemConfig.getItemCode())) {
            errors.add("项目编码不能为空");
        } else if (itemConfig.getItemCode().length() > 50) {
            errors.add("项目编码长度不能超过50个字符");
        }

        if (!StringUtils.hasText(itemConfig.getItemName())) {
            errors.add("项目名称不能为空");
        } else if (itemConfig.getItemName().length() > 100) {
            errors.add("项目名称长度不能超过100个字符");
        }

        // 验证分值范围
        if (itemConfig.getMinScore() == null) {
            errors.add("最低分值不能为空");
        }

        if (itemConfig.getMaxScore() == null) {
            errors.add("最高分值不能为空");
        }

        if (itemConfig.getMinScore() != null && itemConfig.getMaxScore() != null) {
            if (itemConfig.getMinScore().compareTo(itemConfig.getMaxScore()) > 0) {
                errors.add("最低分值不能大于最高分值");
            }
        }

        if (itemConfig.getDefaultScore() != null && itemConfig.getMinScore() != null && itemConfig.getMaxScore() != null) {
            if (itemConfig.getDefaultScore().compareTo(itemConfig.getMinScore()) < 0 || 
                itemConfig.getDefaultScore().compareTo(itemConfig.getMaxScore()) > 0) {
                errors.add("默认分值必须在最低分值和最高分值之间");
            }
        }

        // 验证权重
        if (itemConfig.getWeight() != null && itemConfig.getWeight().compareTo(BigDecimal.ZERO) <= 0) {
            errors.add("权重必须大于0");
        }

        // 验证排序
        if (itemConfig.getSortOrder() != null && itemConfig.getSortOrder() < 0) {
            errors.add("排序不能为负数");
        }

        return errors;
    }

    /**
     * 验证维度类型是否有效
     * 
     * @param dimensionType 维度类型
     * @return 是否有效
     */
    private static boolean isValidDimensionType(Integer dimensionType) {
        return dimensionType != null && dimensionType >= 1 && dimensionType <= 5;
    }

    /**
     * 批量验证成绩数据
     * 
     * @param scoreDetails 成绩明细列表
     * @return 验证结果Map，key为行号，value为错误信息列表
     */
    public static Map<Integer, List<String>> batchValidateScoreDetails(List<TSemesterScoreDetail> scoreDetails) {
        Map<Integer, List<String>> validationResults = new java.util.HashMap<>();

        if (scoreDetails == null || scoreDetails.isEmpty()) {
            return validationResults;
        }

        for (int i = 0; i < scoreDetails.size(); i++) {
            TSemesterScoreDetail scoreDetail = scoreDetails.get(i);
            List<String> errors = new ArrayList<>();

            // 完整性验证
            errors.addAll(validateScoreDetailIntegrity(scoreDetail));
            
            // 数值验证
            errors.addAll(validateScoreValues(scoreDetail));
            
            // 排名验证
            errors.addAll(validateRankingData(scoreDetail));

            if (!errors.isEmpty()) {
                validationResults.put(i + 1, errors); // 行号从1开始
            }
        }

        return validationResults;
    }

    /**
     * 验证数据一致性
     * 
     * @param scoreDetail 成绩明细对象
     * @return 验证结果列表，空列表表示验证通过
     */
    public static List<String> validateDataConsistency(TSemesterScoreDetail scoreDetail) {
        List<String> errors = new ArrayList<>();

        if (scoreDetail == null) {
            errors.add("成绩数据不能为空");
            return errors;
        }

        // 验证综合成绩与各维度成绩的一致性
        BigDecimal calculatedScore = ScoreCalculationUtils.calculateComprehensiveScore(scoreDetail);
        BigDecimal recordedScore = scoreDetail.getTotalScore();

        if (recordedScore != null && calculatedScore != null) {
            BigDecimal difference = calculatedScore.subtract(recordedScore).abs();
            if (difference.compareTo(new BigDecimal("0.01")) > 0) {
                errors.add(String.format("综合成绩不一致：计算值%.2f，记录值%.2f", 
                    calculatedScore.doubleValue(), recordedScore.doubleValue()));
            }
        }

        return errors;
    }

    /**
     * 统一校验成绩明细（抛出异常便于上层捕获）
     *
     * @param scoreDetail 成绩明细对象
     */
    public static void validateScoreDetail(TSemesterScoreDetail scoreDetail) {
        List<String> errors = new ArrayList<>();
        // 完整性校验
        errors.addAll(validateScoreDetailIntegrity(scoreDetail));
        // 数值范围校验
        errors.addAll(validateScoreValues(scoreDetail));
        // 排名合理性校验
        errors.addAll(validateRankingData(scoreDetail));
        // 数据一致性校验
        errors.addAll(validateDataConsistency(scoreDetail));

        if (!errors.isEmpty()) {
            throw new RuntimeException(String.join("；", errors));
        }
    }
}