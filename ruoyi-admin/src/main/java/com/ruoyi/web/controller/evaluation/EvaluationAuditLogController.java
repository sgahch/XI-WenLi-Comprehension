package com.ruoyi.web.controller.evaluation;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.EvaluationAuditLog;
import com.ruoyi.system.service.IEvaluationAuditLogService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 审核日志Controller
 * 
 * @author ruoyi
 * @date 2025-11-03
 */
@RestController
@RequestMapping("/evaluation/auditLog")
public class EvaluationAuditLogController extends BaseController
{
    @Autowired
    private IEvaluationAuditLogService evaluationAuditLogService;

    /**
     * 查询审核日志列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:list')")
    @GetMapping("/list")
    public TableDataInfo list(EvaluationAuditLog evaluationAuditLog)
    {
        startPage();
        List<EvaluationAuditLog> list = evaluationAuditLogService.selectEvaluationAuditLogList(evaluationAuditLog);
        return getDataTable(list);
    }

    /**
     * 导出审核日志列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:export')")
    @Log(title = "审核日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EvaluationAuditLog evaluationAuditLog)
    {
        List<EvaluationAuditLog> list = evaluationAuditLogService.selectEvaluationAuditLogList(evaluationAuditLog);
        ExcelUtil<EvaluationAuditLog> util = new ExcelUtil<EvaluationAuditLog>(EvaluationAuditLog.class);
        util.exportExcel(response, list, "审核日志数据");
    }

    /**
     * 获取审核日志详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(evaluationAuditLogService.selectEvaluationAuditLogById(id));
    }

    /**
     * 根据填报ID查询审核日志
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:query')")
    @GetMapping("/submission/{submissionId}")
    public AjaxResult getBySubmissionId(@PathVariable("submissionId") Long submissionId)
    {
        List<EvaluationAuditLog> list = evaluationAuditLogService.selectEvaluationAuditLogBySubmissionId(submissionId);
        return success(list);
    }

    /**
     * 根据详情ID查询审核日志
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:query')")
    @GetMapping("/detail/{detailId}")
    public AjaxResult getByDetailId(@PathVariable("detailId") Long detailId)
    {
        List<EvaluationAuditLog> list = evaluationAuditLogService.selectEvaluationAuditLogByDetailId(detailId);
        return success(list);
    }

    /**
     * 新增审核日志
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:add')")
    @Log(title = "审核日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EvaluationAuditLog evaluationAuditLog)
    {
        return toAjax(evaluationAuditLogService.insertEvaluationAuditLog(evaluationAuditLog));
    }

    /**
     * 修改审核日志
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:edit')")
    @Log(title = "审核日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EvaluationAuditLog evaluationAuditLog)
    {
        return toAjax(evaluationAuditLogService.updateEvaluationAuditLog(evaluationAuditLog));
    }

    /**
     * 删除审核日志
     */
    @PreAuthorize("@ss.hasPermi('evaluation:auditLog:remove')")
    @Log(title = "审核日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(evaluationAuditLogService.deleteEvaluationAuditLogByIds(ids));
    }
}

