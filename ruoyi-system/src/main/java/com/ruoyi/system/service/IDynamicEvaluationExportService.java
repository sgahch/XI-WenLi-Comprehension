package com.ruoyi.system.service;

import org.apache.poi.ss.usermodel.Workbook;

/**
 * 动态综测Excel导出服务接口
 * 
 * @author ruoyi
 * @date 2025-11-02
 */
public interface IDynamicEvaluationExportService {
    
    /**
     * 导出班级综测数据(完整版 - 包含所有详细列)
     * 
     * @param academicYear 学年
     * @param semester 学期
     * @param classId 班级ID
     * @return Excel工作簿
     */
    Workbook exportFullEvaluationData(String academicYear, Integer semester, Long classId);
    
    /**
     * 导出班级综测数据(汇总版 - 仅包含F1/F2/F3总分和排名)
     * 
     * @param academicYear 学年
     * @param semester 学期
     * @param classId 班级ID
     * @return Excel工作簿
     */
    Workbook exportSummaryEvaluationData(String academicYear, Integer semester, Long classId);
    
    /**
     * 导出学院综测数据(跨班级汇总)
     * 
     * @param academicYear 学年
     * @param semester 学期
     * @param collegeId 学院ID
     * @return Excel工作簿
     */
    Workbook exportCollegeEvaluationData(String academicYear, Integer semester, Long collegeId);
}

