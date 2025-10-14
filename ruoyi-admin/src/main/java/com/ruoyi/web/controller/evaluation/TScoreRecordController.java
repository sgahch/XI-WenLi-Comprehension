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
import com.ruoyi.system.domain.TScoreRecord;
import com.ruoyi.system.service.ITScoreRecordService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 考评加分记录Controller
 * 
 * @author ruoyi
 * @date 2025-09-28
 */
@RestController
@RequestMapping("/evaluation/t_score_record")
public class TScoreRecordController extends BaseController
{
    @Autowired
    private ITScoreRecordService tScoreRecordService;

    /**
     * 查询考评加分记录列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_score_record:list')")
    @GetMapping("/list")
    public TableDataInfo list(TScoreRecord tScoreRecord)
    {
        startPage();
        List<TScoreRecord> list = tScoreRecordService.selectTScoreRecordList(tScoreRecord);
        return getDataTable(list);
    }

    /**
     * 导出考评加分记录列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_score_record:export')")
    @Log(title = "考评加分记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TScoreRecord tScoreRecord)
    {
        List<TScoreRecord> list = tScoreRecordService.selectTScoreRecordList(tScoreRecord);
        ExcelUtil<TScoreRecord> util = new ExcelUtil<TScoreRecord>(TScoreRecord.class);
        util.exportExcel(response, list, "考评加分记录数据");
    }

    /**
     * 获取考评加分记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_score_record:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tScoreRecordService.selectTScoreRecordById(id));
    }

    /**
     * 新增考评加分记录
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_score_record:add')")
    @Log(title = "考评加分记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TScoreRecord tScoreRecord)
    {
        return toAjax(tScoreRecordService.insertTScoreRecord(tScoreRecord));
    }

    /**
     * 修改考评加分记录
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_score_record:edit')")
    @Log(title = "考评加分记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TScoreRecord tScoreRecord)
    {
        return toAjax(tScoreRecordService.updateTScoreRecord(tScoreRecord));
    }

    /**
     * 删除考评加分记录
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_score_record:remove')")
    @Log(title = "考评加分记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tScoreRecordService.deleteTScoreRecordByIds(ids));
    }
}
