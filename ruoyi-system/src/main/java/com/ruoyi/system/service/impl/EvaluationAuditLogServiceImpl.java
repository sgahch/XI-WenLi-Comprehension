package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.EvaluationAuditLogMapper;
import com.ruoyi.system.domain.EvaluationAuditLog;
import com.ruoyi.system.service.IEvaluationAuditLogService;

/**
 * 审核日志Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
@Service
public class EvaluationAuditLogServiceImpl implements IEvaluationAuditLogService 
{
    @Autowired
    private EvaluationAuditLogMapper evaluationAuditLogMapper;

    /**
     * 查询审核日志
     * 
     * @param id 审核日志主键
     * @return 审核日志
     */
    @Override
    public EvaluationAuditLog selectEvaluationAuditLogById(Long id)
    {
        return evaluationAuditLogMapper.selectEvaluationAuditLogById(id);
    }

    /**
     * 查询审核日志列表
     * 
     * @param evaluationAuditLog 审核日志
     * @return 审核日志
     */
    @Override
    public List<EvaluationAuditLog> selectEvaluationAuditLogList(EvaluationAuditLog evaluationAuditLog)
    {
        return evaluationAuditLogMapper.selectEvaluationAuditLogList(evaluationAuditLog);
    }

    /**
     * 新增审核日志
     * 
     * @param evaluationAuditLog 审核日志
     * @return 结果
     */
    @Override
    public int insertEvaluationAuditLog(EvaluationAuditLog evaluationAuditLog)
    {
        return evaluationAuditLogMapper.insertEvaluationAuditLog(evaluationAuditLog);
    }

    /**
     * 修改审核日志
     * 
     * @param evaluationAuditLog 审核日志
     * @return 结果
     */
    @Override
    public int updateEvaluationAuditLog(EvaluationAuditLog evaluationAuditLog)
    {
        return evaluationAuditLogMapper.updateEvaluationAuditLog(evaluationAuditLog);
    }

    /**
     * 批量删除审核日志
     * 
     * @param ids 需要删除的审核日志主键
     * @return 结果
     */
    @Override
    public int deleteEvaluationAuditLogByIds(Long[] ids)
    {
        return evaluationAuditLogMapper.deleteEvaluationAuditLogByIds(ids);
    }

    /**
     * 删除审核日志信息
     * 
     * @param id 审核日志主键
     * @return 结果
     */
    @Override
    public int deleteEvaluationAuditLogById(Long id)
    {
        return evaluationAuditLogMapper.deleteEvaluationAuditLogById(id);
    }

    /**
     * 根据填报ID查询审核日志
     * 
     * @param submissionId 填报ID
     * @return 审核日志集合
     */
    @Override
    public List<EvaluationAuditLog> selectEvaluationAuditLogBySubmissionId(Long submissionId)
    {
        return evaluationAuditLogMapper.selectEvaluationAuditLogBySubmissionId(submissionId);
    }

    /**
     * 根据详情ID查询审核日志
     * 
     * @param detailId 详情ID
     * @return 审核日志集合
     */
    @Override
    public List<EvaluationAuditLog> selectEvaluationAuditLogByDetailId(Long detailId)
    {
        return evaluationAuditLogMapper.selectEvaluationAuditLogByDetailId(detailId);
    }

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
    @Override
    public int recordAuditLog(Long submissionId, Long detailId, String operation, 
                             String remark, Long auditorId, Integer oldStatus, 
                             Integer newStatus, String ipAddress)
    {
        EvaluationAuditLog auditLog = new EvaluationAuditLog();
        auditLog.setSubmissionId(submissionId);
        auditLog.setDetailId(detailId);
        auditLog.setOperation(operation);
        auditLog.setRemark(remark);
        auditLog.setAuditorId(auditorId);
        auditLog.setOldStatus(oldStatus);
        auditLog.setNewStatus(newStatus);
        auditLog.setIpAddress(ipAddress);
        auditLog.setAuditTime(new Date());
        
        return evaluationAuditLogMapper.insertEvaluationAuditLog(auditLog);
    }
}