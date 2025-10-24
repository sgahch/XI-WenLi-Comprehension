package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import org.springframework.web.multipart.MultipartFile;

/**
 * 学期成绩明细Service接口
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public interface ITSemesterScoreDetailService 
{
    /**
     * 查询学期成绩明细
     * 
     * @param id 学期成绩明细主键
     * @return 学期成绩明细
     */
    public TSemesterScoreDetail selectTSemesterScoreDetailById(Long id);

    /**
     * 查询学期成绩明细列表
     * 
     * @param tSemesterScoreDetail 学期成绩明细
     * @return 学期成绩明细集合
     */
    public List<TSemesterScoreDetail> selectTSemesterScoreDetailList(TSemesterScoreDetail tSemesterScoreDetail);

    /**
     * 根据学号和学期查询成绩明细
     * 
     * @param studentId 学号
     * @param academicYear 学年
     * @param semester 学期
     * @return 学期成绩明细
     */
    public TSemesterScoreDetail selectByStudentAndSemester(String studentId, String academicYear, String semester);

    /**
     * 根据班级和学期查询成绩列表
     * 
     * @param classId 班级ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 成绩列表
     */
    public List<TSemesterScoreDetail> selectByClassAndSemester(String classId, String academicYear, String semester);

    /**
     * 根据专业和学期查询成绩列表
     * 
     * @param majorId 专业ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 成绩列表
     */
    public List<TSemesterScoreDetail> selectByMajorAndSemester(String majorId, String academicYear, String semester);

    /**
     * 计算并更新班级排名
     * 
     * @param classId 班级ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 更新结果
     */
    public boolean calculateClassRanking(String classId, String academicYear, String semester);

    /**
     * 计算并更新专业排名
     * 
     * @param majorId 专业ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 更新结果
     */
    public boolean calculateMajorRanking(String majorId, String academicYear, String semester);

    /**
     * 批量导入成绩数据
     * 
     * @param file Excel文件
     * @param updateSupport 是否更新支持，如果已存在，则进行更新数据
     * @return 导入结果信息
     */
    public String importScoreData(MultipartFile file, Boolean updateSupport) throws Exception;

    /**
     * 获取班级成绩统计
     * 
     * @param classId 班级ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 统计数据
     */
    public Map<String, Object> getClassScoreStatistics(String classId, String academicYear, String semester);

    /**
     * 获取专业成绩统计
     * 
     * @param majorId 专业ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 统计数据
     */
    public Map<String, Object> getMajorScoreStatistics(String majorId, String academicYear, String semester);

    /**
     * 计算综合成绩
     * 
     * @param tSemesterScoreDetail 成绩明细
     * @return 计算后的综合成绩
     */
    public TSemesterScoreDetail calculateComprehensiveScore(TSemesterScoreDetail tSemesterScoreDetail);

    /**
     * 验证成绩数据
     * 
     * @param tSemesterScoreDetail 成绩明细
     * @return 验证结果
     */
    public String validateScoreData(TSemesterScoreDetail tSemesterScoreDetail);

    /**
     * 新增学期成绩明细
     * 
     * @param tSemesterScoreDetail 学期成绩明细
     * @return 结果
     */
    public int insertTSemesterScoreDetail(TSemesterScoreDetail tSemesterScoreDetail);

    /**
     * 修改学期成绩明细
     * 
     * @param tSemesterScoreDetail 学期成绩明细
     * @return 结果
     */
    public int updateTSemesterScoreDetail(TSemesterScoreDetail tSemesterScoreDetail);

    /**
     * 批量删除学期成绩明细
     * 
     * @param ids 需要删除的学期成绩明细主键集合
     * @return 结果
     */
    public int deleteTSemesterScoreDetailByIds(Long[] ids);

    /**
     * 删除学期成绩明细信息
     * 
     * @param id 学期成绩明细主键
     * @return 结果
     */
    public int deleteTSemesterScoreDetailById(Long id);
}