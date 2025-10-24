package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TEvaluationItemConfig;

/**
 * 综测评分项目配置Service接口
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public interface ITEvaluationItemConfigService 
{
    /**
     * 查询综测评分项目配置
     * 
     * @param id 综测评分项目配置主键
     * @return 综测评分项目配置
     */
    public TEvaluationItemConfig selectTEvaluationItemConfigById(Long id);

    /**
     * 查询综测评分项目配置列表
     * 
     * @param tEvaluationItemConfig 综测评分项目配置
     * @return 综测评分项目配置集合
     */
    public List<TEvaluationItemConfig> selectTEvaluationItemConfigList(TEvaluationItemConfig tEvaluationItemConfig);

    /**
     * 根据维度类型查询评分项目配置
     * 
     * @param dimensionType 维度类型（1智育，2德育，3体育，4美育，5劳育）
     * @return 评分项目配置集合
     */
    public List<TEvaluationItemConfig> selectByDimensionType(Integer dimensionType);

    /**
     * 根据维度类型查询启用的评分项目配置
     * 
     * @param dimensionType 维度类型
     * @return 启用的评分项目配置集合
     */
    public List<TEvaluationItemConfig> selectActiveDimensionItems(Integer dimensionType);

    /**
     * 根据项目编码查询配置
     * 
     * @param itemCode 项目编码
     * @return 评分项目配置
     */
    public TEvaluationItemConfig selectByItemCode(String itemCode);

    /**
     * 验证项目编码是否唯一
     * 
     * @param tEvaluationItemConfig 评分项目配置
     * @return 验证结果
     */
    public String checkItemCodeUnique(TEvaluationItemConfig tEvaluationItemConfig);

    /**
     * 批量更新项目状态
     * 
     * @param ids 项目ID集合
     * @param isActive 状态值
     * @return 更新结果
     */
    public boolean batchUpdateStatus(Long[] ids, Integer isActive);

    /**
     * 获取指定维度的下一个排序号
     * 
     * @param dimensionType 维度类型
     * @return 下一个排序号
     */
    public Integer getNextSortOrder(Integer dimensionType);

    /**
     * 新增综测评分项目配置
     * 
     * @param tEvaluationItemConfig 综测评分项目配置
     * @return 结果
     */
    public int insertTEvaluationItemConfig(TEvaluationItemConfig tEvaluationItemConfig);

    /**
     * 修改综测评分项目配置
     * 
     * @param tEvaluationItemConfig 综测评分项目配置
     * @return 结果
     */
    public int updateTEvaluationItemConfig(TEvaluationItemConfig tEvaluationItemConfig);

    /**
     * 批量删除综测评分项目配置
     * 
     * @param ids 需要删除的综测评分项目配置主键集合
     * @return 结果
     */
    public int deleteTEvaluationItemConfigByIds(Long[] ids);

    /**
     * 删除综测评分项目配置信息
     * 
     * @param id 综测评分项目配置主键
     * @return 结果
     */
    public int deleteTEvaluationItemConfigById(Long id);
}