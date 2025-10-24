package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.TEvaluationItemConfig;

/**
 * 综测评分项目配置Mapper接口
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public interface TEvaluationItemConfigMapper 
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
    public List<TEvaluationItemConfig> selectByDimensionType(@Param("dimensionType") Integer dimensionType);

    /**
     * 根据维度类型和状态查询评分项目配置
     * 
     * @param dimensionType 维度类型
     * @param isActive 是否启用（0否，1是）
     * @return 评分项目配置集合
     */
    public List<TEvaluationItemConfig> selectByDimensionTypeAndStatus(@Param("dimensionType") Integer dimensionType, 
                                                                     @Param("isActive") Integer isActive);

    /**
     * 根据项目编码查询配置
     * 
     * @param itemCode 项目编码
     * @return 评分项目配置
     */
    public TEvaluationItemConfig selectByItemCode(@Param("itemCode") String itemCode);

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
     * 删除综测评分项目配置
     * 
     * @param id 综测评分项目配置主键
     * @return 结果
     */
    public int deleteTEvaluationItemConfigById(Long id);

    /**
     * 批量删除综测评分项目配置
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTEvaluationItemConfigByIds(Long[] ids);

    /**
     * 批量更新项目状态
     * 
     * @param ids 项目ID集合
     * @param isActive 状态值
     * @return 更新结果
     */
    public int batchUpdateStatus(@Param("ids") Long[] ids, @Param("isActive") Integer isActive);

    /**
     * 获取指定维度的最大排序号
     * 
     * @param dimensionType 维度类型
     * @return 最大排序号
     */
    public Integer getMaxSortOrderByDimension(@Param("dimensionType") Integer dimensionType);
}