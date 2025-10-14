package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TStudentTotalScoreMapper;
import com.ruoyi.system.domain.TStudentTotalScore;
import com.ruoyi.system.service.ITStudentTotalScoreService;

/**
 * 学生总成绩Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
@Service
public class TStudentTotalScoreServiceImpl implements ITStudentTotalScoreService 
{
    @Autowired
    private TStudentTotalScoreMapper tStudentTotalScoreMapper;

    /**
     * 查询学生总成绩
     * 
     * @param id 学生总成绩主键
     * @return 学生总成绩
     */
    @Override
    public TStudentTotalScore selectTStudentTotalScoreById(Long id)
    {
        return tStudentTotalScoreMapper.selectTStudentTotalScoreById(id);
    }

    /**
     * 查询学生总成绩列表
     * 
     * @param tStudentTotalScore 学生总成绩
     * @return 学生总成绩
     */
    @Override
    public List<TStudentTotalScore> selectTStudentTotalScoreList(TStudentTotalScore tStudentTotalScore)
    {
        return tStudentTotalScoreMapper.selectTStudentTotalScoreList(tStudentTotalScore);
    }

    /**
     * 新增学生总成绩
     * 
     * @param tStudentTotalScore 学生总成绩
     * @return 结果
     */
    @Override
    public int insertTStudentTotalScore(TStudentTotalScore tStudentTotalScore)
    {
        tStudentTotalScore.setCreateTime(DateUtils.getNowDate());
        return tStudentTotalScoreMapper.insertTStudentTotalScore(tStudentTotalScore);
    }

    /**
     * 修改学生总成绩
     * 
     * @param tStudentTotalScore 学生总成绩
     * @return 结果
     */
    @Override
    public int updateTStudentTotalScore(TStudentTotalScore tStudentTotalScore)
    {
        tStudentTotalScore.setUpdateTime(DateUtils.getNowDate());
        return tStudentTotalScoreMapper.updateTStudentTotalScore(tStudentTotalScore);
    }

    /**
     * 批量删除学生总成绩
     * 
     * @param ids 需要删除的学生总成绩主键
     * @return 结果
     */
    @Override
    public int deleteTStudentTotalScoreByIds(Long[] ids)
    {
        return tStudentTotalScoreMapper.deleteTStudentTotalScoreByIds(ids);
    }

    /**
     * 删除学生总成绩信息
     * 
     * @param id 学生总成绩主键
     * @return 结果
     */
    @Override
    public int deleteTStudentTotalScoreById(Long id)
    {
        return tStudentTotalScoreMapper.deleteTStudentTotalScoreById(id);
    }
}
