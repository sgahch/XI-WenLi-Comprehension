package com.ruoyi.web.controller.evaluation;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.service.IDynamicEvaluationExportService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

/**
 * 动态综测Excel导出Controller
 * 
 * @author ruoyi
 * @date 2025-11-02
 */
@RestController
@RequestMapping("/evaluation/export")
public class DynamicExportController extends BaseController {
    
    @Autowired
    private IDynamicEvaluationExportService dynamicExportService;
    
    /**
     * 导出班级综测数据(完整版)
     * 
     * @param academicYear 学年
     * @param semester 学期
     * @param classId 班级ID
     * @param response HTTP响应
     */
    @PreAuthorize("@ss.hasPermi('evaluation:export:full')")
    @Log(title = "导出班级综测数据(完整版)", businessType = BusinessType.EXPORT)
    @GetMapping("/full")
    public void exportFullData(
        @RequestParam String academicYear,
        @RequestParam Integer semester,
        @RequestParam Long classId,
        HttpServletResponse response
    ) throws IOException {
        Workbook workbook = dynamicExportService.exportFullEvaluationData(academicYear, semester, classId);
        
        String fileName = String.format("综测数据完整版_%s_%s学期.xlsx", academicYear, semester);
        exportExcel(response, workbook, fileName);
    }
    
    /**
     * 导出班级综测数据(汇总版)
     * 
     * @param academicYear 学年
     * @param semester 学期
     * @param classId 班级ID
     * @param response HTTP响应
     */
    @PreAuthorize("@ss.hasPermi('evaluation:export:summary')")
    @Log(title = "导出班级综测数据(汇总版)", businessType = BusinessType.EXPORT)
    @GetMapping("/summary")
    public void exportSummaryData(
        @RequestParam String academicYear,
        @RequestParam Integer semester,
        @RequestParam Long classId,
        HttpServletResponse response
    ) throws IOException {
        Workbook workbook = dynamicExportService.exportSummaryEvaluationData(academicYear, semester, classId);
        
        String fileName = String.format("综测数据汇总版_%s_%s学期.xlsx", academicYear, semester);
        exportExcel(response, workbook, fileName);
    }
    
    /**
     * 导出学院综测数据(跨班级)
     * 
     * @param academicYear 学年
     * @param semester 学期
     * @param collegeId 学院ID
     * @param response HTTP响应
     */
    @PreAuthorize("@ss.hasPermi('evaluation:export:college')")
    @Log(title = "导出学院综测数据", businessType = BusinessType.EXPORT)
    @GetMapping("/college")
    public void exportCollegeData(
        @RequestParam String academicYear,
        @RequestParam Integer semester,
        @RequestParam Long collegeId,
        HttpServletResponse response
    ) throws IOException {
        Workbook workbook = dynamicExportService.exportCollegeEvaluationData(academicYear, semester, collegeId);
        
        String fileName = String.format("学院综测数据_%s_%s学期.xlsx", academicYear, semester);
        exportExcel(response, workbook, fileName);
    }
    
    /**
     * 通用Excel导出方法
     * 
     * @param response HTTP响应
     * @param workbook Excel工作簿
     * @param fileName 文件名
     */
    private void exportExcel(HttpServletResponse response, Workbook workbook, String fileName) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        
        String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + encodedFileName);
        
        try (OutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            outputStream.flush();
        } finally {
            workbook.close();
        }
    }
}

