package com.ruoyi.web.controller.evaluation;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.system.domain.TCollegeInfo;
import com.ruoyi.system.service.ITCollegeInfoService;
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
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学院信息Controller
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
@RestController
@RequestMapping("/evaluation/college_info")
public class TCollegeInfoController extends BaseController
{
    @Autowired
    private ITCollegeInfoService tCollegeInfoService;

    /**
     * 查询学院信息列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:college_info:list')")
    @GetMapping("/list")
    public TableDataInfo list(TCollegeInfo tCollegeInfo)
    {
        startPage();
        List<TCollegeInfo> list = tCollegeInfoService.selectTCollegeInfoList(tCollegeInfo);
        return getDataTable(list);
    }

    /**
     * 导出学院信息列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:college_info:export')")
    @Log(title = "学院信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TCollegeInfo tCollegeInfo)
    {
        List<TCollegeInfo> list = tCollegeInfoService.selectTCollegeInfoList(tCollegeInfo);
        ExcelUtil<TCollegeInfo> util = new ExcelUtil<TCollegeInfo>(TCollegeInfo.class);
        util.exportExcel(response, list, "学院信息数据");
    }

    /**
     * 获取学院信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:college_info:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tCollegeInfoService.selectTCollegeInfoById(id));
    }

    /**
     * 新增学院信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:college_info:add')")
    @Log(title = "学院信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TCollegeInfo tCollegeInfo)
    {
        return toAjax(tCollegeInfoService.insertTCollegeInfo(tCollegeInfo));
    }

    /**
     * 修改学院信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:college_info:edit')")
    @Log(title = "学院信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TCollegeInfo tCollegeInfo)
    {
        return toAjax(tCollegeInfoService.updateTCollegeInfo(tCollegeInfo));
    }

    /**
     * 删除学院信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:college_info:remove')")
    @Log(title = "学院信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tCollegeInfoService.deleteTCollegeInfoByIds(ids));
    }
}
