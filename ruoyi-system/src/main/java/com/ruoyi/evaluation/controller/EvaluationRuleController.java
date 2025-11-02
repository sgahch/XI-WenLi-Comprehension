package com.ruoyi.evaluation.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    /**
     * 获取树状结构的计分规则 (用于前端级联选择器)
     */
    @GetMapping("/tree")
    public AjaxResult getRuleTree(@RequestParam("dimension") String dimension)
    {
        try {
            logger.info("接收到获取规则树的请求，维度: {}", dimension);
            
            // TODO: 这里应该调用Service层获取真实数据
            // List<RuleTreeVo> tree = ruleService.selectRuleTreeByDimension(dimension);
            
            // 临时返回模拟数据，避免前端404错误
            List<Map<String, Object>> mockData = createMockRuleTree(dimension);
            
            return AjaxResult.success(mockData);
        } catch (Exception e) {
            logger.error("获取规则树失败", e);
            return AjaxResult.error("获取规则树失败: " + e.getMessage());
        }
    }
    
    /**
     * 创建模拟的规则树数据
     * 这是临时方法，后续需要替换为真实的数据库查询
     */
    private List<Map<String, Object>> createMockRuleTree(String dimension) {
        List<Map<String, Object>> result = new ArrayList<>();
        
        // 根据维度创建不同的模拟数据
        switch (dimension) {
            case "moral":
                result.add(createDimensionData("德育", "moral", new String[][]{
                    {"思想政治", "党团活动", "优秀", "良好", "一般"},
                    {"社会实践", "志愿服务", "优秀", "良好", "一般"},
                    {"品德修养", "诚信表现", "优秀", "良好", "一般"}
                }));
                break;
            case "intellectual":
                result.add(createDimensionData("智育", "intellectual", new String[][]{
                    {"学业成绩", "课程成绩", "优秀", "良好", "一般"},
                    {"学术竞赛", "学科竞赛", "国家级", "省级", "校级"},
                    {"科研创新", "科研项目", "主持", "参与", "其他"}
                }));
                break;
            case "physical":
                result.add(createDimensionData("体育", "physical", new String[][]{
                    {"体育成绩", "体测成绩", "优秀", "良好", "及格"},
                    {"体育竞赛", "运动比赛", "国家级", "省级", "校级"},
                    {"体育活动", "体育社团", "主要负责人", "积极参与", "一般参与"}
                }));
                break;
            case "aesthetic":
                result.add(createDimensionData("美育", "aesthetic", new String[][]{
                    {"艺术素养", "艺术课程", "优秀", "良好", "一般"},
                    {"艺术竞赛", "艺术比赛", "国家级", "省级", "校级"},
                    {"艺术活动", "文艺演出", "主要演员", "参与演出", "观众"}
                }));
                break;
            case "labor":
                result.add(createDimensionData("劳育", "labor", new String[][]{
                    {"劳动实践", "劳动课程", "优秀", "良好", "一般"},
                    {"社会服务", "公益劳动", "组织者", "积极参与", "一般参与"},
                    {"生活技能", "生活自理", "优秀", "良好", "一般"}
                }));
                break;
            default:
                // 返回空数据
                break;
        }
        
        return result;
    }
    
    /**
     * 创建维度数据结构
     */
    private Map<String, Object> createDimensionData(String dimensionName, String dimension, String[][] categories) {
        Map<String, Object> dimensionData = new HashMap<>();
        dimensionData.put("dimension", dimension);
        dimensionData.put("dimensionName", dimensionName);
        
        List<Map<String, Object>> categoryList = new ArrayList<>();
        
        for (String[] categoryInfo : categories) {
            Map<String, Object> category = new HashMap<>();
            category.put("category", categoryInfo[0]);
            
            List<Map<String, Object>> items = new ArrayList<>();
            Map<String, Object> item = new HashMap<>();
            item.put("itemName", categoryInfo[1]);
            
            List<Map<String, Object>> levels = new ArrayList<>();
            for (int i = 2; i < categoryInfo.length; i++) {
                Map<String, Object> level = new HashMap<>();
                level.put("id", dimension + "_" + categoryInfo[0] + "_" + categoryInfo[1] + "_" + i);
                level.put("level", categoryInfo[i]);
                level.put("score", (categoryInfo.length - i) * 2); // 简单的分数计算
                level.put("requireAttachment", i == 2); // 最高等级需要附件
                level.put("attachmentTypes", new String[]{"PDF", "JPG", "PNG", "DOC", "DOCX"});
                levels.add(level);
            }
            
            item.put("levels", levels);
            items.add(item);
            category.put("items", items);
            categoryList.add(category);
        }
        
        dimensionData.put("categories", categoryList);
        return dimensionData;
    }
}