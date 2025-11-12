package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.TSemesterScoreDetail;

/**
 * 学期成绩明细Mapper接口
 * 
 * @author ynchen
 * @date 2024-12-23
 */
public interface TSemesterScoreDetailMapper 
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
    public TSemesterScoreDetail selectByStudentAndSemester(@Param("studentId") String studentId, 
                                                          @Param("academicYear") String academicYear, 
                                                          @Param("semester") String semester);

    /**
     * 根据班级和学期查询成绩列表
     * 
     * @param classId 班级ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 成绩列表
     */
    public List<TSemesterScoreDetail> selectByClassAndSemester(@Param("classId") String classId, 
                                                              @Param("academicYear") String academicYear, 
                                                              @Param("semester") String semester);

    /**
     * 根据专业和学期查询成绩列表
     * 
     * @param majorId 专业ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 成绩列表
     */
    public List<TSemesterScoreDetail> selectByMajorAndSemester(@Param("majorId") String majorId, 
                                                              @Param("academicYear") String academicYear, 
                                                              @Param("semester") String semester);

    /**
     * 计算班级排名
     * 
     * @param classId 班级ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 更新记录数
     */
    public int updateClassRanking(@Param("classId") String classId, 
                                 @Param("academicYear") String academicYear, 
                                 @Param("semester") String semester);

    /**
     * 计算专业排名
     * 
     * @param majorId 专业ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 更新记录数
     */
    public int updateMajorRanking(@Param("majorId") String majorId, 
                                 @Param("academicYear") String academicYear, 
                                 @Param("semester") String semester);

    /**
     * 批量插入成绩明细
     * 
     * @param scoreDetailList 成绩明细列表
     * @return 插入记录数
     */
    public int batchInsertTSemesterScoreDetail(List<TSemesterScoreDetail> scoreDetailList);

    /**
     * 获取班级成绩统计
     *
     * @param className 班级名称
     * @param academicYear 学年
     * @param semester 学期
     * @return 统计数据
     */
    public Map<String, Object> getClassScoreStatistics(@Param("className") String className,
                                                      @Param("academicYear") String academicYear,
                                                      @Param("semester") String semester);

    /**
     * 获取专业成绩统计
     *
     * @param majorName 专业名称
     * @param academicYear 学年
     * @param semester 学期
     * @return 统计数据
     */
    public Map<String, Object> getMajorScoreStatistics(@Param("majorName") String majorName,
                                                       @Param("academicYear") String academicYear,
                                                       @Param("semester") String semester);

    /**
     * 获取班级排行榜
     *
     * @param className 班级名称
     * @param academicYear 学年
     * @param semester 学期
     * @return 排行榜列表
     */
    public List<TSemesterScoreDetail> getClassRanking(@Param("className") String className,
                                                      @Param("academicYear") String academicYear,
                                                      @Param("semester") String semester);

    /**
     * 获取专业排行榜
     *
     * @param majorName 专业名称
     * @param academicYear 学年
     * @param semester 学期
     * @return 排行榜列表
     */
    public List<TSemesterScoreDetail> getMajorRanking(@Param("majorName") String majorName,
                                                      @Param("academicYear") String academicYear,
                                                      @Param("semester") String semester);

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
     * 删除学期成绩明细
     * 
     * @param id 学期成绩明细主键
     * @return 结果
     */
    public int deleteTSemesterScoreDetailById(Long id);

    /**
     * 批量删除学期成绩明细
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTSemesterScoreDetailByIds(Long[] ids);
}