package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.TEvaluationItemConfig;
import com.ruoyi.system.mapper.TEvaluationItemConfigMapper;
import com.ruoyi.system.service.ITEvaluationItemConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TEvaluationItemConfigServiceImpl implements ITEvaluationItemConfigService {

    @Autowired
    private TEvaluationItemConfigMapper itemConfigMapper;

    @Override
    public TEvaluationItemConfig selectTEvaluationItemConfigById(Long id) {
        return itemConfigMapper.selectTEvaluationItemConfigById(id);
    }

    @Override
    public List<TEvaluationItemConfig> selectTEvaluationItemConfigList(TEvaluationItemConfig config) {
        return itemConfigMapper.selectTEvaluationItemConfigList(config);
    }

    @Override
    public int insertTEvaluationItemConfig(TEvaluationItemConfig config) {
        return itemConfigMapper.insertTEvaluationItemConfig(config);
    }

    @Override
    public int updateTEvaluationItemConfig(TEvaluationItemConfig config) {
        return itemConfigMapper.updateTEvaluationItemConfig(config);
    }

    @Override
    public int deleteTEvaluationItemConfigById(Long id) {
        return itemConfigMapper.deleteTEvaluationItemConfigById(id);
    }

    @Override
    public int deleteTEvaluationItemConfigByIds(Long[] ids) {
        return itemConfigMapper.deleteTEvaluationItemConfigByIds(ids);
    }

    @Override
    public List<TEvaluationItemConfig> selectByDimensionType(Integer dimensionType) {
        return itemConfigMapper.selectByDimensionType(dimensionType);
    }

    @Override
    public List<TEvaluationItemConfig> selectActiveDimensionItems(Integer dimensionType) {
        return itemConfigMapper.selectByDimensionTypeAndStatus(dimensionType, 1);
    }

    @Override
    public TEvaluationItemConfig selectByItemCode(String itemCode) {
        return itemConfigMapper.selectByItemCode(itemCode);
    }

    @Override
    public String checkItemCodeUnique(TEvaluationItemConfig config) {
        TEvaluationItemConfig exist = itemConfigMapper.selectByItemCode(config.getItemCode());
        if (exist == null) {
            return "0"; // unique
        }
        Long id = config.getId();
        return (id != null && id.equals(exist.getId())) ? "0" : "1"; // 1 means not unique
    }

    @Override
    public boolean batchUpdateStatus(Long[] ids, Integer isActive) {
        return itemConfigMapper.batchUpdateStatus(ids, isActive) > 0;
    }

    @Override
    public Integer getNextSortOrder(Integer dimensionType) {
        Integer max = itemConfigMapper.getMaxSortOrderByDimension(dimensionType);
        return (max == null ? 0 : max) + 1;
    }
}