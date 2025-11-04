package com.ruoyi.evaluation.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 综合测评规则Controller
 *
 * @author ruoyi
 * @date 2024-01-01
 */
@RestController
@RequestMapping("/evaluation/rule")
public class EvaluationRuleController extends BaseController
{
    @Autowired
    private SqlSession sqlSession;

    /**
     * 获取树状结构的计分规则 (用于前端级联选择器)
     */
    @GetMapping("/tree")
    public AjaxResult getRuleTree(@RequestParam("dimension") String dimension)
    {
        try {
            logger.info("=== [规则查询] 接收到获取规则树的请求，维度: {} ===", dimension);

            // 从数据库查询真实数据
            List<Map<String, Object>> rules = queryRulesFromDatabase(dimension);
            logger.info("[规则查询] 从数据库查询到 {} 条规则", rules.size());

            // 转换为树状结构
            List<Map<String, Object>> treeData = convertToTreeStructure(dimension, rules);
            logger.info("[规则查询] 转换后的树状结构包含 {} 个节点", treeData.size());

            return AjaxResult.success(treeData);
        } catch (Exception e) {
            logger.error("[规则查询] 获取规则树失败", e);
            return AjaxResult.error("获取规则树失败: " + e.getMessage());
        }
    }

    /**
     * 从数据库查询规则
     */
    private List<Map<String, Object>> queryRulesFromDatabase(String dimension) {
        Map<String, Object> params = new HashMap<>();
        params.put("dimension", dimension);

        List<Map<String, Object>> results = sqlSession.selectList(
            "com.ruoyi.evaluation.mapper.EvaluationRuleMapper.selectRulesByDimension",
            params
        );

        logger.info("[规则查询] SQL查询结果: {} 条记录", results.size());
        for (Map<String, Object> rule : results) {
            logger.info("  - ID: {}, category: {}, itemName: {}, level: {}, score: {}",
                rule.get("id"), rule.get("category"), rule.get("item_name"),
                rule.get("level"), rule.get("score"));
        }

        return results;
    }

    /**
     * 转换为树状结构
     */
    private List<Map<String, Object>> convertToTreeStructure(String dimension, List<Map<String, Object>> rules) {
        List<Map<String, Object>> result = new ArrayList<>();

        if (rules.isEmpty()) {
            logger.warn("[规则查询] 没有找到任何规则，返回空列表");
            return result;
        }

        // 按 category 分组
        Map<String, List<Map<String, Object>>> categoryMap = rules.stream()
            .collect(Collectors.groupingBy(rule -> (String) rule.get("category")));

        logger.info("[规则查询] 按类别分组: {}", categoryMap.keySet());

        // 构建维度节点
        Map<String, Object> dimensionNode = new HashMap<>();
        dimensionNode.put("dimension", dimension);
        dimensionNode.put("dimensionName", getDimensionName(dimension));

        List<Map<String, Object>> categories = new ArrayList<>();

        // 遍历每个类别
        for (Map.Entry<String, List<Map<String, Object>>> entry : categoryMap.entrySet()) {
            String category = entry.getKey();
            List<Map<String, Object>> categoryRules = entry.getValue();

            Map<String, Object> categoryNode = new HashMap<>();
            categoryNode.put("category", category);

            // 按 item_name 分组
            Map<String, List<Map<String, Object>>> itemMap = categoryRules.stream()
                .collect(Collectors.groupingBy(rule -> (String) rule.get("item_name")));

            List<Map<String, Object>> items = new ArrayList<>();

            // 遍历每个项目
            for (Map.Entry<String, List<Map<String, Object>>> itemEntry : itemMap.entrySet()) {
                String itemName = itemEntry.getKey();
                List<Map<String, Object>> itemRules = itemEntry.getValue();

                Map<String, Object> itemNode = new HashMap<>();
                itemNode.put("itemName", itemName);

                // 构建等级列表
                List<Map<String, Object>> levels = new ArrayList<>();
                for (Map<String, Object> rule : itemRules) {
                    Map<String, Object> levelNode = new HashMap<>();
                    levelNode.put("id", rule.get("id"));
                    levelNode.put("level", rule.get("level"));
                    levelNode.put("score", rule.get("score"));
                    levelNode.put("description", rule.get("description"));
                    levelNode.put("requireAttachment", rule.get("require_attachment"));
                    levelNode.put("attachmentTypes", rule.get("attachment_types"));
                    levelNode.put("category", category);
                    levelNode.put("itemName", itemName);
                    levelNode.put("dimension", dimension);
                    levelNode.put("dimensionType", getDimensionType(dimension));
                    levels.add(levelNode);
                }

                itemNode.put("levels", levels);
                items.add(itemNode);
            }

            categoryNode.put("items", items);
            categories.add(categoryNode);
        }

        dimensionNode.put("categories", categories);
        result.add(dimensionNode);

        return result;
    }

    /**
     * 获取维度名称
     */
    private String getDimensionName(String dimension) {
        Map<String, String> nameMap = new HashMap<>();
        nameMap.put("moral", "德育");
        nameMap.put("intellectual", "智育");
        nameMap.put("physical", "体育");
        nameMap.put("aesthetic", "美育");
        nameMap.put("labor", "劳育");
        return nameMap.getOrDefault(dimension, dimension);
    }

    /**
     * 获取维度类型（数字）
     */
    private int getDimensionType(String dimension) {
        Map<String, Integer> typeMap = new HashMap<>();
        typeMap.put("moral", 2);
        typeMap.put("intellectual", 1);
        typeMap.put("physical", 3);
        typeMap.put("aesthetic", 4);
        typeMap.put("labor", 5);
        return typeMap.getOrDefault(dimension, 0);
    }
}