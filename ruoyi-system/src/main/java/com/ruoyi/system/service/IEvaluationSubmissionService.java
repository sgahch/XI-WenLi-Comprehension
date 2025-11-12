package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.EvaluationSubmission;
import com.ruoyi.system.domain.dto.AuditRequest;
import com.ruoyi.system.domain.dto.BatchAuditRequest;

/**
 * 综测填报Service接口
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public interface IEvaluationSubmissionService 
{
    /**
     * 查询综测填报
     * 
     * @param id 综测填报主键
     * @return 综测填报
     */
    public EvaluationSubmission selectEvaluationSubmissionById(Long id);

    /**
     * 查询综测填报列表
     *
     * @param evaluationSubmission 综测填报
     * @return 综测填报集合
     */
    public List<EvaluationSubmission> selectEvaluationSubmissionList(EvaluationSubmission evaluationSubmission);

    /**
     * 根据角色查询综测填报列表（自动过滤状态）
     * 班委：查询 status=1（待班委审核）
     * 辅导员：查询 status=2（待辅导员审核）
     * 管理员：查询所有状态
     *
     * @param evaluationSubmission 综测填报
     * @return 综测填报集合
     */
    public List<EvaluationSubmission> selectEvaluationSubmissionListByRole(EvaluationSubmission evaluationSubmission);

    /**
     * 新增综测填报
     * 
     * @param evaluationSubmission 综测填报
     * @return 结果
     */
    public int insertEvaluationSubmission(EvaluationSubmission evaluationSubmission);

    /**
     * 保存或更新综测填报（智能判断insert/update）
     *
     * @param evaluationSubmission 综测填报
     * @return 保存后的对象（包含ID）
     */
    public EvaluationSubmission saveOrUpdateEvaluationSubmission(EvaluationSubmission evaluationSubmission);

    /**
     * 修改综测填报
     * 
     * @param evaluationSubmission 综测填报
     * @return 结果
     */
    public int updateEvaluationSubmission(EvaluationSubmission evaluationSubmission);

    /**
     * 批量删除综测填报
     * 
     * @param ids 需要删除的综测填报主键集合
     * @return 结果
     */
    public int deleteEvaluationSubmissionByIds(Long[] ids);

    /**
     * 删除综测填报信息
     * 
     * @param id 综测填报主键
     * @return 结果
     */
    public int deleteEvaluationSubmissionById(Long id);

    /**
     * 查询学生填报历史
     * 
     * @param evaluationSubmission 查询条件
     * @return 填报历史列表
     */
    public List<EvaluationSubmission> selectSubmissionHistory(EvaluationSubmission evaluationSubmission);

    /**
     * 获取填报统计数据
     * 
     * @param evaluationSubmission 查询条件
     * @return 统计数据
     */
    public Map<String, Object> getSubmissionStatistics(EvaluationSubmission evaluationSubmission);

    /**
     * 执行审核操作
     * 
     * @param auditRequest 审核请求
     * @return 审核结果
     */
    public Map<String, Object> auditSubmission(AuditRequest auditRequest);

    /**
     * 批量审核操作
     *
     * @param batchAuditRequest 批量审核请求
     * @return 批量审核结果
     */
    public Map<String, Object> batchAuditSubmission(BatchAuditRequest batchAuditRequest);

    /**
     * 查询学生在指定学年学期的提交记录
     *
     * @param userId 用户ID
     * @param academicYear 学年
     * @param semester 学期
     * @return 提交记录，如果不存在则返回null
     */
    public EvaluationSubmission selectByUserAndSemester(Long userId, String academicYear, Integer semester);
}