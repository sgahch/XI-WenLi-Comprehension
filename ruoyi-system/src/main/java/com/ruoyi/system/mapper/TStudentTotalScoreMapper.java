package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TStudentTotalScore;

/**
 * 学生总成绩Mapper接口
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
public interface TStudentTotalScoreMapper 
{
    /**
     * 查询学生总成绩
     * 
     * @param id 学生总成绩主键
     * @return 学生总成绩
     */
    public TStudentTotalScore selectTStudentTotalScoreById(Long id);

    /**
     * 查询学生总成绩列表
     * 
     * @param tStudentTotalScore 学生总成绩
     * @return 学生总成绩集合
     */
    public List<TStudentTotalScore> selectTStudentTotalScoreList(TStudentTotalScore tStudentTotalScore);

    /**
     * 新增学生总成绩
     * 
     * @param tStudentTotalScore 学生总成绩
     * @return 结果
     */
    public int insertTStudentTotalScore(TStudentTotalScore tStudentTotalScore);

    /**
     * 修改学生总成绩
     * 
     * @param tStudentTotalScore 学生总成绩
     * @return 结果
     */
    public int updateTStudentTotalScore(TStudentTotalScore tStudentTotalScore);

    /**
     * 删除学生总成绩
     * 
     * @param id 学生总成绩主键
     * @return 结果
     */
    public int deleteTStudentTotalScoreById(Long id);

    /**
     * 批量删除学生总成绩
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTStudentTotalScoreByIds(Long[] ids);
}
