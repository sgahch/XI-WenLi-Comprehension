package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TScoreRecordMapper;
import com.ruoyi.system.domain.TScoreRecord;
import com.ruoyi.system.service.ITScoreRecordService;

/**
 * 考评加分记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-09-28
 */
@Service
public class TScoreRecordServiceImpl implements ITScoreRecordService 
{
    @Autowired
    private TScoreRecordMapper tScoreRecordMapper;

    /**
     * 查询考评加分记录
     * 
     * @param id 考评加分记录主键
     * @return 考评加分记录
     */
    @Override
    public TScoreRecord selectTScoreRecordById(Long id)
    {
        return tScoreRecordMapper.selectTScoreRecordById(id);
    }

    /**
     * 查询考评加分记录列表
     * 
     * @param tScoreRecord 考评加分记录
     * @return 考评加分记录
     */
    @Override
    public List<TScoreRecord> selectTScoreRecordList(TScoreRecord tScoreRecord)
    {
        return tScoreRecordMapper.selectTScoreRecordList(tScoreRecord);
    }

    /**
     * 新增考评加分记录
     * 
     * @param tScoreRecord 考评加分记录
     * @return 结果
     */
    @Override
    public int insertTScoreRecord(TScoreRecord tScoreRecord)
    {
        return tScoreRecordMapper.insertTScoreRecord(tScoreRecord);
    }

    /**
     * 修改考评加分记录
     * 
     * @param tScoreRecord 考评加分记录
     * @return 结果
     */
    @Override
    public int updateTScoreRecord(TScoreRecord tScoreRecord)
    {
        tScoreRecord.setUpdateTime(DateUtils.getNowDate());
        return tScoreRecordMapper.updateTScoreRecord(tScoreRecord);
    }

    /**
     * 批量删除考评加分记录
     * 
     * @param ids 需要删除的考评加分记录主键
     * @return 结果
     */
    @Override
    public int deleteTScoreRecordByIds(Long[] ids)
    {
        return tScoreRecordMapper.deleteTScoreRecordByIds(ids);
    }

    /**
     * 删除考评加分记录信息
     * 
     * @param id 考评加分记录主键
     * @return 结果
     */
    @Override
    public int deleteTScoreRecordById(Long id)
    {
        return tScoreRecordMapper.deleteTScoreRecordById(id);
    }
}
