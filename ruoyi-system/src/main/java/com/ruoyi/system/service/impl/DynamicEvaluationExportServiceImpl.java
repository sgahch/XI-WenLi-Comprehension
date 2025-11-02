package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.EvaluationSubmission;
import com.ruoyi.system.domain.EvaluationSubmissionDetail;
import com.ruoyi.system.domain.dto.DynamicColumnData;
import com.ruoyi.system.service.IDynamicEvaluationExportService;
import com.ruoyi.system.service.IEvaluationSubmissionService;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.system.service.ISysUserService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 动态综测Excel导出服务实现
 * 
 * @author ruoyi
 * @date 2025-11-02
 */
@Service
public class DynamicEvaluationExportServiceImpl implements IDynamicEvaluationExportService {
    
    @Autowired
    private IEvaluationSubmissionService submissionService;
    
    @Autowired
    private ISysUserService userService;
    
    @Autowired
    private ISysDeptService deptService;
    
    /**
     * 导出完整版综测数据
     */
    @Override
    public Workbook exportFullEvaluationData(String academicYear, Integer semester, Long classId) {
        // 1. 查询班级所有学生的提交记录
        List<EvaluationSubmission> submissions = querySubmissions(academicYear, semester, classId);
        
        // 2. 构建动态列数据
        List<DynamicColumnData> dataList = buildDynamicColumnData(submissions);
        
        // 3. 收集所有动态列名
        DynamicColumnCollector collector = collectDynamicColumns(dataList);
        
        // 4. 创建Excel工作簿
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("综测数据");
        
        // 5. 创建样式
        Map<String, CellStyle> styles = createStyles(workbook);
        
        // 6. 创建表头
        int currentCol = createFullHeader(sheet, collector, styles);
        
        // 7. 填充数据
        fillFullData(sheet, dataList, collector, styles);
        
        // 8. 自动调整列宽
        autoSizeColumns(sheet, currentCol);
        
        return workbook;
    }
    
    /**
     * 导出汇总版综测数据
     */
    @Override
    public Workbook exportSummaryEvaluationData(String academicYear, Integer semester, Long classId) {
        List<EvaluationSubmission> submissions = querySubmissions(academicYear, semester, classId);
        List<DynamicColumnData> dataList = buildDynamicColumnData(submissions);
        
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("综测汇总");
        
        Map<String, CellStyle> styles = createStyles(workbook);
        
        // 创建汇总表头
        createSummaryHeader(sheet, styles);
        
        // 填充汇总数据
        fillSummaryData(sheet, dataList, styles);
        
        autoSizeColumns(sheet, 8);
        
        return workbook;
    }
    
    /**
     * 导出学院综测数据
     */
    @Override
    public Workbook exportCollegeEvaluationData(String academicYear, Integer semester, Long collegeId) {
        // 查询学院下所有班级
        SysDept college = deptService.selectDeptById(collegeId);
        List<SysDept> classes = deptService.selectChildrenDeptById(collegeId);
        
        Workbook workbook = new XSSFWorkbook();
        
        // 为每个班级创建一个Sheet
        for (SysDept classInfo : classes) {
            List<EvaluationSubmission> submissions = querySubmissions(academicYear, semester, classInfo.getDeptId());
            if (submissions.isEmpty()) {
                continue;
            }
            
            List<DynamicColumnData> dataList = buildDynamicColumnData(submissions);
            DynamicColumnCollector collector = collectDynamicColumns(dataList);
            
            Sheet sheet = workbook.createSheet(classInfo.getDeptName());
            Map<String, CellStyle> styles = createStyles(workbook);
            
            int currentCol = createFullHeader(sheet, collector, styles);
            fillFullData(sheet, dataList, collector, styles);
            autoSizeColumns(sheet, currentCol);
        }
        
        return workbook;
    }
    
    /**
     * 查询提交记录
     */
    private List<EvaluationSubmission> querySubmissions(String academicYear, Integer semester, Long classId) {
        EvaluationSubmission query = new EvaluationSubmission();
        query.setAcademicYear(academicYear);
        query.setSemester(semester);
        query.setClassId(classId);
        return submissionService.selectEvaluationSubmissionList(query);
    }
    
    /**
     * 构建动态列数据
     */
    private List<DynamicColumnData> buildDynamicColumnData(List<EvaluationSubmission> submissions) {
        List<DynamicColumnData> dataList = new ArrayList<>();
        
        for (EvaluationSubmission submission : submissions) {
            DynamicColumnData data = new DynamicColumnData();
            
            // 基本信息
            SysUser student = userService.selectUserById(submission.getStudentId());
            data.setStudentId(submission.getStudentId());
            data.setStudentName(student.getNickName());
            data.setStudentCode(student.getUserName());
            
            SysDept dept = deptService.selectDeptById(submission.getClassId());
            data.setClassName(dept != null ? dept.getDeptName() : "");
            
            // F1 德育
            data.setF1TotalScore(submission.getMoralScore() != null ? submission.getMoralScore() : BigDecimal.ZERO);
            
            // F2 智育
            data.setF2aTotalScore(submission.getIntellectualScore() != null ? submission.getIntellectualScore() : BigDecimal.ZERO);
            
            // F3 素质发展
            data.setPhysicalTotalScore(submission.getPhysicalScore() != null ? submission.getPhysicalScore() : BigDecimal.ZERO);
            data.setAestheticTotalScore(submission.getAestheticScore() != null ? submission.getAestheticScore() : BigDecimal.ZERO);
            data.setLaborTotalScore(submission.getLaborScore() != null ? submission.getLaborScore() : BigDecimal.ZERO);
            data.setF3TotalScore(
                data.getPhysicalTotalScore()
                    .add(data.getAestheticTotalScore())
                    .add(data.getLaborTotalScore())
            );
            
            // 综测总分
            data.setTotalScore(submission.getTotalScore() != null ? submission.getTotalScore() : BigDecimal.ZERO);
            
            // 解析详情数据
            parseSubmissionDetails(submission, data);
            
            dataList.add(data);
        }
        
        // 计算排名
        calculateRanks(dataList);
        
        return dataList;
    }
    
    /**
     * 解析提交详情
     */
    private void parseSubmissionDetails(EvaluationSubmission submission, DynamicColumnData data) {
        List<EvaluationSubmissionDetail> details = submission.getDetails();
        if (details == null || details.isEmpty()) {
            return;
        }
        
        for (EvaluationSubmissionDetail detail : details) {
            JSONObject ruleSnapshot = JSON.parseObject(detail.getRuleSnapshot());
            String itemName = ruleSnapshot.getString("itemName");
            Integer dimensionType = ruleSnapshot.getInteger("dimensionType");
            BigDecimal score = detail.getFinalScore() != null ? detail.getFinalScore() : BigDecimal.ZERO;
            
            // 根据维度类型分类
            if (dimensionType == null) {
                continue;
            }
            
            switch (dimensionType) {
                case 1: // 德育
                    parseF1Item(itemName, score, data);
                    break;
                case 2: // 智育
                    parseF2Item(itemName, score, ruleSnapshot, data);
                    break;
                case 3: // 体育
                    data.getF2aCourseScores().put(itemName, score);
                    break;
                case 4: // 美育
                    data.getF2bCompetitionScores().put(itemName, score);
                    break;
                case 5: // 劳育
                    // 劳育相关处理
                    break;
            }
        }
    }
    
    /**
     * 解析F1德育项目
     */
    private void parseF1Item(String itemName, BigDecimal score, DynamicColumnData data) {
        // 根据项目名称判断是加分还是扣分
        if (itemName.contains("违规") || itemName.contains("旷课") || itemName.contains("扣分")) {
            data.getF1DeductionItems().put(itemName, score);
        } else {
            data.getF1BonusItems().put(itemName, score);
        }
    }
    
    /**
     * 解析F2智育项目
     */
    private void parseF2Item(String itemName, BigDecimal score, JSONObject ruleSnapshot, DynamicColumnData data) {
        String itemCode = ruleSnapshot.getString("itemCode");
        
        // 判断是课程还是竞赛
        if (itemCode != null && (itemCode.contains("COMPETITION") || itemCode.contains("CONTEST"))) {
            // 竞赛项目
            data.getF2bCompetitionScores().put(itemName, score);
        } else {
            // 课程成绩
            data.getF2aCourseScores().put(itemName, score);
        }
    }
    
    /**
     * 计算排名
     */
    private void calculateRanks(List<DynamicColumnData> dataList) {
        // 按总分降序排序
        List<DynamicColumnData> sortedByTotal = dataList.stream()
            .sorted((a, b) -> b.getTotalScore().compareTo(a.getTotalScore()))
            .collect(Collectors.toList());
        
        for (int i = 0; i < sortedByTotal.size(); i++) {
            sortedByTotal.get(i).setTotalRank(i + 1);
        }
        
        // 按F2a分数排序计算班级排名
        List<DynamicColumnData> sortedByF2a = dataList.stream()
            .sorted((a, b) -> b.getF2aTotalScore().compareTo(a.getF2aTotalScore()))
            .collect(Collectors.toList());
        
        for (int i = 0; i < sortedByF2a.size(); i++) {
            sortedByF2a.get(i).setF2aClassRank(i + 1);
        }
    }
    
    /**
     * 动态列收集器内部类
     */
    private static class DynamicColumnCollector {
        Set<String> f1BonusColumns = new LinkedHashSet<>();
        Set<String> f1DeductionColumns = new LinkedHashSet<>();
        Set<String> f2aCourseColumns = new LinkedHashSet<>();
        Set<String> f2bCompetitionColumns = new LinkedHashSet<>();
    }
    
    /**
     * 收集所有动态列
     */
    private DynamicColumnCollector collectDynamicColumns(List<DynamicColumnData> dataList) {
        DynamicColumnCollector collector = new DynamicColumnCollector();
        
        for (DynamicColumnData data : dataList) {
            collector.f1BonusColumns.addAll(data.getF1BonusItems().keySet());
            collector.f1DeductionColumns.addAll(data.getF1DeductionItems().keySet());
            collector.f2aCourseColumns.addAll(data.getF2aCourseScores().keySet());
            collector.f2bCompetitionColumns.addAll(data.getF2bCompetitionScores().keySet());
        }
        
        return collector;
    }
    
    /**
     * 创建样式
     */
    private Map<String, CellStyle> createStyles(Workbook workbook) {
        Map<String, CellStyle> styles = new HashMap<>();

        // 标题样式
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        headerStyle.setBorderTop(BorderStyle.THIN);
        headerStyle.setBorderBottom(BorderStyle.THIN);
        headerStyle.setBorderLeft(BorderStyle.THIN);
        headerStyle.setBorderRight(BorderStyle.THIN);
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short) 11);
        headerStyle.setFont(headerFont);
        styles.put("header", headerStyle);

        // F1德育区域样式(橙色)
        CellStyle f1Style = workbook.createCellStyle();
        f1Style.cloneStyleFrom(headerStyle);
        f1Style.setFillForegroundColor(IndexedColors.LIGHT_ORANGE.getIndex());
        styles.put("f1Header", f1Style);

        // F2智育区域样式(绿色)
        CellStyle f2Style = workbook.createCellStyle();
        f2Style.cloneStyleFrom(headerStyle);
        f2Style.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
        styles.put("f2Header", f2Style);

        // F2b奖励分样式(橙色)
        CellStyle f2bStyle = workbook.createCellStyle();
        f2bStyle.cloneStyleFrom(headerStyle);
        f2bStyle.setFillForegroundColor(IndexedColors.LIGHT_ORANGE.getIndex());
        styles.put("f2bHeader", f2bStyle);

        // F3素质发展样式(蓝色)
        CellStyle f3Style = workbook.createCellStyle();
        f3Style.cloneStyleFrom(headerStyle);
        f3Style.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
        styles.put("f3Header", f3Style);

        // 数据样式
        CellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setAlignment(HorizontalAlignment.CENTER);
        dataStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        dataStyle.setBorderTop(BorderStyle.THIN);
        dataStyle.setBorderBottom(BorderStyle.THIN);
        dataStyle.setBorderLeft(BorderStyle.THIN);
        dataStyle.setBorderRight(BorderStyle.THIN);
        styles.put("data", dataStyle);

        // 数字样式
        CellStyle numberStyle = workbook.createCellStyle();
        numberStyle.cloneStyleFrom(dataStyle);
        DataFormat format = workbook.createDataFormat();
        numberStyle.setDataFormat(format.getFormat("0.00"));
        styles.put("number", numberStyle);

        return styles;
    }

    /**
     * 创建完整版表头
     */
    private int createFullHeader(Sheet sheet, DynamicColumnCollector collector, Map<String, CellStyle> styles) {
        Row headerRow = sheet.createRow(0);
        int col = 0;

        // 基本信息列
        createHeaderCell(headerRow, col++, "序号", styles.get("header"));
        createHeaderCell(headerRow, col++, "姓名", styles.get("header"));

        // F1 德育素质测评区域
        createHeaderCell(headerRow, col++, "满分15分", styles.get("f1Header"));
        createHeaderCell(headerRow, col++, "基础分", styles.get("f1Header"));

        // F1加分项
        for (String bonusItem : collector.f1BonusColumns) {
            createHeaderCell(headerRow, col++, bonusItem, styles.get("f1Header"));
        }
        createHeaderCell(headerRow, col++, "加分项总和", styles.get("f1Header"));

        // F1扣分项
        for (String deductionItem : collector.f1DeductionColumns) {
            createHeaderCell(headerRow, col++, deductionItem, styles.get("f1Header"));
        }
        createHeaderCell(headerRow, col++, "扣分项总和", styles.get("f1Header"));
        createHeaderCell(headerRow, col++, "F1总分", styles.get("f1Header"));

        // F2a 智育基础分区域
        createHeaderCell(headerRow, col++, "满分70分", styles.get("f2Header"));

        // F2a课程列
        for (String course : collector.f2aCourseColumns) {
            createHeaderCell(headerRow, col++, course, styles.get("f2Header"));
        }
        createHeaderCell(headerRow, col++, "智育成绩", styles.get("f2Header"));
        createHeaderCell(headerRow, col++, "F2a总分", styles.get("f2Header"));
        createHeaderCell(headerRow, col++, "班级排名", styles.get("f2Header"));

        // F2b 智育奖励分区域
        for (String competition : collector.f2bCompetitionColumns) {
            createHeaderCell(headerRow, col++, competition, styles.get("f2bHeader"));
        }
        createHeaderCell(headerRow, col++, "F2b总分", styles.get("f2bHeader"));
        createHeaderCell(headerRow, col++, "满分15分", styles.get("f2bHeader"));

        // F3 素质发展区域
        createHeaderCell(headerRow, col++, "体育成绩", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "体测", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "正向加分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "反向减分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "体育总分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "艺术教育", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "艺术实践", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "美育总分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "劳动教育", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "正向加分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "反向减分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "劳育总分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "F3总分", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "满分15分", styles.get("f3Header"));

        // 综测一览分区域
        createHeaderCell(headerRow, col++, "姓名", styles.get("header"));
        createHeaderCell(headerRow, col++, "学号", styles.get("header"));
        createHeaderCell(headerRow, col++, "德育素质F1", styles.get("header"));
        createHeaderCell(headerRow, col++, "智育素质F2", styles.get("header"));
        createHeaderCell(headerRow, col++, "素质发展F3", styles.get("header"));
        createHeaderCell(headerRow, col++, "综测合计", styles.get("header"));
        createHeaderCell(headerRow, col++, "排名", styles.get("header"));

        return col;
    }

    /**
     * 创建汇总版表头
     */
    private void createSummaryHeader(Sheet sheet, Map<String, CellStyle> styles) {
        Row headerRow = sheet.createRow(0);
        int col = 0;

        createHeaderCell(headerRow, col++, "排名", styles.get("header"));
        createHeaderCell(headerRow, col++, "姓名", styles.get("header"));
        createHeaderCell(headerRow, col++, "学号", styles.get("header"));
        createHeaderCell(headerRow, col++, "班级", styles.get("header"));
        createHeaderCell(headerRow, col++, "德育素质F1", styles.get("f1Header"));
        createHeaderCell(headerRow, col++, "智育素质F2", styles.get("f2Header"));
        createHeaderCell(headerRow, col++, "素质发展F3", styles.get("f3Header"));
        createHeaderCell(headerRow, col++, "综测合计", styles.get("header"));
    }

    /**
     * 创建表头单元格
     */
    private void createHeaderCell(Row row, int col, String value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    /**
     * 填充完整版数据
     */
    private void fillFullData(Sheet sheet, List<DynamicColumnData> dataList,
                              DynamicColumnCollector collector, Map<String, CellStyle> styles) {
        int rowNum = 1;
        int serialNumber = 1;

        for (DynamicColumnData data : dataList) {
            Row row = sheet.createRow(rowNum++);
            int col = 0;

            // 基本信息
            createDataCell(row, col++, serialNumber++, styles.get("data"));
            createDataCell(row, col++, data.getStudentName(), styles.get("data"));

            // F1 德育
            createDataCell(row, col++, "15", styles.get("data")); // 满分标识
            createNumberCell(row, col++, data.getF1BaseScore(), styles.get("number"));

            // F1加分项
            BigDecimal f1BonusSum = BigDecimal.ZERO;
            for (String bonusItem : collector.f1BonusColumns) {
                BigDecimal score = data.getF1BonusItems().getOrDefault(bonusItem, BigDecimal.ZERO);
                createNumberCell(row, col++, score, styles.get("number"));
                f1BonusSum = f1BonusSum.add(score);
            }
            createNumberCell(row, col++, f1BonusSum, styles.get("number"));

            // F1扣分项
            BigDecimal f1DeductionSum = BigDecimal.ZERO;
            for (String deductionItem : collector.f1DeductionColumns) {
                BigDecimal score = data.getF1DeductionItems().getOrDefault(deductionItem, BigDecimal.ZERO);
                createNumberCell(row, col++, score, styles.get("number"));
                f1DeductionSum = f1DeductionSum.add(score);
            }
            createNumberCell(row, col++, f1DeductionSum, styles.get("number"));
            createNumberCell(row, col++, data.getF1TotalScore(), styles.get("number"));

            // F2a 智育基础分
            createDataCell(row, col++, "70", styles.get("data")); // 满分标识

            // F2a课程成绩
            for (String course : collector.f2aCourseColumns) {
                BigDecimal score = data.getF2aCourseScores().getOrDefault(course, BigDecimal.ZERO);
                createNumberCell(row, col++, score, styles.get("number"));
            }
            createNumberCell(row, col++, data.getF2aAverageScore(), styles.get("number"));
            createNumberCell(row, col++, data.getF2aTotalScore(), styles.get("number"));
            createDataCell(row, col++, data.getF2aClassRank(), styles.get("data"));

            // F2b 智育奖励分
            BigDecimal f2bSum = BigDecimal.ZERO;
            for (String competition : collector.f2bCompetitionColumns) {
                BigDecimal score = data.getF2bCompetitionScores().getOrDefault(competition, BigDecimal.ZERO);
                createNumberCell(row, col++, score, styles.get("number"));
                f2bSum = f2bSum.add(score);
            }
            createNumberCell(row, col++, f2bSum, styles.get("number"));
            createDataCell(row, col++, "15", styles.get("data")); // 满分标识

            // F3 素质发展
            createNumberCell(row, col++, data.getPhysicalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getPhysicalTestScore(), styles.get("number"));
            createNumberCell(row, col++, data.getPhysicalBonusScore(), styles.get("number"));
            createNumberCell(row, col++, data.getPhysicalDeductionScore(), styles.get("number"));
            createNumberCell(row, col++, data.getPhysicalTotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getArtEducationScore(), styles.get("number"));
            createNumberCell(row, col++, data.getArtPracticeScore(), styles.get("number"));
            createNumberCell(row, col++, data.getAestheticTotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getLaborEducationScore(), styles.get("number"));
            createNumberCell(row, col++, data.getLaborBonusScore(), styles.get("number"));
            createNumberCell(row, col++, data.getLaborDeductionScore(), styles.get("number"));
            createNumberCell(row, col++, data.getLaborTotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getF3TotalScore(), styles.get("number"));
            createDataCell(row, col++, "15", styles.get("data")); // 满分标识

            // 综测一览分
            createDataCell(row, col++, data.getStudentName(), styles.get("data"));
            createDataCell(row, col++, data.getStudentCode(), styles.get("data"));
            createNumberCell(row, col++, data.getF1TotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getF2aTotalScore().add(f2bSum), styles.get("number"));
            createNumberCell(row, col++, data.getF3TotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getTotalScore(), styles.get("number"));
            createDataCell(row, col++, data.getTotalRank(), styles.get("data"));
        }
    }

    /**
     * 填充汇总版数据
     */
    private void fillSummaryData(Sheet sheet, List<DynamicColumnData> dataList, Map<String, CellStyle> styles) {
        int rowNum = 1;

        // 按排名排序
        dataList.sort(Comparator.comparing(DynamicColumnData::getTotalRank));

        for (DynamicColumnData data : dataList) {
            Row row = sheet.createRow(rowNum++);
            int col = 0;

            createDataCell(row, col++, data.getTotalRank(), styles.get("data"));
            createDataCell(row, col++, data.getStudentName(), styles.get("data"));
            createDataCell(row, col++, data.getStudentCode(), styles.get("data"));
            createDataCell(row, col++, data.getClassName(), styles.get("data"));
            createNumberCell(row, col++, data.getF1TotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getF2aTotalScore().add(data.getF2bTotalScore()), styles.get("number"));
            createNumberCell(row, col++, data.getF3TotalScore(), styles.get("number"));
            createNumberCell(row, col++, data.getTotalScore(), styles.get("number"));
        }
    }

    /**
     * 创建数据单元格
     */
    private void createDataCell(Row row, int col, Object value, CellStyle style) {
        Cell cell = row.createCell(col);
        if (value != null) {
            if (value instanceof Number) {
                cell.setCellValue(((Number) value).doubleValue());
            } else {
                cell.setCellValue(value.toString());
            }
        }
        cell.setCellStyle(style);
    }

    /**
     * 创建数字单元格
     */
    private void createNumberCell(Row row, int col, BigDecimal value, CellStyle style) {
        Cell cell = row.createCell(col);
        if (value != null) {
            cell.setCellValue(value.doubleValue());
        } else {
            cell.setCellValue(0.0);
        }
        cell.setCellStyle(style);
    }

    /**
     * 自动调整列宽
     */
    private void autoSizeColumns(Sheet sheet, int columnCount) {
        for (int i = 0; i < columnCount; i++) {
            sheet.autoSizeColumn(i);
            // 设置最小宽度
            int currentWidth = sheet.getColumnWidth(i);
            if (currentWidth < 2000) {
                sheet.setColumnWidth(i, 2000);
            }
            // 设置最大宽度
            if (currentWidth > 8000) {
                sheet.setColumnWidth(i, 8000);
            }
        }
    }
}

