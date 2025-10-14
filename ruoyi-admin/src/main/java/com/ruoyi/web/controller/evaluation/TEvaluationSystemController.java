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
import com.ruoyi.system.domain.TEvaluationSystem;
import com.ruoyi.system.service.ITEvaluationSystemService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 测评体系Controller
 * 
 * @author ynchen
 * @date 2025-10-01
 */
@RestController
@RequestMapping("/evaluation/t_evaluation")
public class TEvaluationSystemController extends BaseController
{
    @Autowired
    private ITEvaluationSystemService tEvaluationSystemService;

    /**
     * 查询测评体系列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_evaluation:list')")
    @GetMapping("/list")
    public TableDataInfo list(TEvaluationSystem tEvaluationSystem)
    {
        startPage();
        List<TEvaluationSystem> list = tEvaluationSystemService.selectTEvaluationSystemList(tEvaluationSystem);
        return getDataTable(list);
    }

    /**
     * 导出测评体系列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_evaluation:export')")
    @Log(title = "测评体系", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TEvaluationSystem tEvaluationSystem)
    {
        List<TEvaluationSystem> list = tEvaluationSystemService.selectTEvaluationSystemList(tEvaluationSystem);
        ExcelUtil<TEvaluationSystem> util = new ExcelUtil<TEvaluationSystem>(TEvaluationSystem.class);
        util.exportExcel(response, list, "测评体系数据");
    }

    /**
     * 获取测评体系详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_evaluation:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tEvaluationSystemService.selectTEvaluationSystemById(id));
    }

    /**
     * 新增测评体系
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_evaluation:add')")
    @Log(title = "测评体系", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TEvaluationSystem tEvaluationSystem)
    {
        return toAjax(tEvaluationSystemService.insertTEvaluationSystem(tEvaluationSystem));
    }

    /**
     * 修改测评体系
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_evaluation:edit')")
    @Log(title = "测评体系", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TEvaluationSystem tEvaluationSystem)
    {
        return toAjax(tEvaluationSystemService.updateTEvaluationSystem(tEvaluationSystem));
    }

    /**
     * 删除测评体系
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_evaluation:remove')")
    @Log(title = "测评体系", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tEvaluationSystemService.deleteTEvaluationSystemByIds(ids));
    }
}
