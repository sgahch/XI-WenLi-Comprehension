-- =============================================
-- 学生综合素质测评系统 - 重构后完整建表脚本
-- 基于若依框架的数据库重构方案
-- =============================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- 第一部分：基础配置表（无外键依赖）
-- =============================================

-- ----------------------------
-- 学院信息表
-- ----------------------------
DROP TABLE IF EXISTS `t_college_info`;
CREATE TABLE `t_college_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '学院ID',
  `college_name` varchar(64) NOT NULL COMMENT '学院名称',
  `college_code` varchar(32) NOT NULL COMMENT '学院代码',
  `director_id` bigint DEFAULT NULL COMMENT '负责人ID（关联sys_user）',
  `status` tinyint DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_college_code` (`college_code`),
  KEY `idx_director` (`director_id`)
) ENGINE=InnoDB COMMENT='学院信息表';

-- ----------------------------
-- 测评体系表
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_system`;
CREATE TABLE `t_evaluation_system` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '测评体系ID',
  `system_name` varchar(128) NOT NULL COMMENT '测评体系名称',
  `academic_year` varchar(16) NOT NULL COMMENT '学年，如2023-2024',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `description` text COMMENT '测评体系描述',
  `status` tinyint DEFAULT 0 COMMENT '状态：0-未启用，1-已启用，2-已结束',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `creator_id` bigint DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_academic_year` (`academic_year`),
  KEY `idx_semester` (`semester`),
  KEY `idx_creator` (`creator_id`)
) ENGINE=InnoDB COMMENT='测评体系表';

-- =============================================
-- 第二部分：用户扩展表（依赖sys_user）
-- =============================================

-- ----------------------------
-- 用户档案扩展表
-- ----------------------------
DROP TABLE IF EXISTS `t_user_profile`;
CREATE TABLE `t_user_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '档案ID',
  `user_id` bigint NOT NULL COMMENT '关联sys_user表的用户ID',
  `student_id` varchar(20) NOT NULL COMMENT '学号',
  `college` varchar(100) DEFAULT NULL COMMENT '学院名称',
  `major` varchar(100) DEFAULT NULL COMMENT '专业',
  `grade` varchar(10) DEFAULT NULL COMMENT '年级',
  `class_name` varchar(100) DEFAULT NULL COMMENT '班级名称',
  `gender` tinyint DEFAULT NULL COMMENT '性别：0-男，1-女，2-未知',
  `birth_date` date DEFAULT NULL COMMENT '出生日期',
  `political_status` varchar(50) DEFAULT NULL COMMENT '政治面貌',
  `enrollment_date` date DEFAULT NULL COMMENT '入学日期',
  `dormitory` varchar(100) DEFAULT NULL COMMENT '宿舍',
  `home_address` varchar(255) DEFAULT NULL COMMENT '家庭地址',
  `emergency_contact` varchar(50) DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(20) DEFAULT NULL COMMENT '紧急联系电话',
  `status` tinyint DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_student_id` (`student_id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB COMMENT='用户档案扩展表';

-- =============================================
-- 第三部分：业务规则表（有层级依赖）
-- =============================================

-- ----------------------------
-- 考评项目表
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_item`;
CREATE TABLE `t_evaluation_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `system_id` bigint NOT NULL COMMENT '关联测评体系ID',
  `parent_id` bigint DEFAULT 0 COMMENT '父级项目ID，用于层级结构',
  `item_name` varchar(128) NOT NULL COMMENT '项目名称',
  `weight` decimal(5,2) DEFAULT 0.00 COMMENT '权重',
  `score_rule` text COMMENT '评分规则描述',
  `item_type` tinyint DEFAULT 1 COMMENT '项目类型：0-模块，1-具体项目',
  `max_score` int DEFAULT 100 COMMENT '满分值',
  `sort_order` int DEFAULT 0 COMMENT '排序',
  `status` tinyint DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_system_id` (`system_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB COMMENT='考评项目表';

-- ----------------------------
-- 考评规则配置表
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_rule`;
CREATE TABLE `t_evaluation_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `college_id` bigint NOT NULL COMMENT '学院ID',
  `rule_name` varchar(128) NOT NULL COMMENT '规则名称',
  `indicators` json NOT NULL COMMENT '考评指标集合',
  `semester` varchar(32) NOT NULL COMMENT '生效学期（如2025-2026-1）',
  `status` tinyint DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_college_semester` (`college_id`, `semester`)
) ENGINE=InnoDB COMMENT='考评规则配置表';

-- =============================================
-- 第四部分：业务记录表（最复杂的外键关系）
-- =============================================

-- ----------------------------
-- 考评加分记录表
-- ----------------------------
DROP TABLE IF EXISTS `t_score_record`;
CREATE TABLE `t_score_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID（关联sys_user）',
  `rule_id` bigint NOT NULL COMMENT '关联规则ID',
  `material_path` varchar(256) NOT NULL COMMENT '材料存储路径',
  `material_type` varchar(16) NOT NULL COMMENT '材料类型：PDF/JPG/PNG',
  `reason` varchar(200) DEFAULT NULL COMMENT '加分事由',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-待班委审核，1-待辅导员审核，2-已通过，3-已拒绝',
  `score` decimal(5,2) DEFAULT 0.00 COMMENT '最终加分值',
  `submit_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_rule_id` (`rule_id`),
  KEY `idx_status` (`status`),
  KEY `idx_submit_time` (`submit_time`)
) ENGINE=InnoDB COMMENT='考评加分记录表';

-- ----------------------------
-- 审核流程记录表
-- ----------------------------
DROP TABLE IF EXISTS `t_audit_flow`;
CREATE TABLE `t_audit_flow` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `record_id` bigint NOT NULL COMMENT '关联加分记录ID',
  `auditor_id` bigint NOT NULL COMMENT '审核人ID',
  `audit_opinion` varchar(500) DEFAULT NULL COMMENT '审核意见',
  `audit_status` tinyint NOT NULL COMMENT '审核状态：1-通过，2-拒绝',
  `audit_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  PRIMARY KEY (`id`),
  KEY `idx_record_id` (`record_id`),
  KEY `idx_auditor_id` (`auditor_id`)
) ENGINE=InnoDB COMMENT='审核流程记录表';

-- ----------------------------
-- 申诉表
-- ----------------------------
DROP TABLE IF EXISTS `t_appeal`;
CREATE TABLE `t_appeal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '申诉ID',
  `record_id` bigint NOT NULL COMMENT '关联加分记录ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `appeal_reason` varchar(500) NOT NULL COMMENT '申诉理由',
  `status` tinyint DEFAULT 0 COMMENT '状态：0-待处理，1-已同意，2-已拒绝',
  `process_result` varchar(500) DEFAULT NULL COMMENT '处理结果',
  `process_by` bigint DEFAULT NULL COMMENT '处理人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `process_time` datetime DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`),
  KEY `idx_record_id` (`record_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_process_by` (`process_by`)
) ENGINE=InnoDB COMMENT='申诉表';

-- ----------------------------
-- 学生成绩明细表
-- ----------------------------
DROP TABLE IF EXISTS `t_student_score_detail`;
CREATE TABLE `t_student_score_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '成绩明细ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `system_id` bigint NOT NULL COMMENT '测评体系ID',
  `item_id` bigint NOT NULL COMMENT '测评项目ID',
  `score` decimal(5,2) DEFAULT 0.00 COMMENT '得分',
  `evidence_url` varchar(500) DEFAULT NULL COMMENT '证明材料URL',
  `description` text COMMENT '申请说明',
  `status` tinyint DEFAULT 0 COMMENT '状态：0-待提交，1-待审核，2-已通过，3-已驳回',
  `audit_comment` text COMMENT '审核意见',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人ID',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_student_system` (`student_id`, `system_id`),
  KEY `idx_item_id` (`item_id`),
  KEY `idx_auditor_id` (`auditor_id`)
) ENGINE=InnoDB COMMENT='学生成绩明细表';

-- ----------------------------
-- 学生总成绩表
-- ----------------------------
DROP TABLE IF EXISTS `t_student_total_score`;
CREATE TABLE `t_student_total_score` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '总成绩ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `system_id` bigint NOT NULL COMMENT '测评体系ID',
  `total_score` decimal(8,2) DEFAULT 0.00 COMMENT '总分',
  `moral_score` decimal(6,2) DEFAULT 0.00 COMMENT '思想品德分',
  `study_score` decimal(6,2) DEFAULT 0.00 COMMENT '学习成绩分',
  `practice_score` decimal(6,2) DEFAULT 0.00 COMMENT '社会实践分',
  `innovation_score` decimal(6,2) DEFAULT 0.00 COMMENT '创新创业分',
  `other_score` decimal(6,2) DEFAULT 0.00 COMMENT '其他加分',
  `ranking` int DEFAULT NULL COMMENT '排名',
  `academic_year` varchar(16) DEFAULT NULL COMMENT '学年',
  `semester` tinyint DEFAULT NULL COMMENT '学期',
  `status` tinyint DEFAULT 0 COMMENT '状态：0-计算中，1-已完成，2-已公示',
  `calculate_time` datetime DEFAULT NULL COMMENT '计算时间',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_student_system` (`student_id`, `system_id`),
  KEY `idx_system_id` (`system_id`),
  KEY `idx_ranking` (`ranking`)
) ENGINE=InnoDB COMMENT='学生总成绩表';

-- =============================================
-- 第五部分：添加外键约束（最后执行）
-- =============================================

-- 学院表外键
ALTER TABLE `t_college_info` 
ADD CONSTRAINT `fk_college_director` FOREIGN KEY (`director_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT;

-- 测评体系表外键
ALTER TABLE `t_evaluation_system` 
ADD CONSTRAINT `fk_evaluation_system_creator` FOREIGN KEY (`creator_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT;

-- 用户档案表外键
ALTER TABLE `t_user_profile` 
ADD CONSTRAINT `fk_user_profile_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 测评项目表外键
ALTER TABLE `t_evaluation_item` 
ADD CONSTRAINT `fk_evaluation_item_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 评规则表外键
ALTER TABLE `t_evaluation_rule` 
ADD CONSTRAINT `fk_evaluation_rule_college` FOREIGN KEY (`college_id`) REFERENCES `t_college_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 加分记录表外键
ALTER TABLE `t_score_record` 
ADD CONSTRAINT `fk_score_record_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_score_record_rule` FOREIGN KEY (`rule_id`) REFERENCES `t_evaluation_rule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 审核流程表外键
ALTER TABLE `t_audit_flow` 
ADD CONSTRAINT `fk_audit_flow_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_audit_flow_auditor` FOREIGN KEY (`auditor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 申诉表外键
ALTER TABLE `t_appeal` 
ADD CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_appeal_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_appeal_processor` FOREIGN KEY (`process_by`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- 成绩明细表外键
ALTER TABLE `t_student_score_detail` 
ADD CONSTRAINT `fk_score_detail_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_score_detail_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_score_detail_item` FOREIGN KEY (`item_id`) REFERENCES `t_evaluation_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_score_detail_auditor` FOREIGN KEY (`auditor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT;

-- 总成绩表外键
ALTER TABLE `t_student_total_score` 
ADD CONSTRAINT `fk_total_score_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `fk_total_score_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- 完成提示
-- =============================================
SELECT '数据库表结构重构完成！接下来请按照数据迁移文档进行数据迁移操作。' AS message;