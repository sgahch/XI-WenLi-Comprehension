/*
 高校综合测评系统重构 - 数据库设计
 基于"人、事、规"分离原则的MVP版本
 
 Date: 2025-01-27
 Author: 系统架构师
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for evaluation_rule (计分规则表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_rule`;
CREATE TABLE `evaluation_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `dimension` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '维度：moral(德), intellectual(智), physical(体), aesthetic(美), labor(劳)',
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '大类：如学科竞赛、社会实践、文体活动等',
  `item_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称：如全国大学生数学建模竞赛',
  `level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级：如国家级一等奖、省级三等奖等',
  `score` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT '分数',
  `require_attachment` tinyint NOT NULL DEFAULT 1 COMMENT '是否必须上传附件：0-否，1-是',
  `attachment_types` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PDF,JPG,PNG' COMMENT '允许的附件类型',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规则描述',
  `is_enabled` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dimension_category_item_level` (`dimension`, `category`, `item_name`, `level`) USING BTREE COMMENT '确保规则不重复',
  KEY `idx_dimension` (`dimension`) USING BTREE,
  KEY `idx_category` (`category`) USING BTREE,
  KEY `idx_enabled` (`is_enabled`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='计分规则表';

-- ----------------------------
-- Records of evaluation_rule
-- ----------------------------
INSERT INTO `evaluation_rule` VALUES 
(1, 'intellectual', '学科竞赛', '全国大学生数学建模竞赛', '国家级一等奖', 15.00, 1, 'PDF,JPG,PNG', '全国大学生数学建模竞赛国家级一等奖', 1, 'admin', NOW(), 'admin', NOW()),
(2, 'intellectual', '学科竞赛', '全国大学生数学建模竞赛', '国家级二等奖', 12.00, 1, 'PDF,JPG,PNG', '全国大学生数学建模竞赛国家级二等奖', 1, 'admin', NOW(), 'admin', NOW()),
(3, 'intellectual', '学科竞赛', '全国大学生数学建模竞赛', '省级一等奖', 8.00, 1, 'PDF,JPG,PNG', '全国大学生数学建模竞赛省级一等奖', 1, 'admin', NOW(), 'admin', NOW()),
(4, 'intellectual', '学科竞赛', 'ACM程序设计竞赛', '国际级金奖', 20.00, 1, 'PDF,JPG,PNG', 'ACM程序设计竞赛国际级金奖', 1, 'admin', NOW(), 'admin', NOW()),
(5, 'moral', '社会实践', '志愿服务活动', '校级优秀', 3.00, 1, 'PDF,JPG,PNG', '校级优秀志愿服务活动', 1, 'admin', NOW(), 'admin', NOW()),
(6, 'physical', '文体活动', '校运动会', '个人项目第一名', 5.00, 1, 'PDF,JPG,PNG', '校运动会个人项目第一名', 1, 'admin', NOW(), 'admin', NOW()),
(7, 'aesthetic', '文艺活动', '校园文化艺术节', '一等奖', 4.00, 1, 'PDF,JPG,PNG', '校园文化艺术节一等奖', 1, 'admin', NOW(), 'admin', NOW()),
(8, 'labor', '实践活动', '社会实习', '优秀实习生', 3.00, 1, 'PDF,JPG,PNG', '社会实习优秀实习生', 1, 'admin', NOW(), 'admin', NOW());

-- ----------------------------
-- Table structure for evaluation_submission (学生填报主表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_submission`;
CREATE TABLE `evaluation_submission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '填报ID',
  `student_id` bigint NOT NULL COMMENT '学生ID，关联sys_user.user_id',
  `academic_year` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学年，如2024-2025',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `class_id` bigint NOT NULL COMMENT '班级ID，关联sys_dept.dept_id',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-草稿，1-待班委审核，2-待辅导员审核，3-已通过，4-已驳回',
  `total_score` decimal(8,2) NOT NULL DEFAULT 0.00 COMMENT '总分',
  `moral_score` decimal(6,2) NOT NULL DEFAULT 0.00 COMMENT '德育分数',
  `intellectual_score` decimal(6,2) NOT NULL DEFAULT 0.00 COMMENT '智育分数',
  `physical_score` decimal(6,2) NOT NULL DEFAULT 0.00 COMMENT '体育分数',
  `aesthetic_score` decimal(6,2) NOT NULL DEFAULT 0.00 COMMENT '美育分数',
  `labor_score` decimal(6,2) NOT NULL DEFAULT 0.00 COMMENT '劳育分数',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核完成时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_student_year_semester` (`student_id`, `academic_year`, `semester`) USING BTREE COMMENT '防止学生在同一学期重复创建填报',
  KEY `idx_class_id` (`class_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_academic_year` (`academic_year`) USING BTREE,
  CONSTRAINT `fk_submission_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_submission_class` FOREIGN KEY (`class_id`) REFERENCES `sys_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生填报主表';

-- ----------------------------
-- Records of evaluation_submission
-- ----------------------------
INSERT INTO `evaluation_submission` VALUES 
(1, 100, '2024-2025', 1, 200, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 'student', NOW(), 'student', NOW(), '测试填报记录');

-- ----------------------------
-- Table structure for evaluation_submission_detail (填报详情表/成果表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_submission_detail`;
CREATE TABLE `evaluation_submission_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详情ID',
  `submission_id` bigint NOT NULL COMMENT '填报ID，关联evaluation_submission.id',
  `rule_id` bigint NOT NULL COMMENT '规则ID，关联evaluation_rule.id',
  `rule_snapshot` json NOT NULL COMMENT '规则快照，JSON格式，冗余保存规则信息防止规则变更影响历史记录',
  `final_score` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT '该项得分',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '学生备注',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '审核状态：0-待审核，1-已通过，2-已驳回',
  `audit_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审核意见',
  `auditor_id` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_submission_id` (`submission_id`) USING BTREE,
  KEY `idx_rule_id` (`rule_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  CONSTRAINT `fk_detail_submission` FOREIGN KEY (`submission_id`) REFERENCES `evaluation_submission` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_detail_rule` FOREIGN KEY (`rule_id`) REFERENCES `evaluation_rule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='填报详情表/成果表';

-- ----------------------------
-- Records of evaluation_submission_detail
-- ----------------------------
INSERT INTO `evaluation_submission_detail` VALUES 
(1, 1, 1, '{"id": 1, "dimension": "intellectual", "category": "学科竞赛", "item_name": "全国大学生数学建模竞赛", "level": "国家级一等奖", "score": 15.00, "require_attachment": 1}', 15.00, '参加2024年全国大学生数学建模竞赛获得国家级一等奖', 0, NULL, NULL, NULL, 'student', NOW(), 'student', NOW());

-- ----------------------------
-- Table structure for evaluation_attachment (附件表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_attachment`;
CREATE TABLE `evaluation_attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  `detail_id` bigint NOT NULL COMMENT '详情ID，关联evaluation_submission_detail.id',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原始文件名',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件存储路径',
  `file_size` bigint NOT NULL DEFAULT 0 COMMENT '文件大小（字节）',
  `file_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件类型：PDF/JPG/PNG等',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访问URL',
  `upload_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '上传者',
  `upload_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_detail_id` (`detail_id`) USING BTREE,
  KEY `idx_file_type` (`file_type`) USING BTREE,
  CONSTRAINT `fk_attachment_detail` FOREIGN KEY (`detail_id`) REFERENCES `evaluation_submission_detail` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='附件表';

-- ----------------------------
-- Records of evaluation_attachment
-- ----------------------------
INSERT INTO `evaluation_attachment` VALUES 
(1, 1, 'math_modeling_certificate_20240901.pdf', '数学建模竞赛获奖证书.pdf', '/uploads/evaluation/2024/09/math_modeling_certificate_20240901.pdf', 1024000, 'PDF', '/api/file/download/math_modeling_certificate_20240901.pdf', 'student', NOW());

-- ----------------------------
-- Table structure for evaluation_audit_log (审核日志表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_audit_log`;
CREATE TABLE `evaluation_audit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `submission_id` bigint NULL DEFAULT NULL COMMENT '填报ID，关联evaluation_submission.id',
  `detail_id` bigint NULL DEFAULT NULL COMMENT '详情ID，关联evaluation_submission_detail.id',
  `auditor_id` bigint NOT NULL COMMENT '审核人ID，关联sys_user.user_id',
  `operation` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型：APPROVE-通过，REJECT-驳回，SUBMIT-提交',
  `old_status` tinyint NULL DEFAULT NULL COMMENT '原状态',
  `new_status` tinyint NOT NULL COMMENT '新状态',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审核意见/操作说明',
  `audit_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `ip_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_submission_id` (`submission_id`) USING BTREE,
  KEY `idx_detail_id` (`detail_id`) USING BTREE,
  KEY `idx_auditor_id` (`auditor_id`) USING BTREE,
  KEY `idx_audit_time` (`audit_time`) USING BTREE,
  CONSTRAINT `fk_audit_submission` FOREIGN KEY (`submission_id`) REFERENCES `evaluation_submission` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_audit_detail` FOREIGN KEY (`detail_id`) REFERENCES `evaluation_submission_detail` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_audit_auditor` FOREIGN KEY (`auditor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='审核日志表';

-- ----------------------------
-- Records of evaluation_audit_log
-- ----------------------------
INSERT INTO `evaluation_audit_log` VALUES 
(1, 1, NULL, 101, 'SUBMIT', 0, 1, '学生提交填报申请', NOW(), '192.168.1.100'),
(2, NULL, 1, 102, 'APPROVE', 0, 1, '班委审核通过', NOW(), '192.168.1.101');

-- ----------------------------
-- 创建视图：学生填报统计视图
-- ----------------------------
CREATE OR REPLACE VIEW `v_student_submission_stats` AS
SELECT 
    s.id,
    s.student_id,
    u.nick_name AS student_name,
    u.user_name AS student_code,
    s.academic_year,
    s.semester,
    s.class_id,
    d.dept_name AS class_name,
    s.status,
    s.total_score,
    s.moral_score,
    s.intellectual_score,
    s.physical_score,
    s.aesthetic_score,
    s.labor_score,
    COUNT(sd.id) AS detail_count,
    COUNT(CASE WHEN sd.status = 1 THEN 1 END) AS approved_count,
    COUNT(CASE WHEN sd.status = 2 THEN 1 END) AS rejected_count,
    s.submit_time,
    s.audit_time,
    s.create_time,
    s.update_time
FROM evaluation_submission s
LEFT JOIN sys_user u ON s.student_id = u.user_id
LEFT JOIN sys_dept d ON s.class_id = d.dept_id
LEFT JOIN evaluation_submission_detail sd ON s.id = sd.submission_id
GROUP BY s.id;

-- ----------------------------
-- 创建索引优化查询性能
-- ----------------------------
-- 为常用查询创建复合索引
CREATE INDEX `idx_submission_class_status` ON `evaluation_submission` (`class_id`, `status`, `academic_year`, `semester`);
CREATE INDEX `idx_detail_submission_status` ON `evaluation_submission_detail` (`submission_id`, `status`);
CREATE INDEX `idx_rule_dimension_enabled` ON `evaluation_rule` (`dimension`, `is_enabled`);

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- 说明文档
-- ----------------------------
/*
数据库设计说明：

1. evaluation_rule (计分规则表)
   - 核心特点：维度化管理（德智体美劳），支持动态规则配置
   - 唯一约束：确保同一维度下的同一项目同一等级不重复
   - 扩展性：支持附件要求配置、分数动态调整

2. evaluation_submission (学生填报主表)
   - 核心特点：一学期一填报，状态流转清晰
   - 唯一约束：防止学生重复创建同学期填报
   - 分数统计：按维度分别统计，便于分析

3. evaluation_submission_detail (填报详情表)
   - 核心特点：记录具体成果，关联规则快照
   - 规则快照：JSON格式保存规则信息，防止规则变更影响历史
   - 审核粒度：支持单项成果独立审核

4. evaluation_attachment (附件表)
   - 核心特点：支持多附件，完整的文件信息记录
   - 关联关系：与详情表级联删除，保证数据一致性

5. evaluation_audit_log (审核日志表)
   - 核心特点：完整的操作轨迹，支持主表和详情表双重审核
   - 审计功能：记录IP地址、操作时间等关键信息

设计原则：
- 遵循"人、事、规"分离：人员信息依赖sys_user，事实记录在detail表，规则独立管理
- 数据完整性：通过外键约束保证数据一致性
- 历史追溯：规则快照机制保证历史数据不受规则变更影响
- 性能优化：合理的索引设计支持高效查询
- 扩展性：预留字段和灵活的JSON结构支持未来扩展
*/