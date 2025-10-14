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
import com.ruoyi.system.domain.TStudentTotalScore;
import com.ruoyi.system.service.ITStudentTotalScoreService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学生总成绩Controller
 * 
 * @author ruoyi
 * @date 2025-10-01
 */
@RestController
@RequestMapping("/evaluation/t_student_total_score")
public class TStudentTotalScoreController extends BaseController
{
    @Autowired
    private ITStudentTotalScoreService tStudentTotalScoreService;

    /**
     * 查询学生总成绩列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_total_score:list')")
    @GetMapping("/list")
    public TableDataInfo list(TStudentTotalScore tStudentTotalScore)
    {
        startPage();
        List<TStudentTotalScore> list = tStudentTotalScoreService.selectTStudentTotalScoreList(tStudentTotalScore);
        return getDataTable(list);
    }

    /**
     * 导出学生总成绩列表
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_total_score:export')")
    @Log(title = "学生总成绩", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, TStudentTotalScore tStudentTotalScore)
    {
        List<TStudentTotalScore> list = tStudentTotalScoreService.selectTStudentTotalScoreList(tStudentTotalScore);
        ExcelUtil<TStudentTotalScore> util = new ExcelUtil<TStudentTotalScore>(TStudentTotalScore.class);
        util.exportExcel(response, list, "学生总成绩数据");
    }

    /**
     * 获取学生总成绩详细信息
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_total_score:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tStudentTotalScoreService.selectTStudentTotalScoreById(id));
    }

    /**
     * 新增学生总成绩
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_total_score:add')")
    @Log(title = "学生总成绩", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TStudentTotalScore tStudentTotalScore)
    {
        return toAjax(tStudentTotalScoreService.insertTStudentTotalScore(tStudentTotalScore));
    }

    /**
     * 修改学生总成绩
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_total_score:edit')")
    @Log(title = "学生总成绩", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TStudentTotalScore tStudentTotalScore)
    {
        return toAjax(tStudentTotalScoreService.updateTStudentTotalScore(tStudentTotalScore));
    }

    /**
     * 删除学生总成绩
     */
    @PreAuthorize("@ss.hasPermi('evaluation:t_student_total_score:remove')")
    @Log(title = "学生总成绩", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tStudentTotalScoreService.deleteTStudentTotalScoreByIds(ids));
    }
}
