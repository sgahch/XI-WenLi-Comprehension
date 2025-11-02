package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EvaluationAuditLog;

/**
 * 审核日志Service接口
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
public interface IEvaluationAuditLogService 
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
     * 批量删除审核日志
     * 
     * @param ids 需要删除的审核日志主键集合
     * @return 结果
     */
    public int deleteEvaluationAuditLogByIds(Long[] ids);

    /**
     * 删除审核日志信息
     * 
     * @param id 审核日志主键
     * @return 结果
     */
    public int deleteEvaluationAuditLogById(Long id);

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

    /**
     * 记录审核日志
     * 
     * @param submissionId 填报ID
     * @param detailId 详情ID
     * @param operation 操作类型
     * @param remark 审核意见
     * @param auditorId 审核人ID
     * @param oldStatus 原状态
     * @param newStatus 新状态
     * @param ipAddress IP地址
     * @return 结果
     */
    public int recordAuditLog(Long submissionId, Long detailId, String operation, 
                             String remark, Long auditorId, Integer oldStatus, 
                             Integer newStatus, String ipAddress);
}