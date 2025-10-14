package com.ruoyi.web.controller.evaluation;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.system.domain.TUserProfile;
import com.ruoyi.system.service.ITUserProfileService;
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
 * 学生档案管理Controller
 * 
 * @author ruoyi
 * @date 2025-09-27
 */
@RestController
@RequestMapping("/evaluation/t_user_profile")
public class TUserProfileController extends BaseController
{
    @Autowired
    private ITUserProfileService tUserProfileService;

    /**
     * 查询学生档案管理列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_user_profile:list')")
    @GetMapping("/list")
    public TableDataInfo list(TUserProfile tUserProfile)
    {
        startPage();
        List<TUserProfile> list = tUserProfileService.selectTUserProfileList(tUserProfile);
        return getDataTable(list);
    }

    /**
     * 导出学生档案管理列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_user_profile:export')")
    @Log(title = "学生档案管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TUserProfile tUserProfile)
    {
        List<TUserProfile> list = tUserProfileService.selectTUserProfileList(tUserProfile);
        ExcelUtil<TUserProfile> util = new ExcelUtil<TUserProfile>(TUserProfile.class);
        util.exportExcel(response, list, "学生档案管理数据");
    }

    /**
     * 获取学生档案管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_user_profile:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tUserProfileService.selectTUserProfileById(id));
    }

    /**
     * 新增学生档案管理
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_user_profile:add')")
    @Log(title = "学生档案管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TUserProfile tUserProfile)
    {
        return toAjax(tUserProfileService.insertTUserProfile(tUserProfile));
    }

    /**
     * 修改学生档案管理
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_user_profile:edit')")
    @Log(title = "学生档案管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TUserProfile tUserProfile)
    {
        return toAjax(tUserProfileService.updateTUserProfile(tUserProfile));
    }

    /**
     * 删除学生档案管理
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_user_profile:remove')")
    @Log(title = "学生档案管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tUserProfileService.deleteTUserProfileByIds(ids));
    }
}
