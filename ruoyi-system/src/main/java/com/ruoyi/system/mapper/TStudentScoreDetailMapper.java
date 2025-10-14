package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TStudentScoreDetail;

/**
 * 学生成绩明细Mapper接口
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
public interface TStudentScoreDetailMapper 
{
    /**
     * 查询学生成绩明细
     * 
     * @param id 学生成绩明细主键
     * @return 学生成绩明细
     */
    public TStudentScoreDetail selectTStudentScoreDetailById(Long id);

    /**
     * 查询学生成绩明细列表
     * 
     * @param tStudentScoreDetail 学生成绩明细
     * @return 学生成绩明细集合
     */
    public List<TStudentScoreDetail> selectTStudentScoreDetailList(TStudentScoreDetail tStudentScoreDetail);

    /**
     * 新增学生成绩明细
     * 
     * @param tStudentScoreDetail 学生成绩明细
     * @return 结果
     */
    public int insertTStudentScoreDetail(TStudentScoreDetail tStudentScoreDetail);

    /**
     * 修改学生成绩明细
     * 
     * @param tStudentScoreDetail 学生成绩明细
     * @return 结果
     */
    public int updateTStudentScoreDetail(TStudentScoreDetail tStudentScoreDetail);

    /**
     * 删除学生成绩明细
     * 
     * @param id 学生成绩明细主键
     * @return 结果
     */
    public int deleteTStudentScoreDetailById(Long id);

    /**
     * 批量删除学生成绩明细
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTStudentScoreDetailByIds(Long[] ids);
}
