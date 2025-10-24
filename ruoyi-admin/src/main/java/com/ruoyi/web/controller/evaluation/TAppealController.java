package com.ruoyi.web.controller.evaluation;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.TAppeal;
import com.ruoyi.system.service.ITAppealService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 申诉Controller
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
@RestController
@RequestMapping("/evaluation/t_appeal")
public class TAppealController extends BaseController
{
    @Autowired
    private ITAppealService tAppealService;

    /**
     * 查询申诉列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_appeal:list')")
    @GetMapping("/list")
    public TableDataInfo list(TAppeal tAppeal)
    {
        startPage();
        List<TAppeal> list = tAppealService.selectTAppealList(tAppeal);
        return getDataTable(list);
    }

    /**
     * 导出申诉列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_appeal:export')")
    @Log(title = "申诉", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TAppeal tAppeal)
    {
        List<TAppeal> list = tAppealService.selectTAppealList(tAppeal);
        ExcelUtil<TAppeal> util = new ExcelUtil<TAppeal>(TAppeal.class);
        util.exportExcel(response, list, "申诉数据");
    }

    /**
     * 获取申诉详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_appeal:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tAppealService.selectTAppealById(id));
    }

    /**
     * 新增申诉
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_appeal:add')")
    @Log(title = "申诉", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TAppeal tAppeal)
    {
        return toAjax(tAppealService.insertTAppeal(tAppeal));
    }

    /**
     * 修改申诉
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_appeal:edit')")
    @Log(title = "申诉", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TAppeal tAppeal)
    {
        return toAjax(tAppealService.updateTAppeal(tAppeal));
    }

    /**
     * 删除申诉
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_appeal:remove')")
    @Log(title = "申诉", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tAppealService.deleteTAppealByIds(ids));
    }
}
