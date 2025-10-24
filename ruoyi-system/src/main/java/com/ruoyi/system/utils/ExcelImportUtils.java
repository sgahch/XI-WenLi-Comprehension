package com.ruoyi.system.utils;

import com.ruoyi.common.exception.ServiceException;

import com.ruoyi.system.domain.TSemesterScoreDetail;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Excel导入工具类
 * 支持批量导入班级综测数据
 * 
 * @author ruoyi
 * @date 2024-01-20
 */
public class ExcelImportUtils {
    
    /**
     * 支持的文件类型
     */
    private static final String[] ALLOWED_EXTENSIONS = {".xlsx", ".xls"};
    
    /**
     * 最大导入行数
     */
    private static final int MAX_IMPORT_ROWS = 1000;
    
    /**
     * Excel列映射配置
     */
    private static final Map<String, Integer> COLUMN_MAPPING = new HashMap<>();
    
    static {
        COLUMN_MAPPING.put("studentId", 0);      // 学号
        COLUMN_MAPPING.put("studentName", 1);    // 姓名
        COLUMN_MAPPING.put("className", 2);      // 班级
        COLUMN_MAPPING.put("majorName", 3);      // 专业
        COLUMN_MAPPING.put("academicYear", 4);   // 学年
        COLUMN_MAPPING.put("semester", 5);       // 学期
        COLUMN_MAPPING.put("moralScore", 6);     // 德育成绩
        COLUMN_MAPPING.put("intellectualScore", 7); // 智育成绩
        COLUMN_MAPPING.put("physicalScore", 8);  // 体育成绩
        COLUMN_MAPPING.put("aestheticScore", 9); // 美育成绩
        COLUMN_MAPPING.put("laborScore", 10);    // 劳育成绩
        COLUMN_MAPPING.put("comprehensiveScore", 11); // 综合成绩
    }
    
    /**
     * 导入Excel数据
     * 
     * @param file Excel文件
     * @return 导入的成绩明细列表
     * @throws ServiceException 导入异常
     */
    public static List<TSemesterScoreDetail> importExcel(MultipartFile file) throws ServiceException {
        if (file == null || file.isEmpty()) {
            throw new ServiceException("导入文件不能为空");
        }
        
        // 验证文件类型
        validateFileType(file.getOriginalFilename());
        
        List<TSemesterScoreDetail> scoreDetails = new ArrayList<>();
        List<String> errorMessages = new ArrayList<>();
        
        try (InputStream inputStream = file.getInputStream();
             Workbook workbook = new XSSFWorkbook(inputStream)) {
            
            Sheet sheet = workbook.getSheetAt(0);
            int totalRows = sheet.getPhysicalNumberOfRows();
            
            // 验证导入行数
            if (totalRows > MAX_IMPORT_ROWS + 1) { // +1 for header
                throw new ServiceException("导入数据不能超过" + MAX_IMPORT_ROWS + "行");
            }
            
            // 跳过标题行，从第二行开始读取数据
            for (int i = 1; i < totalRows; i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                
                try {
                    TSemesterScoreDetail scoreDetail = parseRowData(row, i + 1);
                    if (scoreDetail != null) {
                        scoreDetails.add(scoreDetail);
                    }
                } catch (Exception e) {
                    errorMessages.add("第" + (i + 1) + "行数据解析失败：" + e.getMessage());
                }
            }
            
        } catch (IOException e) {
            throw new ServiceException("读取Excel文件失败：" + e.getMessage());
        }
        
        // 如果有错误信息，抛出异常
        if (!errorMessages.isEmpty()) {
            throw new ServiceException("导入数据存在错误：\n" + String.join("\n", errorMessages));
        }
        
        return scoreDetails;
    }
    
    /**
     * 解析行数据
     * 
     * @param row Excel行
     * @param rowNum 行号
     * @return 成绩明细对象
     */
    private static TSemesterScoreDetail parseRowData(Row row, int rowNum) {
        TSemesterScoreDetail scoreDetail = new TSemesterScoreDetail();
        
        try {
            // 学号（必填）
            String studentId = getCellStringValue(row, COLUMN_MAPPING.get("studentId"));
            if (studentId == null || studentId.trim().isEmpty()) {
                throw new RuntimeException("学号不能为空");
            }
            scoreDetail.setStudentId(studentId.trim());
            
            // 姓名（必填）
            String studentName = getCellStringValue(row, COLUMN_MAPPING.get("studentName"));
            if (studentName == null || studentName.trim().isEmpty()) {
                throw new RuntimeException("姓名不能为空");
            }
            scoreDetail.setStudentName(studentName.trim());
            
            // 班级（必填）
            String className = getCellStringValue(row, COLUMN_MAPPING.get("className"));
            if (className == null || className.trim().isEmpty()) {
                throw new RuntimeException("班级不能为空");
            }
            scoreDetail.setClassName(className.trim());
            
            // 专业（必填）
            String majorName = getCellStringValue(row, COLUMN_MAPPING.get("majorName"));
            if (majorName == null || majorName.trim().isEmpty()) {
                throw new RuntimeException("专业不能为空");
            }
            scoreDetail.setMajorName(majorName.trim());
            
            // 学年（必填）
            String academicYear = getCellStringValue(row, COLUMN_MAPPING.get("academicYear"));
            if (academicYear == null || academicYear.trim().isEmpty()) {
                throw new RuntimeException("学年不能为空");
            }
            scoreDetail.setAcademicYear(academicYear.trim());
            
            // 学期（必填）
            String semester = getCellStringValue(row, COLUMN_MAPPING.get("semester"));
            if (semester == null || semester.trim().isEmpty()) {
                throw new RuntimeException("学期不能为空");
            }
            scoreDetail.setSemester(Integer.valueOf(semester.trim()));
            
            // 德育成绩
            BigDecimal moralScore = getCellNumericValue(row, COLUMN_MAPPING.get("moralScore"));
            if (moralScore != null) {
                validateScore(moralScore, "德育成绩");
                scoreDetail.setMoralScore(moralScore);
            }
            
            // 智育成绩
            BigDecimal intellectualScore = getCellNumericValue(row, COLUMN_MAPPING.get("intellectualScore"));
            if (intellectualScore != null) {
                validateScore(intellectualScore, "智育成绩");
                scoreDetail.setIntellectualScore(intellectualScore);
            }
            
            // 体育成绩
            BigDecimal physicalScore = getCellNumericValue(row, COLUMN_MAPPING.get("physicalScore"));
            if (physicalScore != null) {
                validateScore(physicalScore, "体育成绩");
                scoreDetail.setPhysicalScore(physicalScore);
            }
            
            // 美育成绩
            BigDecimal aestheticScore = getCellNumericValue(row, COLUMN_MAPPING.get("aestheticScore"));
            if (aestheticScore != null) {
                validateScore(aestheticScore, "美育成绩");
                scoreDetail.setAestheticScore(aestheticScore);
            }
            
            // 劳育成绩
            BigDecimal laborScore = getCellNumericValue(row, COLUMN_MAPPING.get("laborScore"));
            if (laborScore != null) {
                validateScore(laborScore, "劳育成绩");
                scoreDetail.setLaborScore(laborScore);
            }
            
            // 综合成绩
            BigDecimal comprehensiveScore = getCellNumericValue(row, COLUMN_MAPPING.get("comprehensiveScore"));
            if (comprehensiveScore != null) {
                validateScore(comprehensiveScore, "综合成绩");
                scoreDetail.setTotalScore(comprehensiveScore);
            }
            
            // 设置创建时间
            scoreDetail.setCreateTime(new Date());
            
            return scoreDetail;
            
        } catch (Exception e) {
            throw new RuntimeException("第" + rowNum + "行：" + e.getMessage());
        }
    }
    
    /**
     * 获取单元格字符串值
     */
    private static String getCellStringValue(Row row, int columnIndex) {
        Cell cell = row.getCell(columnIndex);
        if (cell == null) return null;
        
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    return sdf.format(cell.getDateCellValue());
                } else {
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return null;
        }
    }
    
    /**
     * 获取单元格数值
     */
    private static BigDecimal getCellNumericValue(Row row, int columnIndex) {
        Cell cell = row.getCell(columnIndex);
        if (cell == null) return null;
        
        switch (cell.getCellType()) {
            case NUMERIC:
                return BigDecimal.valueOf(cell.getNumericCellValue());
            case STRING:
                String strValue = cell.getStringCellValue().trim();
                if (strValue.isEmpty()) return null;
                try {
                    return new BigDecimal(strValue);
                } catch (NumberFormatException e) {
                    throw new RuntimeException("数值格式错误：" + strValue);
                }
            default:
                return null;
        }
    }
    
    /**
     * 验证成绩范围
     */
    private static void validateScore(BigDecimal score, String scoreName) {
        if (score.compareTo(BigDecimal.ZERO) < 0 || score.compareTo(new BigDecimal("100")) > 0) {
            throw new RuntimeException(scoreName + "必须在0-100之间");
        }
    }
    
    /**
     * 验证文件类型
     */
    private static void validateFileType(String fileName) {
        if (fileName == null) {
            throw new ServiceException("文件名不能为空");
        }
        
        boolean isValidType = false;
        for (String extension : ALLOWED_EXTENSIONS) {
            if (fileName.toLowerCase().endsWith(extension)) {
                isValidType = true;
                break;
            }
        }
        
        if (!isValidType) {
            throw new ServiceException("不支持的文件类型，仅支持.xlsx和.xls格式");
        }
    }
    
    /**
     * 生成导入模板
     * 
     * @return Excel工作簿
     */
    public static Workbook generateImportTemplate() {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("综测成绩导入模板");
        
        // 创建标题行
        Row headerRow = sheet.createRow(0);
        String[] headers = {
            "学号", "姓名", "班级", "专业", "学年", "学期",
            "德育成绩", "智育成绩", "体育成绩", "美育成绩", "劳育成绩", "综合成绩"
        };
        
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }
        
        // 创建示例数据行
        Row exampleRow = sheet.createRow(1);
        String[] exampleData = {
            "2021001", "张三", "计算机1班", "计算机科学与技术", "2023-2024", "第一学期",
            "85.5", "90.0", "88.0", "82.5", "87.0", "86.6"
        };
        
        for (int i = 0; i < exampleData.length; i++) {
            Cell cell = exampleRow.createCell(i);
            cell.setCellValue(exampleData[i]);
        }
        
        // 自动调整列宽
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }
        
        return workbook;
    }
    
    /**
     * 批量验证导入数据
     * 
     * @param scoreDetails 成绩明细列表
     * @return 验证结果
     */
    public static Map<String, Object> validateImportData(List<TSemesterScoreDetail> scoreDetails) {
        Map<String, Object> result = new HashMap<>();
        List<String> errors = new ArrayList<>();
        List<String> warnings = new ArrayList<>();
        
        if (scoreDetails == null || scoreDetails.isEmpty()) {
            errors.add("导入数据为空");
            result.put("success", false);
            result.put("errors", errors);
            return result;
        }
        
        // 检查重复数据
        Set<String> duplicateCheck = new HashSet<>();
        for (int i = 0; i < scoreDetails.size(); i++) {
            TSemesterScoreDetail detail = scoreDetails.get(i);
            String key = detail.getStudentId() + "_" + detail.getAcademicYear() + "_" + detail.getSemester();
            
            if (duplicateCheck.contains(key)) {
                errors.add("第" + (i + 2) + "行：学生" + detail.getStudentName() + "在该学年学期的数据重复");
            } else {
                duplicateCheck.add(key);
            }
            
            // 数据完整性验证
            try {
                DataValidationUtils.validateScoreDetail(detail);
            } catch (Exception e) {
                errors.add("第" + (i + 2) + "行：" + e.getMessage());
            }
        }
        
        result.put("success", errors.isEmpty());
        result.put("errors", errors);
        result.put("warnings", warnings);
        result.put("totalCount", scoreDetails.size());
        result.put("validCount", scoreDetails.size() - errors.size());
        
        return result;
    }
}