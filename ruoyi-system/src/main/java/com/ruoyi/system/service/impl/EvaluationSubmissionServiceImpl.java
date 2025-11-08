package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.constant.SubmissionStatusConstants;
import com.ruoyi.common.constant.AuditOperationConstants;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.system.mapper.EvaluationSubmissionMapper;
import com.ruoyi.system.domain.EvaluationSubmission;
import com.ruoyi.system.domain.dto.AuditRequest;
import com.ruoyi.system.domain.dto.BatchAuditRequest;
import com.ruoyi.system.service.IEvaluationSubmissionService;
import com.ruoyi.system.service.IEvaluationAuditLogService;
import com.ruoyi.system.service.SubmissionStateMachine;

/**
 * 综测填报Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-01-27
 */
@Service
public class EvaluationSubmissionServiceImpl implements IEvaluationSubmissionService 
{
    @Autowired
    private EvaluationSubmissionMapper evaluationSubmissionMapper;

    @Autowired
    private IEvaluationAuditLogService evaluationAuditLogService;

    @Autowired
    private SubmissionStateMachine submissionStateMachine;

    @Autowired
    private com.ruoyi.system.mapper.TEvaluationItemConfigMapper tEvaluationItemConfigMapper;

    @Autowired
    private com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper evaluationSubmissionDetailMapper;

    @Autowired
    private com.ruoyi.system.mapper.EvaluationAttachmentMapper evaluationAttachmentMapper;

    /**
     * 查询综测填报
     *
     * @param id 综测填报主键
     * @return 综测填报
     */
    @Override
    public EvaluationSubmission selectEvaluationSubmissionById(Long id)
    {
        EvaluationSubmission submission = evaluationSubmissionMapper.selectEvaluationSubmissionById(id);
        if (submission != null) {
            // 加载详情列表
            java.util.List<com.ruoyi.system.domain.EvaluationSubmissionDetail> details =
                evaluationSubmissionDetailMapper.selectBySubmissionId(id);

            // 为每个详情加载附件
            if (details != null && !details.isEmpty()) {
                for (com.ruoyi.system.domain.EvaluationSubmissionDetail detail : details) {
                    java.util.List<com.ruoyi.system.domain.EvaluationAttachment> attachments =
                        evaluationAttachmentMapper.selectByDetailId(detail.getId());
                    detail.setAttachments(attachments);
                }
            }

            submission.setDetails(details);
        }
        return submission;
    }

    /**
     * 查询综测填报列表
     * 
     * @param evaluationSubmission 综测填报
     * @return 综测填报
     */
    @Override
    public List<EvaluationSubmission> selectEvaluationSubmissionList(EvaluationSubmission evaluationSubmission)
    {
        return evaluationSubmissionMapper.selectEvaluationSubmissionList(evaluationSubmission);
    }

    /**
     * 新增综测填报
     * 
     * @param evaluationSubmission 综测填报
     * @return 结果
     */
    @Override
    @Transactional
    public int insertEvaluationSubmission(EvaluationSubmission evaluationSubmission)
    {
        // 从当前登录用户自动填充studentId
        Long userId = SecurityUtils.getUserId();
        evaluationSubmission.setStudentId(userId);
        
        evaluationSubmission.setCreateTime(DateUtils.getNowDate());
        evaluationSubmission.setCreateBy(SecurityUtils.getUsername());
        return evaluationSubmissionMapper.insertEvaluationSubmission(evaluationSubmission);
    }

    /**
     * 保存或更新综测填报（智能判断insert/update）
     *
     * @param evaluationSubmission 综测填报
     * @return 保存后的对象（包含ID）
     */
    @Override
    @Transactional
    public EvaluationSubmission saveOrUpdateEvaluationSubmission(EvaluationSubmission evaluationSubmission)
    {
        // 从当前登录用户自动填充studentId和userId
        Long userId = SecurityUtils.getUserId();
        evaluationSubmission.setStudentId(userId);
        evaluationSubmission.setUserId(userId);

        // 计算各维度分数与总分（基于 details.finalScore + 前端传来的dimensionType或从规则查询）
        if (evaluationSubmission.getDetails() != null && !evaluationSubmission.getDetails().isEmpty()) {
            java.math.BigDecimal moral = java.math.BigDecimal.ZERO;
            java.math.BigDecimal intellectual = java.math.BigDecimal.ZERO;
            java.math.BigDecimal physical = java.math.BigDecimal.ZERO;
            java.math.BigDecimal aesthetic = java.math.BigDecimal.ZERO;
            java.math.BigDecimal labor = java.math.BigDecimal.ZERO;

            for (com.ruoyi.system.domain.EvaluationSubmissionDetail d : evaluationSubmission.getDetails()) {
                if (d == null || d.getFinalScore() == null) {
                    continue;
                }

                // 优先从ruleSnapshot中获取dimensionType（前端传来的）
                Integer dimensionType = null;
                if (d.getRuleSnapshot() != null && !d.getRuleSnapshot().trim().isEmpty()) {
                    try {
                        com.alibaba.fastjson2.JSONObject snapshot = com.alibaba.fastjson2.JSON.parseObject(d.getRuleSnapshot());
                        dimensionType = snapshot.getInteger("dimensionType");
                    } catch (Exception e) {
                        // 解析失败，忽略
                    }
                }

                // 如果ruleSnapshot中没有dimensionType，则从规则配置表查询
                if (dimensionType == null && d.getRuleId() != null) {
                    com.ruoyi.system.domain.TEvaluationItemConfig cfg = tEvaluationItemConfigMapper.selectTEvaluationItemConfigById(d.getRuleId());
                    if (cfg != null && cfg.getDimensionType() != null) {
                        // t_evaluation_item_config表中的dimensionType编码：1=智育,2=德育,3=体育,4=美育,5=劳育
                        // 需要转换为前端编码：0=德育,1=智育,2=体育,3=美育,4=劳育
                        switch (cfg.getDimensionType()) {
                            case 1: dimensionType = 1; break; // 智育
                            case 2: dimensionType = 0; break; // 德育
                            case 3: dimensionType = 2; break; // 体育
                            case 4: dimensionType = 3; break; // 美育
                            case 5: dimensionType = 4; break; // 劳育
                        }
                    }
                }

                // 根据dimensionType累加分数（使用前端编码：0=德育,1=智育,2=体育,3=美育,4=劳育）
                if (dimensionType != null) {
                    switch (dimensionType) {
                        case 0: // 德育
                            moral = moral.add(d.getFinalScore());
                            break;
                        case 1: // 智育
                            intellectual = intellectual.add(d.getFinalScore());
                            break;
                        case 2: // 体育
                            physical = physical.add(d.getFinalScore());
                            break;
                        case 3: // 美育
                            aesthetic = aesthetic.add(d.getFinalScore());
                            break;
                        case 4: // 劳育
                            labor = labor.add(d.getFinalScore());
                            break;
                        default:
                            break;
                    }
                }
            }

            evaluationSubmission.setMoralScore(moral);
            evaluationSubmission.setIntellectualScore(intellectual);
            evaluationSubmission.setPhysicalScore(physical);
            evaluationSubmission.setAestheticScore(aesthetic);
            evaluationSubmission.setLaborScore(labor);
            evaluationSubmission.setTotalScore(moral.add(intellectual).add(physical).add(aesthetic).add(labor));
        }

        // 构建查询条件：根据学生ID、学年、学期查找是否存在记录
        EvaluationSubmission queryCondition = new EvaluationSubmission();
        queryCondition.setUserId(userId);
        queryCondition.setAcademicYear(evaluationSubmission.getAcademicYear());
        queryCondition.setSemester(evaluationSubmission.getSemester());
        
        // 查询是否存在相同学生、学年、学期的记录
        List<EvaluationSubmission> existingRecords = evaluationSubmissionMapper.selectEvaluationSubmissionList(queryCondition);
        
        if (existingRecords != null && !existingRecords.isEmpty()) {
            // 存在记录，执行更新操作
            EvaluationSubmission existingRecord = existingRecords.get(0);
            evaluationSubmission.setId(existingRecord.getId());
            evaluationSubmission.setUpdateTime(DateUtils.getNowDate());
            evaluationSubmission.setUpdateBy(SecurityUtils.getUsername());
            evaluationSubmissionMapper.updateEvaluationSubmission(evaluationSubmission);
            // 同步详情与附件
            Long submissionId = existingRecord.getId();
            syncDetailsAndAttachments(submissionId, evaluationSubmission.getDetails(), evaluationSubmission.getGradeScreenshotUrls());
            // 返回更新后的对象
            return evaluationSubmission;
        } else {
            // 不存在记录，执行插入操作
            evaluationSubmission.setCreateTime(DateUtils.getNowDate());
            evaluationSubmission.setCreateBy(SecurityUtils.getUsername());
            evaluationSubmissionMapper.insertEvaluationSubmission(evaluationSubmission);
            // 插入后根据条件再查一次以获取ID
            List<EvaluationSubmission> afterInsert = evaluationSubmissionMapper.selectEvaluationSubmissionList(queryCondition);
            if (afterInsert != null && !afterInsert.isEmpty()) {
                EvaluationSubmission inserted = afterInsert.get(0);
                evaluationSubmission.setId(inserted.getId());
                syncDetailsAndAttachments(inserted.getId(), evaluationSubmission.getDetails(), evaluationSubmission.getGradeScreenshotUrls());
            }
            // 返回插入后的对象（包含ID）
            return evaluationSubmission;
        }
    }

    /**
     * 修改综测填报
     * 
     * @param evaluationSubmission 综测填报
     * @return 结果
     */
    @Override
    @Transactional
    public int updateEvaluationSubmission(EvaluationSubmission evaluationSubmission)
    {
        evaluationSubmission.setUpdateTime(DateUtils.getNowDate());
        evaluationSubmission.setUpdateBy(SecurityUtils.getUsername());
        return evaluationSubmissionMapper.updateEvaluationSubmission(evaluationSubmission);
    }

    /**
     * 批量删除综测填报
     * 
     * @param ids 需要删除的综测填报主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteEvaluationSubmissionByIds(Long[] ids)
    {
        return evaluationSubmissionMapper.deleteEvaluationSubmissionByIds(ids);
    }

    /**
     * 删除综测填报信息
     * 
     * @param id 综测填报主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteEvaluationSubmissionById(Long id)
    {
        return evaluationSubmissionMapper.deleteEvaluationSubmissionById(id);
    }

    /**
     * 查询学生填报历史
     * 
     * @param evaluationSubmission 查询条件
     * @return 填报历史列表
     */
    @Override
    public List<EvaluationSubmission> selectSubmissionHistory(EvaluationSubmission evaluationSubmission)
    {
        // 如果没有指定用户ID，则使用当前登录用户
        if (evaluationSubmission.getUserId() == null) {
            evaluationSubmission.setUserId(SecurityUtils.getUserId());
        }
        return evaluationSubmissionMapper.selectEvaluationSubmissionList(evaluationSubmission);
    }

    /**
     * 获取填报统计数据
     * 
     * @param evaluationSubmission 查询条件
     * @return 统计数据
     */
    @Override
    public Map<String, Object> getSubmissionStatistics(EvaluationSubmission evaluationSubmission)
    {
        Map<String, Object> statistics = new HashMap<>();
        
        // 获取总数
        int totalCount = evaluationSubmissionMapper.countSubmissions(evaluationSubmission);
        statistics.put("totalCount", totalCount);

        // 获取各状态统计（返回列表，每个状态一条记录）
        List<Map<String, Object>> statusStats = evaluationSubmissionMapper.countByStatus(evaluationSubmission);
        statistics.put("statusStats", statusStats);

        // 获取各维度平均分
        Map<String, Object> scoreStats = evaluationSubmissionMapper.getAverageScores(evaluationSubmission);
        statistics.put("scoreStats", scoreStats);

        return statistics;
    }

    /**
     * 同步入库详情与附件
     * @param submissionId 填报ID
     * @param details 详情列表
     * @param gradeScreenshotUrls 成绩截图URL列表
     */
    private void syncDetailsAndAttachments(Long submissionId, java.util.List<com.ruoyi.system.domain.EvaluationSubmissionDetail> details, java.util.List<String> gradeScreenshotUrls) {
        if (submissionId == null) {
            return;
        }
        // 先清理历史详情
        evaluationSubmissionDetailMapper.deleteBySubmissionId(submissionId);

        if (details == null || details.isEmpty()) {
            // 即使没有详情，也要处理成绩截图
            if (gradeScreenshotUrls != null && !gradeScreenshotUrls.isEmpty()) {
                saveGradeScreenshots(submissionId, gradeScreenshotUrls);
            }
            return;
        }
        for (com.ruoyi.system.domain.EvaluationSubmissionDetail d : details) {
            if (d == null) continue;
            d.setSubmissionId(submissionId);
            d.setCreateTime(DateUtils.getNowDate());
            // 默认未审核状态：0
            if (d.getStatus() == null) {
                d.setStatus(0);
            }
            // 默认最终分数：0，避免NON NULL约束
            if (d.getFinalScore() == null) {
                d.setFinalScore(java.math.BigDecimal.ZERO);
            }
            // 确保ruleId不为空，如果为空则设置为0（表示无规则关联）
            if (d.getRuleId() == null) {
                d.setRuleId(0L);
            }
            // 默认创建/更新人与时间
            if (d.getCreateBy() == null || d.getCreateBy().trim().isEmpty()) {
                d.setCreateBy(SecurityUtils.getUsername());
            }
            if (d.getUpdateBy() == null || d.getUpdateBy().trim().isEmpty()) {
                d.setUpdateBy(SecurityUtils.getUsername());
            }
            if (d.getUpdateTime() == null) {
                d.setUpdateTime(DateUtils.getNowDate());
            }
            // 填充规则快照，避免插入空值
            if (d.getRuleSnapshot() == null || d.getRuleSnapshot().trim().isEmpty()) {
                String snapshot = "{}";
                if (d.getRuleId() != null && d.getRuleId() > 0) {
                    com.ruoyi.system.domain.TEvaluationItemConfig cfg = tEvaluationItemConfigMapper.selectTEvaluationItemConfigById(d.getRuleId());
                    if (cfg != null) {
                        StringBuilder sb = new StringBuilder();
                        sb.append('{')
                          .append("\"id\":").append(cfg.getId()).append(',')
                          .append("\"dimensionType\":").append(cfg.getDimensionType()).append(',')
                          .append("\"itemCode\":\"").append(cfg.getItemCode() == null ? "" : cfg.getItemCode().replace("\"", "\\\"")).append("\",")
                          .append("\"itemName\":\"").append(cfg.getItemName() == null ? "" : cfg.getItemName().replace("\"", "\\\"")).append("\",")
                          .append("\"maxScore\":").append(cfg.getMaxScore() == null ? "0" : cfg.getMaxScore()).append(',')
                          .append("\"minScore\":").append(cfg.getMinScore() == null ? "0" : cfg.getMinScore()).append(',')
                          .append("\"defaultScore\":").append(cfg.getDefaultScore() == null ? "0" : cfg.getDefaultScore()).append(',')
                          .append("\"scoreType\":").append(cfg.getScoreType() == null ? "0" : cfg.getScoreType()).append(',')
                          .append("\"weight\":").append(cfg.getWeight() == null ? "0" : cfg.getWeight())
                          .append('}');
                        snapshot = sb.toString();
                    }
                }
                d.setRuleSnapshot(snapshot);
            }
            evaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail(d);

            // 插入附件（如有）
            if (d.getAttachments() != null && !d.getAttachments().isEmpty() && d.getId() != null) {
                for (com.ruoyi.system.domain.EvaluationAttachment att : d.getAttachments()) {
                    if (att == null) continue;
                    att.setDetailId(d.getId());
                    att.setUploadTime(DateUtils.getNowDate());
                    att.setUploadBy(SecurityUtils.getUserId());
                    att.setCreateTime(DateUtils.getNowDate());
                    att.setUpdateTime(DateUtils.getNowDate());

                    // 确保必填字段不为空，优先使用前端传递的值
                    if (att.getOriginalName() == null || att.getOriginalName().trim().isEmpty()) {
                        // 如果前端没有传递原始文件名，尝试从fileName中提取
                        String fileName = att.getFileName();
                        if (fileName != null && !fileName.trim().isEmpty()) {
                            // 从文件路径中提取文件名
                            String extractedName = fileName.substring(fileName.lastIndexOf('/') + 1);
                            att.setOriginalName(extractedName);
                        } else {
                            att.setOriginalName("未知文件名.txt");
                        }
                    }
                    if (att.getFileName() == null || att.getFileName().trim().isEmpty()) {
                        att.setFileName("file_" + System.currentTimeMillis() + ".txt");
                    }
                    if (att.getFilePath() == null || att.getFilePath().trim().isEmpty()) {
                        // 如果没有filePath，使用fileName作为路径
                        String fileName = att.getFileName();
                        if (fileName != null && !fileName.trim().isEmpty()) {
                            att.setFilePath(fileName.startsWith("/") ? fileName : "/" + fileName);
                        } else {
                            att.setFilePath("/uploads/default/file_" + System.currentTimeMillis() + ".txt");
                        }
                    }
                    if (att.getFileType() == null || att.getFileType().trim().isEmpty()) {
                        // 尝试从文件名中提取扩展名
                        String fileName = att.getOriginalName() != null ? att.getOriginalName() : att.getFileName();
                        if (fileName != null && fileName.contains(".")) {
                            String extension = fileName.substring(fileName.lastIndexOf('.') + 1).toUpperCase();
                            att.setFileType(extension);
                        } else {
                            att.setFileType("TXT");
                        }
                    }
                    // 确保文件大小不为空
                    if (att.getFileSize() == null) {
                        // 如果前端没有传递文件大小，设置默认值为0
                        // 注意：在实际应用中，应该从文件流或文件对象中获取真实大小
                        att.setFileSize(0L);
                    }

                    // 确保 url 字段不为空
                    if (att.getUrl() == null || att.getUrl().trim().isEmpty()) {
                        // 如果前端没有传递 URL，尝试从 filePath 构建
                        String filePath = att.getFilePath();
                        if (filePath != null && !filePath.trim().isEmpty()) {
                            // 构建访问 URL，使用 /profile 前缀
                            att.setUrl(filePath.startsWith("/profile") ? filePath : "/profile" + filePath);
                        } else {
                            // 如果连 filePath 都没有，使用默认 URL
                            att.setUrl("/profile/uploads/default/file_" + System.currentTimeMillis() + ".txt");
                        }
                    }

                    // 确保 attachment_type 字段不为空（默认为证书材料）
                    if (att.getAttachmentType() == null || att.getAttachmentType().trim().isEmpty()) {
                        att.setAttachmentType(com.ruoyi.common.constant.AttachmentTypeConstants.CERTIFICATE);
                    }

                    evaluationAttachmentMapper.insertEvaluationAttachment(att);
                }
            }
        }

        // 处理成绩截图URL列表
        if (gradeScreenshotUrls != null && !gradeScreenshotUrls.isEmpty()) {
            saveGradeScreenshots(submissionId, gradeScreenshotUrls);
        }
    }

    /**
     * 保存成绩截图
     * @param submissionId 填报ID
     * @param gradeScreenshotUrls 成绩截图URL列表
     */
    private void saveGradeScreenshots(Long submissionId, java.util.List<String> gradeScreenshotUrls) {
        if (submissionId == null || gradeScreenshotUrls == null || gradeScreenshotUrls.isEmpty()) {
            return;
        }

        // 查找智育维度的detailId
        Long intellectualDetailId = findIntellectualDetailId(submissionId);

        if (intellectualDetailId == null) {
            // 如果没有智育维度的成果，不保存成绩截图
            System.out.println("警告：该填报记录中没有智育维度的成果，无法保存成绩截图");
            return;
        }

        // 为每个URL创建附件记录
        for (String url : gradeScreenshotUrls) {
            if (url == null || url.trim().isEmpty()) {
                continue;
            }

            com.ruoyi.system.domain.EvaluationAttachment attachment = new com.ruoyi.system.domain.EvaluationAttachment();
            attachment.setDetailId(intellectualDetailId);
            attachment.setUrl(url);
            attachment.setFileName(extractFileNameFromUrl(url));
            attachment.setOriginalName(extractFileNameFromUrl(url));
            attachment.setFilePath(url);
            attachment.setFileSize(0L); // 文件大小未知，设置为0
            attachment.setFileType(extractFileExtension(url));
            attachment.setAttachmentType(com.ruoyi.common.constant.AttachmentTypeConstants.GRADE_SCREENSHOT);
            attachment.setUploadBy(SecurityUtils.getUserId());
            attachment.setUploadTime(DateUtils.getNowDate());
            attachment.setCreateTime(DateUtils.getNowDate());
            attachment.setUpdateTime(DateUtils.getNowDate());

            evaluationAttachmentMapper.insertEvaluationAttachment(attachment);
        }
    }

    /**
     * 查找智育维度的detailId
     * @param submissionId 填报ID
     * @return 智育维度的detailId，如果不存在则返回null
     */
    private Long findIntellectualDetailId(Long submissionId) {
        java.util.List<com.ruoyi.system.domain.EvaluationSubmissionDetail> details =
            evaluationSubmissionDetailMapper.selectBySubmissionId(submissionId);

        for (com.ruoyi.system.domain.EvaluationSubmissionDetail detail : details) {
            String ruleSnapshotStr = detail.getRuleSnapshot();
            if (ruleSnapshotStr != null && !ruleSnapshotStr.isEmpty()) {
                try {
                    com.alibaba.fastjson2.JSONObject ruleSnapshot = com.alibaba.fastjson2.JSONObject.parseObject(ruleSnapshotStr);

                    // 尝试获取 dimensionType（数字类型）
                    Integer dimensionType = ruleSnapshot.getInteger("dimensionType");
                    if (dimensionType != null && dimensionType == 1) {
                        // dimensionType=1 表示智育维度
                        return detail.getId();
                    }

                    // 兼容旧版本：尝试获取 dimension（字符串类型）
                    String dimension = ruleSnapshot.getString("dimension");
                    if ("intellectual".equals(dimension)) {
                        return detail.getId();
                    }
                } catch (Exception e) {
                    System.out.println("解析ruleSnapshot失败: " + e.getMessage());
                }
            }
        }

        return null;
    }

    /**
     * 从URL中提取文件名
     * @param url 文件URL
     * @return 文件名
     */
    private String extractFileNameFromUrl(String url) {
        if (url == null || url.trim().isEmpty()) {
            return "unknown";
        }
        String[] parts = url.split("/");
        return parts[parts.length - 1];
    }

    /**
     * 从URL中提取文件扩展名
     * @param url 文件URL
     * @return 文件扩展名
     */
    private String extractFileExtension(String url) {
        String fileName = extractFileNameFromUrl(url);
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex > 0 && lastDotIndex < fileName.length() - 1) {
            return fileName.substring(lastDotIndex + 1);
        }
        return "jpg"; // 默认为jpg
    }

    /**
     * 执行审核操作
     *
     * @param auditRequest 审核请求
     * @return 审核结果
     */
    @Override
    @Transactional
    public Map<String, Object> auditSubmission(AuditRequest auditRequest)
    {
        Map<String, Object> result = new HashMap<>();

        try {
            // 获取当前审核人信息
            Long auditorId = SecurityUtils.getUserId();
            String auditorName = SecurityUtils.getUsername();
            List<Long> auditorRoleIds = SecurityUtils.getLoginUser().getUser().getRoles()
                    .stream()
                    .map(role -> role.getRoleId())
                    .collect(java.util.stream.Collectors.toList());

            // 验证审核操作类型
            if (!AuditOperationConstants.isValidOperation(auditRequest.getOperation())) {
                throw new RuntimeException("无效的审核操作类型: " + auditRequest.getOperation());
            }

            EvaluationSubmission submission = null;
            Integer oldStatus = null;
            Integer newStatus = null;

            // 处理整体审核
            if (auditRequest.getSubmissionId() != null) {
                submission = evaluationSubmissionMapper.selectEvaluationSubmissionById(auditRequest.getSubmissionId());
                if (submission == null) {
                    throw new RuntimeException("填报记录不存在");
                }

                oldStatus = submission.getStatus();

                // 验证审核权限
                if (!submissionStateMachine.canAudit(oldStatus, auditorRoleIds)) {
                    throw new RuntimeException("您无权审核此记录。当前状态: " + SubmissionStatusConstants.getStatusDesc(oldStatus));
                }

                // 使用状态机计算新状态
                newStatus = submissionStateMachine.calculateNextStatus(oldStatus, auditRequest.getOperation(), auditorRoleIds);

                // 更新填报记录状态
                submission.setStatus(newStatus);
                submission.setAuditTime(DateUtils.getNowDate());
                submission.setAuditBy(auditorId);
                submission.setAuditComment(auditRequest.getRemark());
                submission.setUpdateTime(DateUtils.getNowDate());
                submission.setUpdateBy(auditorName);

                evaluationSubmissionMapper.updateEvaluationSubmission(submission);

                // 记录状态流转描述
                String transitionDesc = submissionStateMachine.getTransitionDescription(oldStatus, newStatus, auditRequest.getOperation());
                result.put("transitionDescription", transitionDesc);
            }

            // 记录审核日志
            String ipAddress = IpUtils.getIpAddr(ServletUtils.getRequest());
            evaluationAuditLogService.recordAuditLog(auditRequest.getSubmissionId(), auditRequest.getDetailId(),
                          auditRequest.getOperation(), auditRequest.getRemark(),
                          auditorId, oldStatus, newStatus, ipAddress);

            // 构建返回结果
            result.put("submissionId", auditRequest.getSubmissionId());
            result.put("detailId", auditRequest.getDetailId());
            result.put("operation", auditRequest.getOperation());
            result.put("oldStatus", oldStatus);
            result.put("newStatus", newStatus);
            result.put("oldStatusDesc", SubmissionStatusConstants.getStatusDesc(oldStatus));
            result.put("newStatusDesc", SubmissionStatusConstants.getStatusDesc(newStatus));
            result.put("auditTime", DateUtils.getNowDate());
            result.put("auditorId", auditorId);
            result.put("auditorName", auditorName);
            result.put("remark", auditRequest.getRemark());
            result.put("success", true);

        } catch (IllegalStateException | IllegalArgumentException e) {
            // 业务逻辑异常
            result.put("success", false);
            result.put("message", e.getMessage());
            throw new RuntimeException(e.getMessage());
        } catch (Exception e) {
            // 系统异常
            result.put("success", false);
            result.put("message", "审核操作失败：" + e.getMessage());
            throw new RuntimeException("审核操作失败：" + e.getMessage());
        }

        return result;
    }

    /**
     * 批量审核操作
     * 
     * @param batchAuditRequest 批量审核请求
     * @return 批量审核结果
     */
    @Override
    @Transactional

    public Map<String, Object> batchAuditSubmission(BatchAuditRequest batchAuditRequest)
    {
        Map<String, Object> result = new HashMap<>();
        List<Map<String, Object>> successList = new ArrayList<>();
        List<Map<String, Object>> failList = new ArrayList<>();
        
        try {
            // 批量处理填报记录
            if (batchAuditRequest.getSubmissionIds() != null && !batchAuditRequest.getSubmissionIds().isEmpty()) {
                for (Long submissionId : batchAuditRequest.getSubmissionIds()) {
                    try {
                        AuditRequest singleRequest = new AuditRequest();
                        singleRequest.setSubmissionId(submissionId);
                        singleRequest.setOperation(batchAuditRequest.getOperation());
                        singleRequest.setRemark(batchAuditRequest.getRemark());
                        
                        Map<String, Object> singleResult = auditSubmission(singleRequest);
                        successList.add(singleResult);
                    } catch (Exception e) {
                        Map<String, Object> failItem = new HashMap<>();
                        failItem.put("submissionId", submissionId);
                        failItem.put("error", e.getMessage());
                        failList.add(failItem);
                    }
                }
            }
            
            // 批量处理详情记录
            if (batchAuditRequest.getDetailIds() != null && !batchAuditRequest.getDetailIds().isEmpty()) {
                for (Long detailId : batchAuditRequest.getDetailIds()) {
                    try {
                        AuditRequest singleRequest = new AuditRequest();
                        singleRequest.setDetailId(detailId);
                        singleRequest.setOperation(batchAuditRequest.getOperation());
                        singleRequest.setRemark(batchAuditRequest.getRemark());
                        
                        Map<String, Object> singleResult = auditSubmission(singleRequest);
                        successList.add(singleResult);
                    } catch (Exception e) {
                        Map<String, Object> failItem = new HashMap<>();
                        failItem.put("detailId", detailId);
                        failItem.put("error", e.getMessage());
                        failList.add(failItem);
                    }
                }
            }
            
            result.put("success", true);
            result.put("successCount", successList.size());
            result.put("failCount", failList.size());
            result.put("successList", successList);
            result.put("failList", failList);
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "批量审核操作失败：" + e.getMessage());
            throw new RuntimeException("批量审核操作失败：" + e.getMessage());
        }
        
        return result;
    }
}