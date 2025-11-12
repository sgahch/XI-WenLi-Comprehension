package com.ruoyi.web.controller.evaluation;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.system.service.EvaluationPermissionService;
import com.ruoyi.system.utils.ExcelImportUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.annotation.DataScope;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.TSemesterScoreDetail;
import com.ruoyi.system.service.ITSemesterScoreDetailService;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学期成绩明细Controller
 * 
 * @author ruoyi
 * @date 2024-01-20
 */
@RestController
@RequestMapping("/evaluation/semesterScore")
public class TSemesterScoreDetailController extends BaseController
{
    @Autowired
    private ITSemesterScoreDetailService tSemesterScoreDetailService;

    @Autowired
    private EvaluationPermissionService evaluationPermissionService;

    /**
     * 查询学期成绩明细列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:list')")
    @GetMapping("/list")
    @DataScope(deptAlias = "d", userAlias = "u")
    public TableDataInfo list(TSemesterScoreDetail tSemesterScoreDetail)
    {
        startPage();
        List<TSemesterScoreDetail> list = tSemesterScoreDetailService.selectTSemesterScoreDetailList(tSemesterScoreDetail);
        
        // 根据用户权限过滤数据
        list = evaluationPermissionService.filterScoreDataByPermission(list);
        
        return getDataTable(list);
    }

    /**
     * 根据班级查询成绩列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/listByClass")
    public TableDataInfo listByClass(@RequestParam String className, @RequestParam String academicYear, @RequestParam String semester)
    {
        startPage();
        List<TSemesterScoreDetail> list = tSemesterScoreDetailService.selectByClassAndSemester(className, academicYear, semester);
        return getDataTable(list);
    }

    /**
     * 根据专业查询成绩列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/listByMajor")
    public TableDataInfo listByMajor(@RequestParam String majorName, @RequestParam String academicYear, @RequestParam String semester)
    {
        startPage();
        List<TSemesterScoreDetail> list = tSemesterScoreDetailService.selectByMajorAndSemester(majorName, academicYear, semester);
        return getDataTable(list);
    }

    /**
     * 获取班级成绩统计
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/classStatistics")
    public AjaxResult getClassStatistics(@RequestParam String className, @RequestParam String academicYear, @RequestParam String semester)
    {
        Map<String, Object> statistics = tSemesterScoreDetailService.getClassScoreStatistics(className, academicYear, semester);
        return success(statistics);
    }

    /**
     * 获取专业成绩统计
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/majorStatistics")
    public AjaxResult getMajorStatistics(@RequestParam String majorName, @RequestParam String academicYear, @RequestParam String semester)
    {
        Map<String, Object> statistics = tSemesterScoreDetailService.getMajorScoreStatistics(majorName, academicYear, semester);
        return success(statistics);
    }

    /**
     * 获取班级排行榜
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/classRanking")
    public AjaxResult getClassRanking(@RequestParam String className, @RequestParam String academicYear, @RequestParam String semester)
    {
        List<TSemesterScoreDetail> ranking = tSemesterScoreDetailService.getClassRanking(className, academicYear, semester);
        return success(ranking);
    }

    /**
     * 获取专业排行榜
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/majorRanking")
    public AjaxResult getMajorRanking(@RequestParam String majorName, @RequestParam String academicYear, @RequestParam String semester)
    {
        List<TSemesterScoreDetail> ranking = tSemesterScoreDetailService.getMajorRanking(majorName, academicYear, semester);
        return success(ranking);
    }

    /**
     * 计算班级排名
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:edit')")
    @PostMapping("/calculateClassRanking")
    public AjaxResult calculateClassRanking(@RequestParam String className, @RequestParam String academicYear, @RequestParam String semester)
    {
        tSemesterScoreDetailService.calculateClassRanking(className, academicYear, semester);
        return success("班级排名计算完成");
    }

    /**
     * 计算专业排名
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:edit')")
    @PostMapping("/calculateMajorRanking")
    public AjaxResult calculateMajorRanking(@RequestParam String majorName, @RequestParam String academicYear, @RequestParam String semester)
    {
        tSemesterScoreDetailService.calculateMajorRanking(majorName, academicYear, semester);
        return success("专业排名计算完成");
    }

    /**
     * 获取学生成绩趋势
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:list')")
    @GetMapping("/studentTrend")
    public AjaxResult getStudentScoreTrend(@RequestParam String studentId, @RequestParam(required = false) String dimension, @RequestParam(required = false) String timeRange)
    {
        TSemesterScoreDetail queryParam = new TSemesterScoreDetail();
        queryParam.setStudentId(studentId);
        List<TSemesterScoreDetail> trendData = tSemesterScoreDetailService.selectTSemesterScoreDetailList(queryParam);
        return success(trendData);
    }

    /**
     * 导出学期成绩明细列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:export')")
    @Log(title = "学期成绩明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TSemesterScoreDetail tSemesterScoreDetail)
    {
        // 检查用户是否有导出权限
        if (!evaluationPermissionService.canExportData())
        {
            return;
        }
        
        List<TSemesterScoreDetail> list = tSemesterScoreDetailService.selectTSemesterScoreDetailList(tSemesterScoreDetail);
        
        // 根据用户权限过滤数据
        list = evaluationPermissionService.filterScoreDataByPermission(list);
        
        ExcelUtil<TSemesterScoreDetail> util = new ExcelUtil<TSemesterScoreDetail>(TSemesterScoreDetail.class);
        util.exportExcel(response, list, "学期成绩明细数据");
    }

    /**
     * 获取学期成绩明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tSemesterScoreDetailService.selectTSemesterScoreDetailById(id));
    }

    /**
     * 新增学期成绩明细
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:add')")
    @Log(title = "学期成绩明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TSemesterScoreDetail tSemesterScoreDetail)
    {
        // 检查用户是否有权限编辑该学生数据
        if (!evaluationPermissionService.canEditStudentScore(tSemesterScoreDetail.getStudentId()))
        {
            return error("无权限操作该学生数据");
        }
        
        return toAjax(tSemesterScoreDetailService.insertTSemesterScoreDetail(tSemesterScoreDetail));
    }

    /**
     * 修改学期成绩明细
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:edit')")
    @Log(title = "学期成绩明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TSemesterScoreDetail tSemesterScoreDetail)
    {
        // 检查用户是否有权限编辑该学生数据
        if (!evaluationPermissionService.canEditStudentScore(tSemesterScoreDetail.getStudentId()))
        {
            return error("无权限操作该学生数据");
        }
        
        return toAjax(tSemesterScoreDetailService.updateTSemesterScoreDetail(tSemesterScoreDetail));
    }

    /**
     * 删除学期成绩明细
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:remove')")
    @Log(title = "学期成绩明细", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        // 检查用户是否有权限删除数据
        if (!evaluationPermissionService.isEvaluationAdmin())
        {
            return error("只有管理员可以删除成绩数据");
        }
        
        return toAjax(tSemesterScoreDetailService.deleteTSemesterScoreDetailByIds(ids));
    }

    /**
     * 批量计算综合成绩
     */
    @PreAuthorize("@ss.hasPermi('evaluation:semesterScore:edit')")
    @PostMapping("/batchCalculate")
    public AjaxResult batchCalculateComprehensiveScore(@RequestBody List<Long> ids)
    {
        int successCount = 0;
        List<Long> failedIds = new ArrayList<>();
        for (Long id : ids) {
            try {
                TSemesterScoreDetail detail = tSemesterScoreDetailService.selectTSemesterScoreDetailById(id);
                if (detail != null) {
                    detail = tSemesterScoreDetailService.calculateComprehensiveScore(detail);
                    tSemesterScoreDetailService.updateTSemesterScoreDetail(detail);
                    successCount++;
                } else {
                    failedIds.add(id);
                }
            } catch (Exception e) {
                failedIds.add(id);
            }
        }
        Map<String, Object> result = new HashMap<>();
        result.put("successCount", successCount);
        result.put("failedIds", failedIds);
        if (failedIds.isEmpty()) {
            return AjaxResult.success("成功计算" + successCount + "条记录的综合成绩", result);
        } else {
            return AjaxResult.warn("部分记录计算失败，成功计算" + successCount + "条记录", result);
        }
    }

    /**
     * 下载导入模板
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:import')")
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) throws IOException
    {
        // 检查用户是否有导入权限
        if (!evaluationPermissionService.canImportData())
        {
            return;
        }
        
        try {
            Workbook workbook = ExcelImportUtils.generateImportTemplate();
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            String fileName = URLEncoder.encode("综测成绩导入模板", "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            logger.error("下载导入模板失败", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Excel文件上传解析
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:import')")
    @PostMapping("/import")
    public AjaxResult uploadExcel(@RequestParam("file") MultipartFile file)
    {
        // 检查用户是否有导入权限
        if (!evaluationPermissionService.canImportData())
        {
            return error("无权限导入数据");
        }
        
        try {
            List<TSemesterScoreDetail> scoreDetails = ExcelImportUtils.importExcel(file);
            return success(scoreDetails);
        } catch (Exception e) {
            logger.error("Excel文件解析失败", e);
            return error("文件解析失败：" + e.getMessage());
        }
    }

    /**
     * 验证导入数据
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:import')")
    @PostMapping("/validateImport")
    public AjaxResult validateImportData(@RequestBody List<TSemesterScoreDetail> scoreDetails)
    {
        // 检查用户是否有导入权限
        if (!evaluationPermissionService.canImportData())
        {
            return error("无权限导入数据");
        }
        
        try {
            Map<String, Object> result = ExcelImportUtils.validateImportData(scoreDetails);
            return success(result);
        } catch (Exception e) {
            logger.error("数据验证失败", e);
            return error("数据验证失败：" + e.getMessage());
        }
    }

    /**
     * 确认导入数据
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:import')")
    @Log(title = "学期成绩明细", businessType = BusinessType.IMPORT)
    @PostMapping("/confirmImport")
    public AjaxResult confirmImportData(@RequestBody List<TSemesterScoreDetail> scoreDetails)
    {
        // 检查用户是否有导入权限
        if (!evaluationPermissionService.canImportData())
        {
            return error("无权限导入数据");
        }
        
        try {
            // 先验证数据
            Map<String, Object> validationResult = ExcelImportUtils.validateImportData(scoreDetails);
            if (!(Boolean) validationResult.get("success")) {
                return error("数据验证未通过，无法导入");
            }

            // 批量导入数据
            int successCount = 0;
            List<String> errors = new ArrayList<>();
            
            for (TSemesterScoreDetail scoreDetail : scoreDetails) {
                try {
                    // 检查是否已存在相同记录
                    TSemesterScoreDetail existingRecord = tSemesterScoreDetailService.selectByStudentAndSemester(
                        scoreDetail.getStudentId(), scoreDetail.getAcademicYear(), String.valueOf(scoreDetail.getSemester()));
                    
                    if (existingRecord != null) {
                        // 更新现有记录
                        scoreDetail.setId(existingRecord.getId());
                        scoreDetail.setUpdateTime(new Date());
                        tSemesterScoreDetailService.updateTSemesterScoreDetail(scoreDetail);
                    } else {
                        // 新增记录
                        scoreDetail.setCreateTime(new Date());
                        tSemesterScoreDetailService.insertTSemesterScoreDetail(scoreDetail);
                    }
                    successCount++;
                } catch (Exception e) {
                    errors.add("学生" + scoreDetail.getStudentName() + "数据导入失败：" + e.getMessage());
                }
            }

            Map<String, Object> result = new HashMap<>();
            result.put("successCount", successCount);
            result.put("totalCount", scoreDetails.size());
            result.put("errors", errors);
            
            if (errors.isEmpty()) {
                return AjaxResult.success("导入成功，共导入" + successCount + "条记录", result);
            } else {
                return warn("部分数据导入失败，成功导入" + successCount + "条记录");
            }
        } catch (Exception e) {
            logger.error("数据导入失败", e);
            return error("数据导入失败：" + e.getMessage());
        }
    }
}