package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TStudentScoreDetailMapper;
import com.ruoyi.system.domain.TStudentScoreDetail;
import com.ruoyi.system.service.ITStudentScoreDetailService;

/**
 * 学生成绩明细Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
@Service
public class TStudentScoreDetailServiceImpl implements ITStudentScoreDetailService 
{
    @Autowired
    private TStudentScoreDetailMapper tStudentScoreDetailMapper;

    /**
     * 查询学生成绩明细
     * 
     * @param id 学生成绩明细主键
     * @return 学生成绩明细
     */
    @Override
    public TStudentScoreDetail selectTStudentScoreDetailById(Long id)
    {
        return tStudentScoreDetailMapper.selectTStudentScoreDetailById(id);
    }

    /**
     * 查询学生成绩明细列表
     * 
     * @param tStudentScoreDetail 学生成绩明细
     * @return 学生成绩明细
     */
    @Override
    public List<TStudentScoreDetail> selectTStudentScoreDetailList(TStudentScoreDetail tStudentScoreDetail)
    {
        return tStudentScoreDetailMapper.selectTStudentScoreDetailList(tStudentScoreDetail);
    }

    /**
     * 新增学生成绩明细
     * 
     * @param tStudentScoreDetail 学生成绩明细
     * @return 结果
     */
    @Override
    public int insertTStudentScoreDetail(TStudentScoreDetail tStudentScoreDetail)
    {
        tStudentScoreDetail.setCreateTime(DateUtils.getNowDate());
        return tStudentScoreDetailMapper.insertTStudentScoreDetail(tStudentScoreDetail);
    }

    /**
     * 修改学生成绩明细
     * 
     * @param tStudentScoreDetail 学生成绩明细
     * @return 结果
     */
    @Override
    public int updateTStudentScoreDetail(TStudentScoreDetail tStudentScoreDetail)
    {
        tStudentScoreDetail.setUpdateTime(DateUtils.getNowDate());
        return tStudentScoreDetailMapper.updateTStudentScoreDetail(tStudentScoreDetail);
    }

    /**
     * 批量删除学生成绩明细
     * 
     * @param ids 需要删除的学生成绩明细主键
     * @return 结果
     */
    @Override
    public int deleteTStudentScoreDetailByIds(Long[] ids)
    {
        return tStudentScoreDetailMapper.deleteTStudentScoreDetailByIds(ids);
    }

    /**
     * 删除学生成绩明细信息
     * 
     * @param id 学生成绩明细主键
     * @return 结果
     */
    @Override
    public int deleteTStudentScoreDetailById(Long id)
    {
        return tStudentScoreDetailMapper.deleteTStudentScoreDetailById(id);
    }
}
