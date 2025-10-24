package com.ruoyi.web.controller.evaluation;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.TEvaluationItemConfig;
import com.ruoyi.system.service.ITEvaluationItemConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 评分项目配置 Controller
 */
@RestController
@RequestMapping("/evaluation/itemConfig")
public class TEvaluationItemConfigController extends BaseController {

    @Autowired
    private ITEvaluationItemConfigService itemConfigService;

    @GetMapping("/list")
    public TableDataInfo list(TEvaluationItemConfig query) {
        startPage();
        List<TEvaluationItemConfig> list = itemConfigService.selectTEvaluationItemConfigList(query);
        return getDataTable(list);
    }

    /**
     * 根据查询条件获取评分项目配置
     * 支持前端 GET /evaluation/itemConfig?dimensionType=xxx&status=xxx 调用
     */
    @GetMapping
    public AjaxResult getConfig(@RequestParam(required = false) String dimensionType,
                               @RequestParam(required = false) Integer status) {
        TEvaluationItemConfig query = new TEvaluationItemConfig();
        
        // 处理dimensionType字符串到整数的转换
        if (dimensionType != null && !dimensionType.isEmpty()) {
            Integer dimensionTypeInt = convertDimensionType(dimensionType);
            if (dimensionTypeInt != null) {
                query.setDimensionType(dimensionTypeInt);
            }
        }
        
        if (status != null) {
            query.setIsActive(status);
        }
        
        List<TEvaluationItemConfig> list = itemConfigService.selectTEvaluationItemConfigList(query);
        return AjaxResult.success(list);
    }
    
    /**
     * 维度类型字符串转换为整数
     * @param dimensionType 维度类型字符串
     * @return 对应的整数值
     */
    private Integer convertDimensionType(String dimensionType) {
        switch (dimensionType.toLowerCase()) {
            case "intellectual":
                return 1; // 智育
            case "moral":
                return 2; // 德育
            case "physical":
                return 3; // 体育
            case "aesthetic":
                return 4; // 美育
            case "labor":
                return 5; // 劳育
            default:
                // 如果是数字字符串，尝试直接转换
                try {
                    return Integer.parseInt(dimensionType);
                } catch (NumberFormatException e) {
                    return null;
                }
        }
    }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return AjaxResult.success(itemConfigService.selectTEvaluationItemConfigById(id));
    }

    @PostMapping
    public AjaxResult add(@Validated @RequestBody TEvaluationItemConfig config) {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        config.setCreateBy(user.getUserName());
        return toAjax(itemConfigService.insertTEvaluationItemConfig(config));
    }

    @PutMapping
    public AjaxResult edit(@Validated @RequestBody TEvaluationItemConfig config) {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        config.setUpdateBy(user.getUserName());
        return toAjax(itemConfigService.updateTEvaluationItemConfig(config));
    }

    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id) {
        return toAjax(itemConfigService.deleteTEvaluationItemConfigById(id));
    }

    @DeleteMapping("/batch/{ids}")
    public AjaxResult batchRemove(@PathVariable Long[] ids) {
        return toAjax(itemConfigService.deleteTEvaluationItemConfigByIds(ids));
    }

    @GetMapping("/byDimension/{dimensionType}")
    public AjaxResult getByDimension(@PathVariable Integer dimensionType) {
        return AjaxResult.success(itemConfigService.selectByDimensionType(dimensionType));
    }

    @GetMapping("/byDimension/{dimensionType}/active")
    public AjaxResult getActiveByDimension(@PathVariable Integer dimensionType) {
        return AjaxResult.success(itemConfigService.selectActiveDimensionItems(dimensionType));
    }

    @GetMapping("/validateCode/{itemCode}")
    public AjaxResult validateItemCode(@PathVariable String itemCode) {
        TEvaluationItemConfig cfg = new TEvaluationItemConfig();
        cfg.setItemCode(itemCode);
        boolean unique = "0".equals(itemConfigService.checkItemCodeUnique(cfg));
        return AjaxResult.success(unique);
    }

    @PutMapping("/status")
    public AjaxResult batchUpdateStatus(@RequestParam("ids") List<Long> ids, @RequestParam("status") Integer status) {
        Long[] arr = ids.toArray(new Long[0]);
        boolean ok = itemConfigService.batchUpdateStatus(arr, status);
        return AjaxResult.success(ok);
    }

    @GetMapping("/nextSortOrder/{dimensionType}")
    public AjaxResult getNextSortOrder(@PathVariable Integer dimensionType) {
        return AjaxResult.success(itemConfigService.getNextSortOrder(dimensionType));
    }
}