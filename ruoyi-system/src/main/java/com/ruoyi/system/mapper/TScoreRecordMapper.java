package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TScoreRecord;

/**
 * 考评加分记录Mapper接口
 * 
 * @author ruoyi
 * @date 2025-09-28
 */
public interface TScoreRecordMapper 
{
    /**
     * 查询考评加分记录
     * 
     * @param id 考评加分记录主键
     * @return 考评加分记录
     */
    public TScoreRecord selectTScoreRecordById(Long id);

    /**
     * 查询考评加分记录列表
     * 
     * @param tScoreRecord 考评加分记录
     * @return 考评加分记录集合
     */
    public List<TScoreRecord> selectTScoreRecordList(TScoreRecord tScoreRecord);

    /**
     * 新增考评加分记录
     * 
     * @param tScoreRecord 考评加分记录
     * @return 结果
     */
    public int insertTScoreRecord(TScoreRecord tScoreRecord);

    /**
     * 修改考评加分记录
     * 
     * @param tScoreRecord 考评加分记录
     * @return 结果
     */
    public int updateTScoreRecord(TScoreRecord tScoreRecord);

    /**
     * 删除考评加分记录
     * 
     * @param id 考评加分记录主键
     * @return 结果
     */
    public int deleteTScoreRecordById(Long id);

    /**
     * 批量删除考评加分记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTScoreRecordByIds(Long[] ids);
}
