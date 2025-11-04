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
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.service.IEvaluationSubmissionService;
import com.ruoyi.system.domain.EvaluationSubmission;
import com.ruoyi.system.domain.dto.AuditRequest;
import com.ruoyi.system.domain.dto.BatchAuditRequest;

/**
 * 综测填报Controller
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
@RestController
@RequestMapping("/evaluation/submission")
public class EvaluationSubmissionController extends BaseController
{
    @Autowired
    private IEvaluationSubmissionService evaluationSubmissionService;

    /**
     * 查询综测填报列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:list')")
    @GetMapping("/list")
    public TableDataInfo list(EvaluationSubmission evaluationSubmission)
    {
        startPage();
        List<EvaluationSubmission> list = evaluationSubmissionService.selectEvaluationSubmissionList(evaluationSubmission);
        return getDataTable(list);
    }

    /**
     * 获取综测填报详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(evaluationSubmissionService.selectEvaluationSubmissionById(id));
    }

    /**
     * 新增综测填报
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:add')")
    @Log(title = "综测填报", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EvaluationSubmission evaluationSubmission)
    {
        EvaluationSubmission result = evaluationSubmissionService.saveOrUpdateEvaluationSubmission(evaluationSubmission);
        return success(result);
    }

    /**
     * 修改综测填报
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:edit')")
    @Log(title = "综测填报", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EvaluationSubmission evaluationSubmission)
    {
        return toAjax(evaluationSubmissionService.updateEvaluationSubmission(evaluationSubmission));
    }

    /**
     * 删除综测填报
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:remove')")
    @Log(title = "综测填报", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(evaluationSubmissionService.deleteEvaluationSubmissionByIds(ids));
    }

    /**
     * 获取学生填报历史
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:history')")
    @GetMapping("/history")
    public TableDataInfo history(EvaluationSubmission evaluationSubmission)
    {
        startPage();
        List<EvaluationSubmission> list = evaluationSubmissionService.selectSubmissionHistory(evaluationSubmission);
        return getDataTable(list);
    }

    /**
     * 获取填报统计数据
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:statistics')")
    @GetMapping("/statistics")
    public AjaxResult statistics(EvaluationSubmission evaluationSubmission)
    {
        return success(evaluationSubmissionService.getSubmissionStatistics(evaluationSubmission));
    }

    /**
     * 导出填报数据
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:export')")
    @Log(title = "综测填报", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EvaluationSubmission evaluationSubmission)
    {
        List<EvaluationSubmission> list = evaluationSubmissionService.selectEvaluationSubmissionList(evaluationSubmission);
        // TODO: 实现导出逻辑
    }

    /**
     * 执行审核操作
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:audit')")
    @Log(title = "综测审核", businessType = BusinessType.UPDATE)
    @PostMapping("/audit")
    public AjaxResult audit(@RequestBody AuditRequest auditRequest)
    {
        try {
            return success(evaluationSubmissionService.auditSubmission(auditRequest));
        } catch (Exception e) {
            logger.error("审核操作失败", e);
            return error("审核操作失败：" + e.getMessage());
        }
    }

    /**
     * 批量审核操作
     */
    @PreAuthorize("@ss.hasPermi('evaluation:submission:audit')")
    @Log(title = "综测批量审核", businessType = BusinessType.UPDATE)
    @PostMapping("/audit/batch")
    public AjaxResult batchAudit(@RequestBody BatchAuditRequest batchAuditRequest)
    {
        try {
            return success(evaluationSubmissionService.batchAuditSubmission(batchAuditRequest));
        } catch (Exception e) {
            logger.error("批量审核操作失败", e);
            return error("批量审核操作失败：" + e.getMessage());
        }
    }
}