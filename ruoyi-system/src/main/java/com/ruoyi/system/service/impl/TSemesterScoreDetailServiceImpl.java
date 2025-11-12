package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;
import java.util.Date;
import java.io.InputStream;
import java.util.ArrayList;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.TEvaluationItemConfig;
import com.ruoyi.system.mapper.TEvaluationItemConfigMapper;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.system.mapper.TSemesterScoreDetailMapper;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import com.ruoyi.system.service.ITSemesterScoreDetailService;
import com.alibaba.fastjson2.JSON;

/**
 * 学期成绩明细Service业务层处理
 * 
 * @author ynchen
 * @date 2024-12-23
 */
@Service
public class TSemesterScoreDetailServiceImpl implements ITSemesterScoreDetailService 
{
    @Autowired
    private TSemesterScoreDetailMapper tSemesterScoreDetailMapper;

    @Autowired
    private TEvaluationItemConfigMapper tEvaluationItemConfigMapper;

    /**
     * 查询学期成绩明细
     * 
     * @param id 学期成绩明细主键
     * @return 学期成绩明细
     */
    @Override
    public TSemesterScoreDetail selectTSemesterScoreDetailById(Long id)
    {
        return tSemesterScoreDetailMapper.selectTSemesterScoreDetailById(id);
    }

    /**
     * 查询学期成绩明细列表
     * 
     * @param tSemesterScoreDetail 学期成绩明细
     * @return 学期成绩明细
     */
    @Override
    public List<TSemesterScoreDetail> selectTSemesterScoreDetailList(TSemesterScoreDetail tSemesterScoreDetail)
    {
        return tSemesterScoreDetailMapper.selectTSemesterScoreDetailList(tSemesterScoreDetail);
    }

    /**
     * 根据学号和学期查询成绩明细
     */
    @Override
    public TSemesterScoreDetail selectByStudentAndSemester(String studentId, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.selectByStudentAndSemester(studentId, academicYear, semester);
    }

    /**
     * 根据班级和学期查询成绩列表
     */
    @Override
    public List<TSemesterScoreDetail> selectByClassAndSemester(String classId, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.selectByClassAndSemester(classId, academicYear, semester);
    }

    /**
     * 根据专业和学期查询成绩列表
     */
    @Override
    public List<TSemesterScoreDetail> selectByMajorAndSemester(String majorId, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.selectByMajorAndSemester(majorId, academicYear, semester);
    }

    /**
     * 计算并更新班级排名
     */
    @Override
    public boolean calculateClassRanking(String classId, String academicYear, String semester)
    {
        try {
            int result = tSemesterScoreDetailMapper.updateClassRanking(classId, academicYear, semester);
            return result > 0;
        } catch (Exception e) {
            throw new ServiceException("计算班级排名失败：" + e.getMessage());
        }
    }

    /**
     * 计算并更新专业排名
     */
    @Override
    public boolean calculateMajorRanking(String majorId, String academicYear, String semester)
    {
        try {
            int result = tSemesterScoreDetailMapper.updateMajorRanking(majorId, academicYear, semester);
            return result > 0;
        } catch (Exception e) {
            throw new ServiceException("计算专业排名失败：" + e.getMessage());
        }
    }

    /**
     * 批量导入成绩数据
     */
    @Override
    public String importScoreData(MultipartFile file, Boolean updateSupport) throws Exception
    {
        if (StringUtils.isNull(file) || file.getSize() == 0)
        {
            throw new ServiceException("导入文件不能为空");
        }

        InputStream is = file.getInputStream();
        Workbook workbook = new XSSFWorkbook(is);
        Sheet sheet = workbook.getSheetAt(0);

        List<TSemesterScoreDetail> scoreDetailList = new ArrayList<>();
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();

        // 从第3行开始读取数据（假设前两行是表头）
        for (int i = 2; i <= sheet.getLastRowNum(); i++)
        {
            Row row = sheet.getRow(i);
            if (row == null) continue;

            try
            {
                TSemesterScoreDetail scoreDetail = parseRowToScoreDetail(row);
                
                // 验证数据
                String validateResult = validateScoreData(scoreDetail);
                if (StringUtils.isNotEmpty(validateResult))
                {
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("、第").append(i + 1).append("行：").append(validateResult);
                    continue;
                }

                // 计算综合成绩
                scoreDetail = calculateComprehensiveScore(scoreDetail);

                // 检查是否已存在
                TSemesterScoreDetail existingRecord = selectByStudentAndSemester(
                    scoreDetail.getStudentId(), 
                    scoreDetail.getAcademicYear(), 
                    String.valueOf(scoreDetail.getSemester())
                );

                if (StringUtils.isNull(existingRecord))
                {
                    scoreDetailList.add(scoreDetail);
                    successNum++;
                }
                else if (updateSupport)
                {
                    scoreDetail.setId(existingRecord.getId());
                    updateTSemesterScoreDetail(scoreDetail);
                    successNum++;
                }
                else
                {
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("、第").append(i + 1).append("行：学生").append(scoreDetail.getStudentName()).append("在该学期的成绩已存在");
                }
            }
            catch (Exception e)
            {
                failureNum++;
                failureMsg.append("<br/>").append(failureNum).append("、第").append(i + 1).append("行：").append(e.getMessage());
            }
        }

        if (!scoreDetailList.isEmpty())
        {
            tSemesterScoreDetailMapper.batchInsertTSemesterScoreDetail(scoreDetailList);
        }

        workbook.close();
        is.close();

        if (failureNum > 0)
        {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        }
        else
        {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }

        return successMsg.toString();
    }

    /**
     * 解析Excel行数据为成绩明细对象
     */
    private TSemesterScoreDetail parseRowToScoreDetail(Row row) throws Exception
    {
        TSemesterScoreDetail scoreDetail = new TSemesterScoreDetail();
        
        // 基本信息
        scoreDetail.setStudentName(getCellValue(row.getCell(0)));
        scoreDetail.setStudentId(getCellValue(row.getCell(1)));
        scoreDetail.setAcademicYear(getCellValue(row.getCell(2)));
        scoreDetail.setSemester(getIntegerValue(row.getCell(3)));
        
        // 德智体美劳成绩
        scoreDetail.setMoralScore(getBigDecimalValue(row.getCell(4)));
        scoreDetail.setIntellectualScore(getBigDecimalValue(row.getCell(5)));
        scoreDetail.setPhysicalScore(getBigDecimalValue(row.getCell(6)));
        scoreDetail.setAestheticScore(getBigDecimalValue(row.getCell(7)));
        scoreDetail.setLaborScore(getBigDecimalValue(row.getCell(8)));
        
        // 排名信息
        scoreDetail.setClassRank(getIntegerValue(row.getCell(9)));
        scoreDetail.setMajorRank(getIntegerValue(row.getCell(10)));
        
        // 班级和专业信息
        scoreDetail.setClassId(getCellValue(row.getCell(11)));
        scoreDetail.setClassName(getCellValue(row.getCell(12)));
        scoreDetail.setMajorId(getCellValue(row.getCell(13)));
        scoreDetail.setMajorName(getCellValue(row.getCell(14)));
        
        scoreDetail.setStatus(1); // 默认状态为有效
        scoreDetail.setCreateTime(new Date());
        
        return scoreDetail;
    }

    /**
     * 获取单元格字符串值
     */
    private String getCellValue(Cell cell)
    {
        if (cell == null) return "";
        
        switch (cell.getCellType())
        {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell))
                {
                    return DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD, cell.getDateCellValue());
                }
                else
                {
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            default:
                return "";
        }
    }

    /**
     * 获取单元格BigDecimal值
     */
    private BigDecimal getBigDecimalValue(Cell cell)
    {
        if (cell == null) return BigDecimal.ZERO;
        
        switch (cell.getCellType())
        {
            case NUMERIC:
                return BigDecimal.valueOf(cell.getNumericCellValue()).setScale(2, RoundingMode.HALF_UP);
            case STRING:
                String value = cell.getStringCellValue().trim();
                if (StringUtils.isEmpty(value)) return BigDecimal.ZERO;
                try {
                    return new BigDecimal(value).setScale(2, RoundingMode.HALF_UP);
                } catch (NumberFormatException e) {
                    return BigDecimal.ZERO;
                }
            default:
                return BigDecimal.ZERO;
        }
    }

    /**
     * 获取单元格Integer值
     */
    private Integer getIntegerValue(Cell cell)
    {
        if (cell == null) return 0;
        
        switch (cell.getCellType())
        {
            case NUMERIC:
                return (int) cell.getNumericCellValue();
            case STRING:
                String value = cell.getStringCellValue().trim();
                if (StringUtils.isEmpty(value)) return 0;
                try {
                    return Integer.parseInt(value);
                } catch (NumberFormatException e) {
                    return 0;
                }
            default:
                return 0;
        }
    }

    /**
     * 获取班级成绩统计
     */
    @Override
    public Map<String, Object> getClassScoreStatistics(String className, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.getClassScoreStatistics(className, academicYear, semester);
    }

    /**
     * 获取专业成绩统计
     */
    @Override
    public Map<String, Object> getMajorScoreStatistics(String majorName, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.getMajorScoreStatistics(majorName, academicYear, semester);
    }

    /**
     * 获取班级排行榜
     */
    @Override
    public List<TSemesterScoreDetail> getClassRanking(String className, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.getClassRanking(className, academicYear, semester);
    }

    /**
     * 获取专业排行榜
     */
    @Override
    public List<TSemesterScoreDetail> getMajorRanking(String majorName, String academicYear, String semester)
    {
        return tSemesterScoreDetailMapper.getMajorRanking(majorName, academicYear, semester);
    }

    /**
     * 计算综合成绩
     */
    @Override
    public TSemesterScoreDetail calculateComprehensiveScore(TSemesterScoreDetail tSemesterScoreDetail)
    {
        // 获取各维度权重配置
        BigDecimal moralWeight = BigDecimal.valueOf(0.2);  // 德育权重20%
        BigDecimal intellectualWeight = BigDecimal.valueOf(0.5);  // 智育权重50%
        BigDecimal physicalWeight = BigDecimal.valueOf(0.15);  // 体育权重15%
        BigDecimal aestheticWeight = BigDecimal.valueOf(0.1);  // 美育权重10%
        BigDecimal laborWeight = BigDecimal.valueOf(0.05);  // 劳育权重5%

        // 计算综合成绩
        BigDecimal comprehensiveScore = BigDecimal.ZERO;
        
        if (tSemesterScoreDetail.getMoralScore() != null)
        {
            comprehensiveScore = comprehensiveScore.add(tSemesterScoreDetail.getMoralScore().multiply(moralWeight));
        }
        if (tSemesterScoreDetail.getIntellectualScore() != null)
        {
            comprehensiveScore = comprehensiveScore.add(tSemesterScoreDetail.getIntellectualScore().multiply(intellectualWeight));
        }
        if (tSemesterScoreDetail.getPhysicalScore() != null)
        {
            comprehensiveScore = comprehensiveScore.add(tSemesterScoreDetail.getPhysicalScore().multiply(physicalWeight));
        }
        if (tSemesterScoreDetail.getAestheticScore() != null)
        {
            comprehensiveScore = comprehensiveScore.add(tSemesterScoreDetail.getAestheticScore().multiply(aestheticWeight));
        }
        if (tSemesterScoreDetail.getLaborScore() != null)
        {
            comprehensiveScore = comprehensiveScore.add(tSemesterScoreDetail.getLaborScore().multiply(laborWeight));
        }

        tSemesterScoreDetail.setTotalScore(comprehensiveScore.setScale(2, RoundingMode.HALF_UP));
        return tSemesterScoreDetail;
    }

    /**
     * 验证成绩数据
     */
    @Override
    public String validateScoreData(TSemesterScoreDetail tSemesterScoreDetail)
    {
        if (StringUtils.isEmpty(tSemesterScoreDetail.getStudentId()))
        {
            return "学号不能为空";
        }
        if (StringUtils.isEmpty(tSemesterScoreDetail.getStudentName()))
        {
            return "姓名不能为空";
        }
        if (StringUtils.isEmpty(tSemesterScoreDetail.getAcademicYear()))
        {
            return "学年不能为空";
        }
        if (tSemesterScoreDetail.getSemester() == null)
        {
            return "学期不能为空";
        }

        // 验证成绩范围
        if (tSemesterScoreDetail.getMoralScore() != null && 
            (tSemesterScoreDetail.getMoralScore().compareTo(BigDecimal.ZERO) < 0 || 
             tSemesterScoreDetail.getMoralScore().compareTo(BigDecimal.valueOf(100)) > 0))
        {
            return "德育成绩必须在0-100之间";
        }
        
        if (tSemesterScoreDetail.getIntellectualScore() != null && 
            (tSemesterScoreDetail.getIntellectualScore().compareTo(BigDecimal.ZERO) < 0 || 
             tSemesterScoreDetail.getIntellectualScore().compareTo(BigDecimal.valueOf(100)) > 0))
        {
            return "智育成绩必须在0-100之间";
        }

        return "";
    }

    /**
     * 新增学期成绩明细
     * 
     * @param tSemesterScoreDetail 学期成绩明细
     * @return 结果
     */
    @Override
    public int insertTSemesterScoreDetail(TSemesterScoreDetail tSemesterScoreDetail)
    {
        // 计算综合成绩
        tSemesterScoreDetail = calculateComprehensiveScore(tSemesterScoreDetail);
        tSemesterScoreDetail.setCreateTime(DateUtils.getNowDate());
        return tSemesterScoreDetailMapper.insertTSemesterScoreDetail(tSemesterScoreDetail);
    }

    /**
     * 修改学期成绩明细
     * 
     * @param tSemesterScoreDetail 学期成绩明细
     * @return 结果
     */
    @Override
    public int updateTSemesterScoreDetail(TSemesterScoreDetail tSemesterScoreDetail)
    {
        // 重新计算综合成绩
        tSemesterScoreDetail = calculateComprehensiveScore(tSemesterScoreDetail);
        tSemesterScoreDetail.setUpdateTime(DateUtils.getNowDate());
        return tSemesterScoreDetailMapper.updateTSemesterScoreDetail(tSemesterScoreDetail);
    }

    /**
     * 批量删除学期成绩明细
     * 
     * @param ids 需要删除的学期成绩明细主键
     * @return 结果
     */
    @Override
    public int deleteTSemesterScoreDetailByIds(Long[] ids)
    {
        return tSemesterScoreDetailMapper.deleteTSemesterScoreDetailByIds(ids);
    }

    /**
     * 删除学期成绩明细信息
     * 
     * @param id 学期成绩明细主键
     * @return 结果
     */
    @Override
    public int deleteTSemesterScoreDetailById(Long id)
    {
        return tSemesterScoreDetailMapper.deleteTSemesterScoreDetailById(id);
    }
}