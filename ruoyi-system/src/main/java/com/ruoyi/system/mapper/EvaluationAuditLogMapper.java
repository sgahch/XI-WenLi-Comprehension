package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EvaluationAuditLog;

/**
 * 审核日志Mapper接口
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public interface EvaluationAuditLogMapper 
{
    /**
     * 查询审核日志
     * 
     * @param id 审核日志主键
     * @return 审核日志
     */
    public EvaluationAuditLog selectEvaluationAuditLogById(Long id);

    /**
     * 查询审核日志列表
     * 
     * @param evaluationAuditLog 审核日志
     * @return 审核日志集合
     */
    public List<EvaluationAuditLog> selectEvaluationAuditLogList(EvaluationAuditLog evaluationAuditLog);

    /**
     * 新增审核日志
     * 
     * @param evaluationAuditLog 审核日志
     * @return 结果
     */
    public int insertEvaluationAuditLog(EvaluationAuditLog evaluationAuditLog);

    /**
     * 修改审核日志
     * 
     * @param evaluationAuditLog 审核日志
     * @return 结果
     */
    public int updateEvaluationAuditLog(EvaluationAuditLog evaluationAuditLog);

    /**
     * 删除审核日志
     * 
     * @param id 审核日志主键
     * @return 结果
     */
    public int deleteEvaluationAuditLogById(Long id);

    /**
     * 批量删除审核日志
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEvaluationAuditLogByIds(Long[] ids);

    /**
     * 根据填报ID查询审核日志
     * 
     * @param submissionId 填报ID
     * @return 审核日志集合
     */
    public List<EvaluationAuditLog> selectEvaluationAuditLogBySubmissionId(Long submissionId);

    /**
     * 根据详情ID查询审核日志
     * 
     * @param detailId 详情ID
     * @return 审核日志集合
     */
    public List<EvaluationAuditLog> selectEvaluationAuditLogByDetailId(Long detailId);
}