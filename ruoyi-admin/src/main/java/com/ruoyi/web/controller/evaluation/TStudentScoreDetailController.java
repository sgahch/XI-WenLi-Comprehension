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
import com.ruoyi.system.domain.TStudentScoreDetail;
import com.ruoyi.system.service.ITStudentScoreDetailService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生成绩明细Controller
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
@RestController
@RequestMapping("/evaluation/t_student_score_detail")
public class TStudentScoreDetailController extends BaseController
{
    @Autowired
    private ITStudentScoreDetailService tStudentScoreDetailService;

    /**
     * 查询学生成绩明细列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_score_detail:list')")
    @GetMapping("/list")
    public TableDataInfo list(TStudentScoreDetail tStudentScoreDetail)
    {
        startPage();
        List<TStudentScoreDetail> list = tStudentScoreDetailService.selectTStudentScoreDetailList(tStudentScoreDetail);
        return getDataTable(list);
    }

    /**
     * 导出学生成绩明细列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_score_detail:export')")
    @Log(title = "学生成绩明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TStudentScoreDetail tStudentScoreDetail)
    {
        List<TStudentScoreDetail> list = tStudentScoreDetailService.selectTStudentScoreDetailList(tStudentScoreDetail);
        ExcelUtil<TStudentScoreDetail> util = new ExcelUtil<TStudentScoreDetail>(TStudentScoreDetail.class);
        util.exportExcel(response, list, "学生成绩明细数据");
    }

    /**
     * 获取学生成绩明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_score_detail:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tStudentScoreDetailService.selectTStudentScoreDetailById(id));
    }

    /**
     * 新增学生成绩明细
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_score_detail:add')")
    @Log(title = "学生成绩明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TStudentScoreDetail tStudentScoreDetail)
    {
        return toAjax(tStudentScoreDetailService.insertTStudentScoreDetail(tStudentScoreDetail));
    }

    /**
     * 修改学生成绩明细
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_score_detail:edit')")
    @Log(title = "学生成绩明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TStudentScoreDetail tStudentScoreDetail)
    {
        return toAjax(tStudentScoreDetailService.updateTStudentScoreDetail(tStudentScoreDetail));
    }

    /**
     * 删除学生成绩明细
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_score_detail:remove')")
    @Log(title = "学生成绩明细", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tStudentScoreDetailService.deleteTStudentScoreDetailByIds(ids));
    }
}
