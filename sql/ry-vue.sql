/*
 Navicat Premium Dump SQL

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 02/11/2025 19:54:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for evaluation_attachment
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_attachment`;
CREATE TABLE `evaluation_attachment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  `detail_id` bigint NOT NULL COMMENT '详情ID，关联evaluation_submission_detail.id',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原始文件名',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件存储路径',
  `file_size` bigint NOT NULL DEFAULT 0 COMMENT '文件大小（字节）',
  `file_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件类型：PDF/JPG/PNG等',
  `attachment_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'CERTIFICATE' COMMENT '附件类型：CERTIFICATE-证书材料，GRADE_SCREENSHOT-成绩截图',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访问URL',
  `upload_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '上传者',
  `upload_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_detail_id`(`detail_id` ASC) USING BTREE,
  INDEX `idx_file_type`(`file_type` ASC) USING BTREE,
  INDEX `idx_attachment_type`(`attachment_type` ASC) USING BTREE,
  CONSTRAINT `fk_attachment_detail` FOREIGN KEY (`detail_id`) REFERENCES `evaluation_submission_detail` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_attachment
-- ----------------------------
INSERT INTO `evaluation_attachment` VALUES (1, 1, 'math_modeling_certificate_20240901.pdf', '数学建模竞赛获奖证书.pdf', '/uploads/evaluation/2024/09/math_modeling_certificate_20240901.pdf', 1024000, 'PDF', '/api/file/download/math_modeling_certificate_20240901.pdf', 'student', '2025-10-24 22:08:03', '2025-10-29 22:07:06', '2025-10-29 22:07:06');
INSERT INTO `evaluation_attachment` VALUES (2, 7, 'default_20251028212020A002.png', 'default_20251028212020A002.png', '/default_20251028212020A002.png', 0, 'PNG', '/profile/upload/2025/10/28/default_20251028212020A002.png', '101', '2025-10-29 22:18:36', '2025-10-29 22:18:36', '2025-10-29 22:18:36');
INSERT INTO `evaluation_attachment` VALUES (3, 8, '2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png', '2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png', '/2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png', 0, 'PNG', '/profile/upload/2025/10/28/2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png', '101', '2025-10-29 22:18:36', '2025-10-29 22:18:36', '2025-10-29 22:18:36');
INSERT INTO `evaluation_attachment` VALUES (4, 9, '7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg', '7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg', '/7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg', 0, 'JPG', '/profile/upload/2025/10/28/7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg', '101', '2025-10-29 22:18:36', '2025-10-29 22:18:36', '2025-10-29 22:18:36');
INSERT INTO `evaluation_attachment` VALUES (5, 10, '349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg', '349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg', '/349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg', 0, 'JPG', '/profile/upload/2025/10/28/349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg', '101', '2025-10-29 22:18:36', '2025-10-29 22:18:36', '2025-10-29 22:18:36');

-- ----------------------------
-- Table structure for evaluation_audit_log
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_audit_log`;
CREATE TABLE `evaluation_audit_log`  (
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
  INDEX `idx_submission_id`(`submission_id` ASC) USING BTREE,
  INDEX `idx_detail_id`(`detail_id` ASC) USING BTREE,
  INDEX `idx_auditor_id`(`auditor_id` ASC) USING BTREE,
  INDEX `idx_audit_time`(`audit_time` ASC) USING BTREE,
  CONSTRAINT `fk_audit_auditor` FOREIGN KEY (`auditor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_audit_detail` FOREIGN KEY (`detail_id`) REFERENCES `evaluation_submission_detail` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_audit_submission` FOREIGN KEY (`submission_id`) REFERENCES `evaluation_submission` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审核日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_audit_log
-- ----------------------------
INSERT INTO `evaluation_audit_log` VALUES (1, 1, NULL, 101, 'SUBMIT', 0, 1, '学生提交填报申请', '2025-10-24 22:08:03', '192.168.1.100');
INSERT INTO `evaluation_audit_log` VALUES (2, NULL, 1, 102, 'APPROVE', 0, 1, '班委审核通过', '2025-10-24 22:08:03', '192.168.1.101');
INSERT INTO `evaluation_audit_log` VALUES (3, 5, NULL, 1, 'APPROVE', 1, 2, '', '2025-10-28 21:49:32', '127.0.0.1');
INSERT INTO `evaluation_audit_log` VALUES (4, 2, NULL, 1, 'APPROVE', 1, 2, '', '2025-10-29 20:52:27', '127.0.0.1');
INSERT INTO `evaluation_audit_log` VALUES (5, 6, NULL, 1, 'APPROVE', 1, 2, '', '2025-11-02 17:22:37', '127.0.0.1');

-- ----------------------------
-- Table structure for evaluation_publicity (公示主表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_publicity`;
CREATE TABLE `evaluation_publicity`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公示ID',
  `academic_year` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学年，如2024-2025',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `class_id` bigint NULL DEFAULT NULL COMMENT '班级ID（NULL表示全校公示），关联sys_dept.dept_id',
  `college_id` bigint NULL DEFAULT NULL COMMENT '学院ID（NULL表示全校公示），关联sys_dept.dept_id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公示标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '公示说明内容',
  `start_time` datetime NOT NULL COMMENT '公示开始时间',
  `end_time` datetime NOT NULL COMMENT '公示结束时间',
  `publicity_days` int NOT NULL DEFAULT 5 COMMENT '公示天数（工作日）',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-进行中，1-已结束',
  `total_count` int NOT NULL DEFAULT 0 COMMENT '公示学生总数',
  `view_count` int NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_academic_year`(`academic_year` ASC) USING BTREE,
  INDEX `idx_semester`(`semester` ASC) USING BTREE,
  INDEX `idx_class_id`(`class_id` ASC) USING BTREE,
  INDEX `idx_college_id`(`college_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_publicity_year_semester_status`(`academic_year` ASC, `semester` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评结果公示主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_publicity
-- ----------------------------
INSERT INTO `evaluation_publicity` VALUES (1, '2024-2025', 1, NULL, NULL, '2024-2025学年第一学期综合测评结果公示', '根据《西安文理学院学生综合素质测评办法》，现将2024-2025学年第一学期综合测评结果予以公示。公示期为5个工作日，如有异议，请在公示期内向辅导员提出申诉。', '2025-01-15 09:00:00', '2025-01-22 18:00:00', 5, 0, 0, 0, 'admin', '2025-11-11 00:00:00', 'admin', '2025-11-11 00:00:00', '全校公示');

-- ----------------------------
-- Table structure for evaluation_publicity_detail (公示详情表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_publicity_detail`;
CREATE TABLE `evaluation_publicity_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详情ID',
  `publicity_id` bigint NOT NULL COMMENT '公示ID，关联evaluation_publicity.id',
  `submission_id` bigint NOT NULL COMMENT '填报ID，关联evaluation_submission.id',
  `student_id` bigint NOT NULL COMMENT '学生ID，关联sys_user.user_id',
  `student_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生姓名（冗余字段，提高查询效率）',
  `student_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学号（冗余字段）',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级名称（冗余字段）',
  `total_score` decimal(8, 2) NOT NULL DEFAULT 0.00 COMMENT '总分',
  `moral_score` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '德育分数',
  `intellectual_score` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '智育分数',
  `physical_score` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '体育分数',
  `aesthetic_score` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '美育分数',
  `labor_score` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '劳育分数',
  `class_rank` int NULL DEFAULT NULL COMMENT '班级排名',
  `major_rank` int NULL DEFAULT NULL COMMENT '专业排名',
  `college_rank` int NULL DEFAULT NULL COMMENT '学院排名',
  `snapshot_data` json NULL DEFAULT NULL COMMENT '数据快照（JSON格式，保存公示时的完整数据）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_publicity_student`(`publicity_id` ASC, `student_id` ASC) USING BTREE COMMENT '防止同一公示中重复添加同一学生',
  INDEX `idx_publicity_id`(`publicity_id` ASC) USING BTREE,
  INDEX `idx_student_id`(`student_id` ASC) USING BTREE,
  INDEX `idx_total_score`(`total_score` ASC) USING BTREE,
  INDEX `idx_publicity_detail_publicity_score`(`publicity_id` ASC, `total_score` DESC) USING BTREE,
  CONSTRAINT `fk_publicity_detail_publicity` FOREIGN KEY (`publicity_id`) REFERENCES `evaluation_publicity` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_publicity_detail_submission` FOREIGN KEY (`submission_id`) REFERENCES `evaluation_submission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_publicity_detail_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评结果公示详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_publicity_detail
-- ----------------------------

-- ----------------------------
-- Table structure for evaluation_publicity_view_log (公示浏览日志表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_publicity_view_log`;
CREATE TABLE `evaluation_publicity_view_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `publicity_id` bigint NOT NULL COMMENT '公示ID，关联evaluation_publicity.id',
  `user_id` bigint NOT NULL COMMENT '浏览用户ID，关联sys_user.user_id',
  `view_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
  `ip_address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_publicity_id`(`publicity_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_view_time`(`view_time` ASC) USING BTREE,
  CONSTRAINT `fk_eval_publicity_view_log_publicity` FOREIGN KEY (`publicity_id`) REFERENCES `evaluation_publicity` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_eval_publicity_view_log_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公示浏览日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_publicity_view_log
-- ----------------------------

-- ----------------------------
-- Table structure for evaluation_rule
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_rule`;
CREATE TABLE `evaluation_rule`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `dimension` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '维度：moral(德), intellectual(智), physical(体), aesthetic(美), labor(劳)',
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '大类：如学科竞赛、社会实践、文体活动等',
  `item_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称：如全国大学生数学建模竞赛',
  `level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级：如国家级一等奖、省级三等奖等',
  `score` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '分数',
  `require_attachment` tinyint NOT NULL DEFAULT 1 COMMENT '是否必须上传附件：0-否，1-是',
  `attachment_types` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PDF,JPG,PNG' COMMENT '允许的附件类型',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '规则描述',
  `is_enabled` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_dimension_category_item_level`(`dimension` ASC, `category` ASC, `item_name` ASC, `level` ASC) USING BTREE COMMENT '确保规则不重复',
  INDEX `idx_dimension`(`dimension` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  INDEX `idx_enabled`(`is_enabled` ASC) USING BTREE,
  INDEX `idx_rule_dimension_enabled`(`dimension` ASC, `is_enabled` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '计分规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_rule
-- ----------------------------
INSERT INTO `evaluation_rule` VALUES (1, 'intellectual', '学科竞赛', '全国大学生数学建模竞赛', '国家级一等奖', 15.00, 1, 'PDF,JPG,PNG', '全国大学生数学建模竞赛国家级一等奖', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (2, 'intellectual', '学科竞赛', '全国大学生数学建模竞赛', '国家级二等奖', 12.00, 1, 'PDF,JPG,PNG', '全国大学生数学建模竞赛国家级二等奖', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (3, 'intellectual', '学科竞赛', '全国大学生数学建模竞赛', '省级一等奖', 8.00, 1, 'PDF,JPG,PNG', '全国大学生数学建模竞赛省级一等奖', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (4, 'intellectual', '学科竞赛', 'ACM程序设计竞赛', '国际级金奖', 20.00, 1, 'PDF,JPG,PNG', 'ACM程序设计竞赛国际级金奖', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (5, 'moral', '社会实践', '志愿服务活动', '校级优秀', 3.00, 1, 'PDF,JPG,PNG', '校级优秀志愿服务活动', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (6, 'physical', '文体活动', '校运动会', '个人项目第一名', 5.00, 1, 'PDF,JPG,PNG', '校运动会个人项目第一名', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (7, 'aesthetic', '文艺活动', '校园文化艺术节', '一等奖', 4.00, 1, 'PDF,JPG,PNG', '校园文化艺术节一等奖', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');
INSERT INTO `evaluation_rule` VALUES (8, 'labor', '实践活动', '社会实习', '优秀实习生', 3.00, 1, 'PDF,JPG,PNG', '社会实习优秀实习生', 1, 'admin', '2025-10-24 22:08:02', 'admin', '2025-10-24 22:08:02');

-- ----------------------------
-- Table structure for evaluation_submission
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_submission`;
CREATE TABLE `evaluation_submission`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '填报ID',
  `student_id` bigint NOT NULL COMMENT '学生ID，关联sys_user.user_id',
  `academic_year` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学年，如2024-2025',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `class_id` bigint NOT NULL COMMENT '班级ID，关联sys_dept.dept_id',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-草稿，1-待班委审核，2-待辅导员审核，3-已通过，4-已驳回',
  `total_score` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '总分',
  `moral_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '德育分数',
  `intellectual_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '智育分数',
  `physical_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '体育分数',
  `aesthetic_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '美育分数',
  `labor_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '劳育分数',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核完成时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人',
  `audit_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_year_semester`(`student_id` ASC, `academic_year` ASC, `semester` ASC) USING BTREE COMMENT '防止学生在同一学期重复创建填报',
  INDEX `idx_class_id`(`class_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_academic_year`(`academic_year` ASC) USING BTREE,
  INDEX `idx_submission_class_status`(`class_id` ASC, `status` ASC, `academic_year` ASC, `semester` ASC) USING BTREE,
  CONSTRAINT `fk_submission_class` FOREIGN KEY (`class_id`) REFERENCES `sys_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_submission_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生填报主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_submission
-- ----------------------------
INSERT INTO `evaluation_submission` VALUES (1, 100, '2024-2025', 1, 200, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 'student', '2025-10-24 22:08:03', 'student', '2025-10-24 22:08:03', '测试填报记录', NULL, NULL);
INSERT INTO `evaluation_submission` VALUES (2, 1, '2025-2026', 1, 202, 2, 0.00, 16.00, 0.00, 0.00, 0.00, 0.00, NULL, '2025-10-29 20:52:27', 'admin', '2025-10-25 11:12:42', 'admin', '2025-10-29 21:08:49', '', '1', '');
INSERT INTO `evaluation_submission` VALUES (5, 100, '2025-2026', 1, 201, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-28 21:49:32', '胡淇', '2025-10-27 17:58:35', 'admin', '2025-10-28 21:49:32', '', '1', '');
INSERT INTO `evaluation_submission` VALUES (6, 101, '2025-2026', 1, 200, 2, 20.00, 0.00, 20.00, 10.00, 0.00, 0.00, NULL, '2025-11-02 17:22:37', 'test', '2025-10-29 21:14:43', 'admin', '2025-11-02 17:22:37', '', '1', '');

-- ----------------------------
-- Table structure for evaluation_submission_detail
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_submission_detail`;
CREATE TABLE `evaluation_submission_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详情ID',
  `submission_id` bigint NOT NULL COMMENT '填报ID，关联evaluation_submission.id',
  `rule_id` bigint NOT NULL COMMENT '规则ID，关联evaluation_rule.id',
  `rule_snapshot` json NOT NULL COMMENT '规则快照，JSON格式，冗余保存规则信息防止规则变更影响历史',
  `final_score` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '该项得分',
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
  INDEX `idx_submission_id`(`submission_id` ASC) USING BTREE,
  INDEX `idx_rule_id`(`rule_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_detail_submission_status`(`submission_id` ASC, `status` ASC) USING BTREE,
  CONSTRAINT `fk_detail_rule` FOREIGN KEY (`rule_id`) REFERENCES `evaluation_rule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_detail_submission` FOREIGN KEY (`submission_id`) REFERENCES `evaluation_submission` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '填报详情表/成果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation_submission_detail
-- ----------------------------
INSERT INTO `evaluation_submission_detail` VALUES (1, 1, 1, '{\"id\": 1, \"level\": \"国家级一等奖\", \"score\": 15.0, \"category\": \"学科竞赛\", \"dimension\": \"intellectual\", \"item_name\": \"全国大学生数学建模竞赛\", \"require_attachment\": 1}', 15.00, '参加2024年全国大学生数学建模竞赛获得国家级一等奖', 0, NULL, NULL, NULL, 'student', '2025-10-24 22:08:03', 'student', '2025-10-24 22:08:03');
INSERT INTO `evaluation_submission_detail` VALUES (7, 6, 2, '{\"id\": 2, \"weight\": 0.1, \"itemCode\": \"ACADEMIC_COMPETITION\", \"itemName\": \"学科竞赛\", \"maxScore\": 20.0, \"minScore\": 0.0, \"scoreType\": 1, \"defaultScore\": 0.0, \"dimensionType\": 1}', 6.00, '', 0, NULL, NULL, NULL, 'test', '2025-10-29 22:18:36', 'test', '2025-10-29 22:18:36');
INSERT INTO `evaluation_submission_detail` VALUES (8, 6, 2, '{\"id\": 2, \"weight\": 0.1, \"itemCode\": \"ACADEMIC_COMPETITION\", \"itemName\": \"学科竞赛\", \"maxScore\": 20.0, \"minScore\": 0.0, \"scoreType\": 1, \"defaultScore\": 0.0, \"dimensionType\": 1}', 6.00, '', 0, NULL, NULL, NULL, 'test', '2025-10-29 22:18:36', 'test', '2025-10-29 22:18:36');
INSERT INTO `evaluation_submission_detail` VALUES (9, 6, 3, '{\"id\": 3, \"weight\": 0.1, \"itemCode\": \"RESEARCH_PROJECT\", \"itemName\": \"科研项目\", \"maxScore\": 15.0, \"minScore\": 0.0, \"scoreType\": 1, \"defaultScore\": 0.0, \"dimensionType\": 1}', 4.00, '', 0, NULL, NULL, NULL, 'test', '2025-10-29 22:18:36', 'test', '2025-10-29 22:18:36');
INSERT INTO `evaluation_submission_detail` VALUES (10, 6, 3, '{\"id\": 3, \"weight\": 0.1, \"itemCode\": \"RESEARCH_PROJECT\", \"itemName\": \"科研项目\", \"maxScore\": 15.0, \"minScore\": 0.0, \"scoreType\": 1, \"defaultScore\": 0.0, \"dimensionType\": 1}', 4.00, '', 0, NULL, NULL, NULL, 'test', '2025-10-29 22:18:36', 'test', '2025-10-29 22:18:36');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 't_user_profile', '学生用户档案扩展表', NULL, NULL, 'TUserProfile', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 't_user_profile', '学生档案管理', 'ruoyi', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32', '学生用户档案扩展表');
INSERT INTO `gen_table` VALUES (2, 't_appeal', '申诉表', NULL, NULL, 'TAppeal', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 't_appeal', '申诉', 'ruoyi', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30', '学生申诉管理');
INSERT INTO `gen_table` VALUES (3, 't_college_info', '学院信息表', NULL, NULL, 'TCollegeInfo', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 'college_info', '学院信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48', '学院信息');
INSERT INTO `gen_table` VALUES (4, 't_score_record', '考评加分记录表', NULL, NULL, 'TScoreRecord', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 't_score_record', '考评加分记录', 'ruoyi', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49', '考评加分记录表');
INSERT INTO `gen_table` VALUES (5, 't_evaluation_system', '测评体系表', NULL, NULL, 'TEvaluationSystem', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 't_evaluation', '测评体系', 'ynchen', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46', '测评体系');
INSERT INTO `gen_table` VALUES (6, 't_student_score_detail', '学生成绩明细表', NULL, NULL, 'TStudentScoreDetail', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 't_student_score_detail', '学生成绩明细', 'ruoyi', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29', '学生成绩明细表');
INSERT INTO `gen_table` VALUES (7, 't_student_total_score', '学生总成绩表', NULL, NULL, 'TStudentTotalScore', 'crud', 'element-ui', 'com.ruoyi.system', 'evaluation', 't_student_total_score', '学生总成绩', 'ruoyi', '0', '/', '{\"parentMenuId\":2006}', 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21', '学生总成绩表');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '档案ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (2, 1, 'user_id', '关联sys_user表的用户ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (3, 1, 'student_id', '学号', 'varchar(20)', 'String', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (4, 1, 'college', '学院名称', 'varchar(100)', 'String', 'college', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (5, 1, 'major', '专业', 'varchar(100)', 'String', 'major', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (6, 1, 'grade', '年级', 'varchar(10)', 'String', 'grade', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (7, 1, 'class_name', '班级名称', 'varchar(100)', 'String', 'className', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (8, 1, 'gender', '性别：0-男，1-女，2-未知', 'tinyint', 'Long', 'gender', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (9, 1, 'birth_date', '出生日期', 'date', 'Date', 'birthDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (10, 1, 'political_status', '政治面貌', 'varchar(50)', 'String', 'politicalStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 10, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (11, 1, 'enrollment_date', '入学日期', 'date', 'Date', 'enrollmentDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (12, 1, 'dormitory', '宿舍', 'varchar(100)', 'String', 'dormitory', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (13, 1, 'home_address', '家庭地址', 'varchar(255)', 'String', 'homeAddress', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (14, 1, 'emergency_contact', '紧急联系人', 'varchar(50)', 'String', 'emergencyContact', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (15, 1, 'emergency_phone', '紧急联系电话', 'varchar(20)', 'String', 'emergencyPhone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (16, 1, 'status', '状态：0-禁用，1-启用', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 16, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (17, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, '1', 'EQ', 'datetime', '', 17, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (18, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, '1', 'EQ', 'datetime', '', 18, 'admin', '2025-09-24 09:31:53', '', '2025-09-27 19:12:32');
INSERT INTO `gen_table_column` VALUES (19, 2, 'id', '申诉ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (20, 2, 'record_id', '关联加分记录ID', 'bigint', 'Long', 'recordId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (21, 2, 'student_id', '学生ID', 'bigint', 'Long', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (22, 2, 'appeal_reason', '申诉理由', 'varchar(500)', 'String', 'appealReason', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (23, 2, 'status', '状态：0-待处理，1-已同意，2-已拒绝', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (24, 2, 'process_result', '处理结果', 'varchar(500)', 'String', 'processResult', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (25, 2, 'process_by', '处理人ID', 'bigint', 'Long', 'processBy', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (26, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (27, 2, 'process_time', '处理时间', 'datetime', 'Date', 'processTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2025-09-27 19:17:25', '', '2025-09-27 19:19:30');
INSERT INTO `gen_table_column` VALUES (28, 3, 'id', '学院ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (29, 3, 'college_name', '学院名称', 'varchar(64)', 'String', 'collegeName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (30, 3, 'college_code', '学院代码', 'varchar(32)', 'String', 'collegeCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (31, 3, 'director_id', '负责人ID（关联sys_user）', 'bigint', 'Long', 'directorId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (32, 3, 'status', '状态：0-禁用，1-启用', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (33, 3, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 6, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (34, 3, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-09-27 20:25:52', '', '2025-09-27 20:37:48');
INSERT INTO `gen_table_column` VALUES (35, 4, 'id', '记录ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (36, 4, 'user_id', '用户ID（关联sys_user）', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (37, 4, 'rule_id', '关联规则ID', 'bigint', 'Long', 'ruleId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (38, 4, 'material_path', '材料存储路径', 'varchar(256)', 'String', 'materialPath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (39, 4, 'material_type', '材料类型：PDF/JPG/PNG', 'varchar(16)', 'String', 'materialType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (40, 4, 'reason', '加分事由', 'varchar(200)', 'String', 'reason', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (41, 4, 'status', '状态：0-待班委审核，1-待辅导员审核，2-已通过，3-已拒绝', 'tinyint', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (42, 4, 'score', '最终加分值', 'decimal(5,2)', 'BigDecimal', 'score', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (43, 4, 'submit_time', '提交时间', 'datetime', 'Date', 'submitTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (44, 4, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-09-28 17:03:27', '', '2025-09-28 17:04:49');
INSERT INTO `gen_table_column` VALUES (45, 5, 'id', '测评体系ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (46, 5, 'system_name', '测评体系名称', 'varchar(128)', 'String', 'systemName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (47, 5, 'academic_year', '学年，如2023-2024', 'varchar(16)', 'String', 'academicYear', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (48, 5, 'semester', '学期：1-第一学期，2-第二学期', 'tinyint', 'Long', 'semester', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (49, 5, 'description', '测评体系描述', 'text', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (50, 5, 'status', '状态：0-未启用，1-已启用，2-已结束', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 6, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (51, 5, 'start_time', '开始时间', 'datetime', 'Date', 'startTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (52, 5, 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (53, 5, 'creator_id', '创建者ID', 'bigint', 'Long', 'creatorId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (54, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (55, 5, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2025-10-01 16:27:06', '', '2025-10-01 16:28:46');
INSERT INTO `gen_table_column` VALUES (56, 6, 'id', '成绩明细ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (57, 6, 'student_id', '学生ID', 'bigint', 'Long', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (58, 6, 'system_id', '测评体系ID', 'bigint', 'Long', 'systemId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (59, 6, 'item_id', '测评项目ID', 'bigint', 'Long', 'itemId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (60, 6, 'score', '得分', 'decimal(5,2)', 'BigDecimal', 'score', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (61, 6, 'evidence_url', '证明材料URL', 'varchar(500)', 'String', 'evidenceUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (62, 6, 'description', '申请说明', 'text', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (63, 6, 'status', '状态：0-待提交，1-待审核，2-已通过，3-已驳回', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (64, 6, 'audit_comment', '审核意见', 'text', 'String', 'auditComment', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (65, 6, 'auditor_id', '审核人ID', 'bigint', 'Long', 'auditorId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (66, 6, 'submit_time', '提交时间', 'datetime', 'Date', 'submitTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (67, 6, 'audit_time', '审核时间', 'datetime', 'Date', 'auditTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (68, 6, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (69, 6, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 14, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:35:29');
INSERT INTO `gen_table_column` VALUES (70, 7, 'id', '总成绩ID', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (71, 7, 'student_id', '学生ID', 'bigint', 'Long', 'studentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (72, 7, 'system_id', '测评体系ID', 'bigint', 'Long', 'systemId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (73, 7, 'total_score', '总分', 'decimal(8,2)', 'BigDecimal', 'totalScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (74, 7, 'moral_score', '思想品德分', 'decimal(6,2)', 'BigDecimal', 'moralScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (75, 7, 'study_score', '学习成绩分', 'decimal(6,2)', 'BigDecimal', 'studyScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (76, 7, 'practice_score', '社会实践分', 'decimal(6,2)', 'BigDecimal', 'practiceScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (77, 7, 'innovation_score', '创新创业分', 'decimal(6,2)', 'BigDecimal', 'innovationScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (78, 7, 'other_score', '其他加分', 'decimal(6,2)', 'BigDecimal', 'otherScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (79, 7, 'ranking', '排名', 'int', 'Long', 'ranking', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (80, 7, 'academic_year', '学年', 'varchar(16)', 'String', 'academicYear', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (81, 7, 'semester', '学期', 'tinyint', 'Long', 'semester', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (82, 7, 'status', '状态：0-计算中，1-已完成，2-已公示', 'tinyint', 'Long', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 13, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (83, 7, 'calculate_time', '计算时间', 'datetime', 'Date', 'calculateTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (84, 7, 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (85, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 16, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');
INSERT INTO `gen_table_column` VALUES (86, 7, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 17, 'admin', '2025-10-01 17:34:47', '', '2025-10-01 17:36:21');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-09-22 08:19:56', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '西安文理学院', 0, 'Ynchen', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:55:32');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '信息工程学院', 1, '胡淇', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:55:53');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '机械与材料工程学院', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:56:28');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '软件工程', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:57:44');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '计算机与科学', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:58:02');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '人工智能', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:58:12');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '大数据科学', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:58:21');
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '网络安全', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-01 14:59:32');
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '机械', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-23 14:42:34');
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '材料', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-10-23 14:42:42');
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '学生部门', 1, '胡淇', '13203094369', '1911779729@qq.com', '0', '2', 'admin', '2025-09-24 09:18:11', '', NULL);
INSERT INTO `sys_dept` VALUES (201, 100, '0,100', '辅导员部门', 2, '胡淇', '13203094369', '1911779729@qq.com', '0', '0', 'admin', '2025-09-24 09:18:54', 'admin', '2025-09-24 09:20:37');
INSERT INTO `sys_dept` VALUES (202, 100, '0,100', '班委部门', 3, '胡淇', '13203094369', '1911779729@qq.com', '0', '0', 'admin', '2025-09-24 09:19:50', 'admin', '2025-09-24 09:20:23');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-09-22 08:19:56', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-09-22 08:19:56', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-09-22 08:19:56', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-09-22 08:19:56', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 359 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-23 21:55:03');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-24 09:06:35');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-24 12:37:16');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-24 12:37:19');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-24 12:41:26');
INSERT INTO `sys_logininfor` VALUES (105, 'Ynchen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-24 12:41:34');
INSERT INTO `sys_logininfor` VALUES (106, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-24 12:41:43');
INSERT INTO `sys_logininfor` VALUES (107, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-25 15:49:06');
INSERT INTO `sys_logininfor` VALUES (108, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-25 15:49:13');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-25 15:49:25');
INSERT INTO `sys_logininfor` VALUES (110, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-25 15:51:10');
INSERT INTO `sys_logininfor` VALUES (111, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-25 15:51:26');
INSERT INTO `sys_logininfor` VALUES (112, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-25 15:51:38');
INSERT INTO `sys_logininfor` VALUES (113, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-25 15:53:10');
INSERT INTO `sys_logininfor` VALUES (114, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-09-25 15:53:14');
INSERT INTO `sys_logininfor` VALUES (115, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:54:23');
INSERT INTO `sys_logininfor` VALUES (116, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-25 15:54:25');
INSERT INTO `sys_logininfor` VALUES (117, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:55:25');
INSERT INTO `sys_logininfor` VALUES (118, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-25 15:55:25');
INSERT INTO `sys_logininfor` VALUES (119, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:55:31');
INSERT INTO `sys_logininfor` VALUES (120, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:56:08');
INSERT INTO `sys_logininfor` VALUES (121, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-09-25 15:59:11');
INSERT INTO `sys_logininfor` VALUES (122, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:59:17');
INSERT INTO `sys_logininfor` VALUES (123, '胡淇', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:59:47');
INSERT INTO `sys_logininfor` VALUES (124, '胡淇', '192.168.94.240', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 15:59:57');
INSERT INTO `sys_logininfor` VALUES (125, '胡淇', '192.168.94.240', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '密码输入错误5次，帐户锁定10分钟', '2025-09-25 16:01:40');
INSERT INTO `sys_logininfor` VALUES (126, '胡淇', '192.168.94.240', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-25 16:05:41');
INSERT INTO `sys_logininfor` VALUES (127, '胡淇', '192.168.94.240', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-25 16:05:50');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '192.168.94.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-26 09:19:31');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-26 09:23:42');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '退出成功', '2025-09-26 09:23:49');
INSERT INTO `sys_logininfor` VALUES (131, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-26 09:24:10');
INSERT INTO `sys_logininfor` VALUES (132, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-26 09:49:04');
INSERT INTO `sys_logininfor` VALUES (133, '2507240211', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2025-09-26 21:12:09');
INSERT INTO `sys_logininfor` VALUES (134, '2507240211', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2025-09-26 21:12:48');
INSERT INTO `sys_logininfor` VALUES (135, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2025-09-26 21:12:57');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2025-09-26 21:13:15');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-26 21:13:52');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-26 21:13:58');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2025-09-26 21:14:25');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-26 21:30:12');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 09:30:50');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 09:40:01');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 09:47:33');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 09:47:43');
INSERT INTO `sys_logininfor` VALUES (145, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 09:48:27');
INSERT INTO `sys_logininfor` VALUES (146, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 09:54:41');
INSERT INTO `sys_logininfor` VALUES (147, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 09:58:20');
INSERT INTO `sys_logininfor` VALUES (148, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码错误', '2025-09-27 09:58:30');
INSERT INTO `sys_logininfor` VALUES (149, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 09:58:40');
INSERT INTO `sys_logininfor` VALUES (150, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:24:57');
INSERT INTO `sys_logininfor` VALUES (151, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:25:26');
INSERT INTO `sys_logininfor` VALUES (152, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:25:35');
INSERT INTO `sys_logininfor` VALUES (153, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:25:41');
INSERT INTO `sys_logininfor` VALUES (154, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:26:29');
INSERT INTO `sys_logininfor` VALUES (155, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:26:49');
INSERT INTO `sys_logininfor` VALUES (156, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:26:55');
INSERT INTO `sys_logininfor` VALUES (157, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:28:06');
INSERT INTO `sys_logininfor` VALUES (158, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码错误', '2025-09-27 10:28:48');
INSERT INTO `sys_logininfor` VALUES (159, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:31:32');
INSERT INTO `sys_logininfor` VALUES (160, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:36:50');
INSERT INTO `sys_logininfor` VALUES (161, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:37:41');
INSERT INTO `sys_logininfor` VALUES (162, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:37:55');
INSERT INTO `sys_logininfor` VALUES (163, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:44:14');
INSERT INTO `sys_logininfor` VALUES (164, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:44:39');
INSERT INTO `sys_logininfor` VALUES (165, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:45:07');
INSERT INTO `sys_logininfor` VALUES (166, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:45:34');
INSERT INTO `sys_logininfor` VALUES (167, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:49:13');
INSERT INTO `sys_logininfor` VALUES (168, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:49:27');
INSERT INTO `sys_logininfor` VALUES (169, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:49:38');
INSERT INTO `sys_logininfor` VALUES (170, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 10:50:27');
INSERT INTO `sys_logininfor` VALUES (171, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码错误', '2025-09-27 10:50:36');
INSERT INTO `sys_logininfor` VALUES (172, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 10:50:52');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 10:56:14');
INSERT INTO `sys_logininfor` VALUES (174, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 11:22:36');
INSERT INTO `sys_logininfor` VALUES (175, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 11:22:41');
INSERT INTO `sys_logininfor` VALUES (176, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 11:23:49');
INSERT INTO `sys_logininfor` VALUES (177, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 11:23:54');
INSERT INTO `sys_logininfor` VALUES (178, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 11:24:14');
INSERT INTO `sys_logininfor` VALUES (179, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码错误', '2025-09-27 11:24:18');
INSERT INTO `sys_logininfor` VALUES (180, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 11:24:22');
INSERT INTO `sys_logininfor` VALUES (181, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 11:28:32');
INSERT INTO `sys_logininfor` VALUES (182, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 11:28:35');
INSERT INTO `sys_logininfor` VALUES (183, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 11:36:28');
INSERT INTO `sys_logininfor` VALUES (184, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 11:36:45');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 11:36:51');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 11:37:41');
INSERT INTO `sys_logininfor` VALUES (187, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-27 11:37:47');
INSERT INTO `sys_logininfor` VALUES (188, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 11:37:50');
INSERT INTO `sys_logininfor` VALUES (189, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2025-09-27 11:38:04');
INSERT INTO `sys_logininfor` VALUES (190, '胡淇', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 11:38:07');
INSERT INTO `sys_logininfor` VALUES (191, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 11:44:28');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 11:44:36');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 12:44:40');
INSERT INTO `sys_logininfor` VALUES (194, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-27 12:44:46');
INSERT INTO `sys_logininfor` VALUES (195, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 12:44:50');
INSERT INTO `sys_logininfor` VALUES (196, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-27 16:59:18');
INSERT INTO `sys_logininfor` VALUES (197, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 16:59:22');
INSERT INTO `sys_logininfor` VALUES (198, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-09-27 16:59:44');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-27 16:59:52');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 16:59:59');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2025-09-27 18:44:50');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-27 20:21:58');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-09-28 13:51:09');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-28 13:51:13');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-09-28 17:01:34');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 14:54:44');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 15:45:32');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 17:02:27');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-01 17:33:36');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-01 17:33:43');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-01 17:33:47');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 17:33:51');
INSERT INTO `sys_logininfor` VALUES (213, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 20:16:07');
INSERT INTO `sys_logininfor` VALUES (214, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 20:17:39');
INSERT INTO `sys_logininfor` VALUES (215, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-01 20:18:29');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 20:18:38');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-01 21:28:39');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-07 20:05:21');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-07 20:05:26');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-14 18:12:08');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-18 09:42:14');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-18 09:42:21');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码错误', '2025-10-18 09:43:39');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-18 09:43:43');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-18 10:52:54');
INSERT INTO `sys_logininfor` VALUES (226, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-18 10:53:01');
INSERT INTO `sys_logininfor` VALUES (227, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-18 10:53:46');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-18 10:53:52');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-18 10:55:39');
INSERT INTO `sys_logininfor` VALUES (230, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-18 10:55:46');
INSERT INTO `sys_logininfor` VALUES (231, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-18 10:55:50');
INSERT INTO `sys_logininfor` VALUES (232, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-19 20:35:02');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-20 09:20:14');
INSERT INTO `sys_logininfor` VALUES (234, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 09:21:11');
INSERT INTO `sys_logininfor` VALUES (235, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-10-20 15:46:10');
INSERT INTO `sys_logininfor` VALUES (236, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 15:46:16');
INSERT INTO `sys_logininfor` VALUES (237, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-20 15:53:02');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 15:53:08');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-20 17:31:23');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 17:31:27');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-20 17:36:49');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '退出成功', '2025-10-20 18:09:36');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '1', '验证码错误', '2025-10-20 18:09:43');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 18:09:48');
INSERT INTO `sys_logininfor` VALUES (245, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-20 18:14:45');
INSERT INTO `sys_logininfor` VALUES (246, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-20 18:14:50');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 18:14:53');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '退出成功', '2025-10-20 18:21:22');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 18:21:28');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '1', '验证码错误', '2025-10-20 20:37:18');
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '登录成功', '2025-10-20 20:37:21');
INSERT INTO `sys_logininfor` VALUES (252, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 20:51:52');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '退出成功', '2025-10-20 21:22:29');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 21:22:42');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '退出成功', '2025-10-20 21:28:25');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-20 21:30:49');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-21 10:03:19');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-21 10:05:34');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 19:45:31');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 21:02:46');
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-22 21:30:01');
INSERT INTO `sys_logininfor` VALUES (262, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 21:30:13');
INSERT INTO `sys_logininfor` VALUES (263, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-22 21:32:30');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 21:32:36');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-22 21:53:15');
INSERT INTO `sys_logininfor` VALUES (266, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 21:53:22');
INSERT INTO `sys_logininfor` VALUES (267, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-22 21:54:12');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 21:54:17');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-22 21:59:00');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-22 21:59:22');
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-22 21:59:30');
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-22 21:59:33');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 09:38:37');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 09:52:45');
INSERT INTO `sys_logininfor` VALUES (275, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 09:52:52');
INSERT INTO `sys_logininfor` VALUES (276, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 09:53:12');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-23 09:53:23');
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 09:53:28');
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-23 13:43:54');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-23 13:43:58');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-23 13:44:00');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-23 13:44:02');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 13:44:05');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 13:44:41');
INSERT INTO `sys_logininfor` VALUES (285, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 13:44:46');
INSERT INTO `sys_logininfor` VALUES (286, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 13:44:57');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 13:45:03');
INSERT INTO `sys_logininfor` VALUES (288, '胡淇', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '登录成功', '2025-10-23 14:24:29');
INSERT INTO `sys_logininfor` VALUES (289, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 14:25:25');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 14:25:31');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '退出成功', '2025-10-23 14:32:35');
INSERT INTO `sys_logininfor` VALUES (292, '胡淇', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '登录成功', '2025-10-23 14:32:43');
INSERT INTO `sys_logininfor` VALUES (293, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 14:33:28');
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 14:33:33');
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 14:34:02');
INSERT INTO `sys_logininfor` VALUES (296, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 14:34:11');
INSERT INTO `sys_logininfor` VALUES (297, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 14:34:19');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 14:34:25');
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 14:53:31');
INSERT INTO `sys_logininfor` VALUES (300, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 14:53:37');
INSERT INTO `sys_logininfor` VALUES (301, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 18:26:23');
INSERT INTO `sys_logininfor` VALUES (302, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 19:48:27');
INSERT INTO `sys_logininfor` VALUES (303, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 19:48:35');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 19:48:40');
INSERT INTO `sys_logininfor` VALUES (305, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-23 21:42:12');
INSERT INTO `sys_logininfor` VALUES (306, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-23 21:42:18');
INSERT INTO `sys_logininfor` VALUES (307, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 09:19:09');
INSERT INTO `sys_logininfor` VALUES (308, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-24 09:37:05');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 09:37:10');
INSERT INTO `sys_logininfor` VALUES (310, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 10:26:42');
INSERT INTO `sys_logininfor` VALUES (311, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 11:51:55');
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 14:11:13');
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 15:22:32');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 17:02:20');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '登录成功', '2025-10-24 19:47:43');
INSERT INTO `sys_logininfor` VALUES (316, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 21:02:40');
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-10-24 21:05:21');
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-24 21:05:24');
INSERT INTO `sys_logininfor` VALUES (319, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-25 09:50:05');
INSERT INTO `sys_logininfor` VALUES (320, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-25 10:49:34');
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-25 16:00:53');
INSERT INTO `sys_logininfor` VALUES (322, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-25 20:19:30');
INSERT INTO `sys_logininfor` VALUES (323, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-25 21:30:47');
INSERT INTO `sys_logininfor` VALUES (324, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-25 21:30:50');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '192.168.220.240', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-26 12:07:56');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-26 14:53:29');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-26 16:15:24');
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-26 20:55:04');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-26 21:26:44');
INSERT INTO `sys_logininfor` VALUES (330, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '登录成功', '2025-10-27 10:13:37');
INSERT INTO `sys_logininfor` VALUES (331, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 17:46:49');
INSERT INTO `sys_logininfor` VALUES (332, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 17:47:42');
INSERT INTO `sys_logininfor` VALUES (333, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-27 17:48:56');
INSERT INTO `sys_logininfor` VALUES (334, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 17:49:01');
INSERT INTO `sys_logininfor` VALUES (335, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 17:49:31');
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 17:50:47');
INSERT INTO `sys_logininfor` VALUES (337, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-27 17:50:55');
INSERT INTO `sys_logininfor` VALUES (338, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-27 17:51:00');
INSERT INTO `sys_logininfor` VALUES (339, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 20:47:36');
INSERT INTO `sys_logininfor` VALUES (340, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:13:27');
INSERT INTO `sys_logininfor` VALUES (341, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:13:33');
INSERT INTO `sys_logininfor` VALUES (342, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:14:13');
INSERT INTO `sys_logininfor` VALUES (343, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:14:21');
INSERT INTO `sys_logininfor` VALUES (344, 'admin', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '退出成功', '2025-10-28 21:19:11');
INSERT INTO `sys_logininfor` VALUES (345, '胡淇', '127.0.0.1', '内网IP', 'Safari', 'Mac OS X', '0', '登录成功', '2025-10-28 21:19:18');
INSERT INTO `sys_logininfor` VALUES (346, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-28 21:45:00');
INSERT INTO `sys_logininfor` VALUES (347, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-28 21:45:04');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-29 20:47:54');
INSERT INTO `sys_logininfor` VALUES (349, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-29 20:52:43');
INSERT INTO `sys_logininfor` VALUES (350, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-29 20:52:48');
INSERT INTO `sys_logininfor` VALUES (351, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-29 20:54:55');
INSERT INTO `sys_logininfor` VALUES (352, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-29 20:55:02');
INSERT INTO `sys_logininfor` VALUES (353, '胡淇', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-10-29 21:13:03');
INSERT INTO `sys_logininfor` VALUES (354, 'test', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-10-29 21:13:19');
INSERT INTO `sys_logininfor` VALUES (355, 'test', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-10-29 21:13:23');
INSERT INTO `sys_logininfor` VALUES (356, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-02 16:27:11');
INSERT INTO `sys_logininfor` VALUES (357, 'test1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-02 16:29:34');
INSERT INTO `sys_logininfor` VALUES (358, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-02 17:05:29');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2134 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-09-22 08:19:55', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-09-22 08:19:55', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-09-22 08:19:55', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, '/ruoyi-site', NULL, '', '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2025-09-22 08:19:55', 'admin', '2025-09-27 17:02:55', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-09-22 08:19:55', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-09-22 08:19:55', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-09-22 08:19:55', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-09-22 08:19:55', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-09-22 08:19:55', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-09-22 08:19:55', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-09-22 08:19:55', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-09-22 08:19:55', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-09-22 08:19:55', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-09-22 08:19:55', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-09-22 08:19:55', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-09-22 08:19:55', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-09-22 08:19:55', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-09-22 08:19:55', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-09-22 08:19:55', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-09-22 08:19:55', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-09-22 08:19:55', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-09-22 08:19:55', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-09-22 08:19:55', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-09-22 08:19:55', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-09-22 08:19:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '学生档案管理', 100, 1, 'profile', 'evaluation/profile/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:profile:list', '#', 'admin', '2025-09-24 09:46:19', '', NULL, '学生档案管理菜单');
INSERT INTO `sys_menu` VALUES (2001, '学生档案管理查询', 2000, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:profile:query', '#', 'admin', '2025-09-24 09:46:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '学生档案管理新增', 2000, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:profile:add', '#', 'admin', '2025-09-24 09:46:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '学生档案管理修改', 2000, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:profile:edit', '#', 'admin', '2025-09-24 09:46:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '学生档案管理删除', 2000, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:profile:remove', '#', 'admin', '2025-09-24 09:46:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '学生档案管理导出', 2000, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:profile:export', '#', 'admin', '2025-09-24 09:46:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '综测管理', 0, 1, 'evaluation', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'education', 'admin', '2025-09-27 12:32:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '学生档案管理', 2006, 1, 't_user_profile', 'evaluation/t_user_profile/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:t_user_profile:list', '#', 'admin', '2025-09-27 18:55:35', '', NULL, '学生档案管理菜单');
INSERT INTO `sys_menu` VALUES (2020, '学生档案管理查询', 2019, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_user_profile:query', '#', 'admin', '2025-09-27 18:55:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '学生档案管理新增', 2019, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_user_profile:add', '#', 'admin', '2025-09-27 18:55:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '学生档案管理修改', 2019, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_user_profile:edit', '#', 'admin', '2025-09-27 18:55:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '学生档案管理删除', 2019, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_user_profile:remove', '#', 'admin', '2025-09-27 18:55:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '学生档案管理导出', 2019, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_user_profile:export', '#', 'admin', '2025-09-27 18:55:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '申诉', 2006, 1, 't_appeal', 'evaluation/t_appeal/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:t_appeal:list', '#', 'admin', '2025-09-27 19:19:58', '', NULL, '申诉菜单');
INSERT INTO `sys_menu` VALUES (2026, '申诉查询', 2025, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_appeal:query', '#', 'admin', '2025-09-27 19:19:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '申诉新增', 2025, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_appeal:add', '#', 'admin', '2025-09-27 19:19:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '申诉修改', 2025, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_appeal:edit', '#', 'admin', '2025-09-27 19:19:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '申诉删除', 2025, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_appeal:remove', '#', 'admin', '2025-09-27 19:19:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '申诉导出', 2025, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_appeal:export', '#', 'admin', '2025-09-27 19:19:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '学院信息', 2006, 1, 'college_info', 'evaluation/college_info/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:college_info:list', '#', 'admin', '2025-09-27 20:38:21', '', NULL, '学院信息菜单');
INSERT INTO `sys_menu` VALUES (2038, '学院信息查询', 2037, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:college_info:query', '#', 'admin', '2025-09-27 20:38:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '学院信息新增', 2037, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:college_info:add', '#', 'admin', '2025-09-27 20:38:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '学院信息修改', 2037, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:college_info:edit', '#', 'admin', '2025-09-27 20:38:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '学院信息删除', 2037, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:college_info:remove', '#', 'admin', '2025-09-27 20:38:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '学院信息导出', 2037, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:college_info:export', '#', 'admin', '2025-09-27 20:38:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '考评加分记录', 2006, 1, 't_score_record', 'evaluation/t_score_record/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:t_score_record:list', '#', 'admin', '2025-09-28 17:05:24', '', NULL, '考评加分记录菜单');
INSERT INTO `sys_menu` VALUES (2044, '考评加分记录查询', 2043, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_score_record:query', '#', 'admin', '2025-09-28 17:05:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '考评加分记录新增', 2043, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_score_record:add', '#', 'admin', '2025-09-28 17:05:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '考评加分记录修改', 2043, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_score_record:edit', '#', 'admin', '2025-09-28 17:05:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '考评加分记录删除', 2043, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_score_record:remove', '#', 'admin', '2025-09-28 17:05:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '考评加分记录导出', 2043, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_score_record:export', '#', 'admin', '2025-09-28 17:05:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '测评体系', 2006, 1, 't_evaluation', 'evaluation/t_evaluation/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:t_evaluation:list', '#', 'admin', '2025-10-01 16:29:21', '', NULL, '测评体系菜单');
INSERT INTO `sys_menu` VALUES (2050, '测评体系查询', 2049, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_evaluation:query', '#', 'admin', '2025-10-01 16:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '测评体系新增', 2049, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_evaluation:add', '#', 'admin', '2025-10-01 16:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '测评体系修改', 2049, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_evaluation:edit', '#', 'admin', '2025-10-01 16:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '测评体系删除', 2049, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_evaluation:remove', '#', 'admin', '2025-10-01 16:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '测评体系导出', 2049, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_evaluation:export', '#', 'admin', '2025-10-01 16:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '学生成绩明细', 2006, 1, 't_student_score_detail', 'evaluation/t_student_score_detail/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:t_student_score_detail:list', '#', 'admin', '2025-10-01 17:38:01', '', NULL, '学生成绩明细菜单');
INSERT INTO `sys_menu` VALUES (2056, '学生成绩明细查询', 2055, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_score_detail:query', '#', 'admin', '2025-10-01 17:38:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '学生成绩明细新增', 2055, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_score_detail:add', '#', 'admin', '2025-10-01 17:38:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '学生成绩明细修改', 2055, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_score_detail:edit', '#', 'admin', '2025-10-01 17:38:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '学生成绩明细删除', 2055, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_score_detail:remove', '#', 'admin', '2025-10-01 17:38:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '学生成绩明细导出', 2055, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_score_detail:export', '#', 'admin', '2025-10-01 17:38:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '学生总成绩', 2006, 1, 't_student_total_score', 'evaluation/t_student_total_score/index', NULL, '', 1, 0, 'C', '0', '0', 'evaluation:t_student_total_score:list', '#', 'admin', '2025-10-01 17:40:53', '', NULL, '学生总成绩菜单');
INSERT INTO `sys_menu` VALUES (2062, '学生总成绩查询', 2061, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_total_score:query', '#', 'admin', '2025-10-01 17:40:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '学生总成绩新增', 2061, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_total_score:add', '#', 'admin', '2025-10-01 17:40:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '学生总成绩修改', 2061, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_total_score:edit', '#', 'admin', '2025-10-01 17:40:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '学生总成绩删除', 2061, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_total_score:remove', '#', 'admin', '2025-10-01 17:40:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '学生总成绩导出', 2061, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'evaluation:t_student_total_score:export', '#', 'admin', '2025-10-01 17:40:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '综测填报', 2006, 6, 'evaluation-submit', NULL, NULL, 'Evaluation', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2025-10-17 22:05:56', 'admin', '2025-10-20 18:20:47', '综合测评管理');
INSERT INTO `sys_menu` VALUES (2101, '我的填报', 2100, 1, 'submission', 'evaluation-submit/submission/SubmissionForm', NULL, 'Submission', 1, 0, 'C', '0', '0', 'evaluation:submission:list', 'edit', 'admin', '2025-10-17 22:05:56', 'admin', '2025-10-24 21:03:51', '综测填报');
INSERT INTO `sys_menu` VALUES (2102, '填报历史', 2100, 2, 'history', 'evaluation-submit/submission/history', NULL, 'History', 1, 0, 'C', '0', '0', 'evaluation:submission:history', 'time-range', 'admin', '2025-10-17 22:05:56', 'admin', '2025-10-18 09:59:36', '填报历史');
INSERT INTO `sys_menu` VALUES (2111, '查看填报', 2101, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:submission:query', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '新增填报', 2101, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:submission:add', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '修改填报', 2101, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:submission:edit', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2114, '删除填报', 2101, 4, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:submission:remove', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2115, '提交填报', 2101, 5, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:submission:submit', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2116, '上传附件', 2101, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:attachment:upload', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2117, '下载附件', 2101, 7, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:attachment:download', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '填报审核', 2100, 3, 'audit', 'evaluation-submit/audit/index', NULL, 'Audit', 1, 0, 'C', '0', '0', 'evaluation:audit:list', 'checkbox', 'admin', '2025-10-17 22:05:56', 'admin', '2025-10-18 10:00:49', '填报审核');
INSERT INTO `sys_menu` VALUES (2121, '成绩统计', 2100, 4, 'statistics', 'evaluation-submit/statistics/index', NULL, 'Statistics', 1, 0, 'C', '0', '0', 'evaluation:statistics:list', 'chart', 'admin', '2025-10-17 22:05:56', 'admin', '2025-10-18 09:59:46', '成绩统计');
INSERT INTO `sys_menu` VALUES (2131, '审核通过', 2120, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:audit:approve', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '审核驳回', 2120, 2, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:audit:reject', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2133, '查看详情', 2120, 3, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'evaluation:audit:detail', '#', 'admin', '2025-10-17 22:05:56', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-09-22 08:19:56', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-09-22 08:19:56', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (10, 'AI助手功能上线啦', '2', 0x3C703E4149E58AA9E6898BE58FAFE99A8FE6848FE68B96E68BBDEFBC8CE782B9E587BBE58DB3E58FAFE5BC80E5A78BE5AFB9E8AF9DEFBC8CE58FAFE68EA7E588B6E5AFB9E8AF9DE6A186E5A4A7E5B08FEFBC8CE6ACA2E8BF8EE4BDBFE794A8E59180EFBC813C2F703E, '0', 'admin', '2025-10-21 10:05:26', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 284 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"学生部门\",\"email\":\"1911779729@qq.com\",\"leader\":\"胡淇\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"phone\":\"13203094369\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:18:11', 16);
INSERT INTO `sys_oper_log` VALUES (101, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"管理员部门\",\"email\":\"1911779729@qq.com\",\"leader\":\"胡淇\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"phone\":\"13203094369\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:18:54', 15);
INSERT INTO `sys_oper_log` VALUES (102, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"学委部门\",\"email\":\"1911779729@qq.com\",\"leader\":\"胡淇\",\"orderNum\":3,\"params\":{},\"parentId\":100,\"phone\":\"13203094369\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:19:50', 14);
INSERT INTO `sys_oper_log` VALUES (103, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":202,\"deptName\":\"班委部门\",\"email\":\"1911779729@qq.com\",\"leader\":\"胡淇\",\"orderNum\":3,\"params\":{},\"parentId\":100,\"parentName\":\"若依科技\",\"phone\":\"13203094369\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:20:23', 27);
INSERT INTO `sys_oper_log` VALUES (104, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":201,\"deptName\":\"辅导员部门\",\"email\":\"1911779729@qq.com\",\"leader\":\"胡淇\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"若依科技\",\"phone\":\"13203094369\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:20:37', 28);
INSERT INTO `sys_oper_log` VALUES (105, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":200,\"email\":\"1911779729@qq.com\",\"nickName\":\"Ynchen\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[4],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"胡淇\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:22:50', 84);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_user_profile\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:31:53', 68);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"profile\",\"className\":\"TUserProfile\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"档案ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联sys_user表的用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学号\",\"columnId\":3,\"columnName\":\"student_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"College\",\"columnComment\":\"学院名称\",\"columnId\":4,\"columnName\":\"college\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 09:43:36', 58);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_user_profile\"}', NULL, 0, NULL, '2025-09-24 09:43:41', 48);
INSERT INTO `sys_oper_log` VALUES (109, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":200,\"email\":\"2364598338@qq.com\",\"nickName\":\"ry\",\"params\":{},\"phonenumber\":\"17589733957\",\"postIds\":[4],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"admin\"}', '{\"msg\":\"新增用户\'admin\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-09-24 12:40:47', 9);
INSERT INTO `sys_oper_log` VALUES (110, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":200,\"email\":\"2364598338@qq.com\",\"nickName\":\"test\",\"params\":{},\"phonenumber\":\"17589733957\",\"postIds\":[4],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"admin\"}', '{\"msg\":\"新增用户\'admin\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-09-24 12:40:56', 5);
INSERT INTO `sys_oper_log` VALUES (111, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":200,\"email\":\"2364598338@qq.com\",\"nickName\":\"test\",\"params\":{},\"phonenumber\":\"17589733957\",\"postIds\":[4],\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"test\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 12:41:06', 89);
INSERT INTO `sys_oper_log` VALUES (112, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, '胡淇', '学生部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-24 12:42:18', 194);
INSERT INTO `sys_oper_log` VALUES (113, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"学生角色 - 可提交材料和查看自己成绩\",\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 10:58:00', 21);
INSERT INTO `sys_oper_log` VALUES (114, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,3,116,2000,2001,2002,2003,2004,2005,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,1060],\"params\":{},\"remark\":\"学生角色 - 可提交材料和查看自己成绩\",\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 11:56:10', 28);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"综测管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"evaluation\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 12:32:45', 14);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-09-22 08:19:55\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:02:55', 14);
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_user_profile\"}', NULL, 0, NULL, '2025-09-27 17:12:32', 147);
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_user_profile\",\"className\":\"TUserProfile\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"档案ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-24 09:43:36\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联sys_user表的用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-24 09:43:36\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学号\",\"columnId\":3,\"columnName\":\"student_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-24 09:43:36\",\"usableColumn\":false},{\"capJavaField\":\"College\",\"columnComment\":\"学院名称\",\"columnId\":4,\"columnName\":\"college\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 17:18:33', 46);
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_user_profile\"}', NULL, 0, NULL, '2025-09-27 17:21:54', 35);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2007', '127.0.0.1', '内网IP', '2007', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2025-09-27 18:49:05', 15);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2012', '127.0.0.1', '内网IP', '2012', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:49:22', 16);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2011', '127.0.0.1', '内网IP', '2011', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:49:28', 16);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2010', '127.0.0.1', '内网IP', '2010', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:49:32', 21);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2009', '127.0.0.1', '内网IP', '2009', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:49:36', 14);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2008', '127.0.0.1', '内网IP', '2008', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:49:39', 14);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2007', '127.0.0.1', '内网IP', '2007', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:49:43', 18);
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"evaluation\",\"className\":\"TUserProfile\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"档案ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 17:18:33\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联sys_user表的用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 17:18:33\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学号\",\"columnId\":3,\"columnName\":\"student_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 17:18:33\",\"usableColumn\":false},{\"capJavaField\":\"College\",\"columnComment\":\"学院名称\",\"columnId\":4,\"columnName\":\"college\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isE', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:50:50', 55);
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_user_profile\"}', NULL, 0, NULL, '2025-09-27 18:52:35', 134);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_user_profile\",\"className\":\"TUserProfile\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"档案ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 18:50:50\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联sys_user表的用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 18:50:50\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学号\",\"columnId\":3,\"columnName\":\"student_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 18:50:50\",\"usableColumn\":false},{\"capJavaField\":\"College\",\"columnComment\":\"学院名称\",\"columnId\":4,\"columnName\":\"college\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 18:54:50', 101);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_user_profile\"}', NULL, 0, NULL, '2025-09-27 18:55:14', 190);
INSERT INTO `sys_oper_log` VALUES (131, '学生档案管理', 1, 'com.ruoyi.web.controller.evaluation.TUserProfileController.add()', 'POST', 1, 'admin', '研发部门', '/evaluation/t_user_profile', '127.0.0.1', '内网IP', '{\"birthDate\":\"2019-09-02\",\"className\":\"2402\",\"college\":\"信息工程学院\",\"createTime\":\"2025-09-27 19:08:41\",\"dormitory\":\"615\",\"emergencyContact\":\"父亲\",\"emergencyPhone\":\"13203094369\",\"enrollmentDate\":\"2024-09-01\",\"grade\":\"24级\",\"homeAddress\":\"湖南\",\"id\":1,\"major\":\"软件工程\",\"params\":{},\"studentId\":\"2507240211\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:08:41', 47);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2013', '127.0.0.1', '内网IP', '2013', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2025-09-27 19:09:15', 5);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2013', '127.0.0.1', '内网IP', '2013', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2025-09-27 19:09:21', 3);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2014', '127.0.0.1', '内网IP', '2014', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:09:27', 22);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2016', '127.0.0.1', '内网IP', '2016', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:09:30', 21);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2017', '127.0.0.1', '内网IP', '2017', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:09:34', 17);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2018', '127.0.0.1', '内网IP', '2018', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:09:35', 11);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2015', '127.0.0.1', '内网IP', '2015', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:09:38', 9);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2013', '127.0.0.1', '内网IP', '2013', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:09:40', 15);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2019', '127.0.0.1', '内网IP', '2019', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2025-09-27 19:09:41', 4);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_user_profile\",\"className\":\"TUserProfile\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"档案ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 18:54:50\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"关联sys_user表的用户ID\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 18:54:50\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学号\",\"columnId\":3,\"columnName\":\"student_id\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 18:54:50\",\"usableColumn\":false},{\"capJavaField\":\"College\",\"columnComment\":\"学院名称\",\"columnId\":4,\"columnName\":\"college\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:31:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:12:32', 55);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_appeal\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:17:25', 54);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_appeal\",\"className\":\"TAppeal\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"申诉ID\",\"columnId\":19,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 19:17:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RecordId\",\"columnComment\":\"关联加分记录ID\",\"columnId\":20,\"columnName\":\"record_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 19:17:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID\",\"columnId\":21,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 19:17:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AppealReason\",\"columnComment\":\"申诉理由\",\"columnId\":22,\"columnName\":\"appeal_reason\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 19:17:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"jav', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 19:19:31', 26);
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_appeal\"}', NULL, 0, NULL, '2025-09-27 19:19:34', 126);
INSERT INTO `sys_oper_log` VALUES (145, '申诉', 1, 'com.ruoyi.web.controller.evaluation.TAppealController.add()', 'POST', 1, 'admin', '研发部门', '/evaluation/t_appeal', '127.0.0.1', '内网IP', '{\"appealReason\":\"蓝桥杯比赛没有加分\",\"createTime\":\"2025-09-27 19:24:02\",\"params\":{},\"recordId\":1,\"studentId\":100}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TAppealMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TAppealMapper.insertTAppeal-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into t_appeal          ( record_id,             student_id,             appeal_reason,                                                    create_time )           values ( ?,             ?,             ?,                                                    ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)\n; Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)', '2025-09-27 19:24:02', 67);
INSERT INTO `sys_oper_log` VALUES (146, '申诉', 1, 'com.ruoyi.web.controller.evaluation.TAppealController.add()', 'POST', 1, 'admin', '研发部门', '/evaluation/t_appeal', '127.0.0.1', '内网IP', '{\"appealReason\":\"蓝桥杯比赛没有加分\",\"createTime\":\"2025-09-27 19:24:14\",\"params\":{},\"processBy\":1,\"processResult\":\"666\",\"processTime\":\"2025-09-08\",\"recordId\":1,\"studentId\":100}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TAppealMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TAppealMapper.insertTAppeal-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into t_appeal          ( record_id,             student_id,             appeal_reason,                          process_result,             process_by,             create_time,             process_time )           values ( ?,             ?,             ?,                          ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)\n; Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)', '2025-09-27 19:24:14', 13);
INSERT INTO `sys_oper_log` VALUES (147, '申诉', 1, 'com.ruoyi.web.controller.evaluation.TAppealController.add()', 'POST', 1, 'admin', '研发部门', '/evaluation/t_appeal', '127.0.0.1', '内网IP', '{\"appealReason\":\"蓝桥杯比赛没有加分\",\"createTime\":\"2025-09-27 19:24:26\",\"params\":{},\"processBy\":1,\"processResult\":\"666\",\"processTime\":\"2025-09-08\",\"recordId\":1,\"studentId\":100}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TAppealMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TAppealMapper.insertTAppeal-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into t_appeal          ( record_id,             student_id,             appeal_reason,                          process_result,             process_by,             create_time,             process_time )           values ( ?,             ?,             ?,                          ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)\n; Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT); nested exception is java.sql.SQLIntegrityConstraintViolationException: Cannot add or update a child row: a foreign key constraint fails (`ry-vue`.`t_appeal`, CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT)', '2025-09-27 19:24:26', 13);
INSERT INTO `sys_oper_log` VALUES (148, '申诉', 1, 'com.ruoyi.web.controller.evaluation.TAppealController.add()', 'POST', 1, 'admin', '研发部门', '/evaluation/t_appeal', '127.0.0.1', '内网IP', '{\"appealReason\":\"蓝桥杯没加分\",\"createTime\":\"2025-09-27 20:24:22\",\"id\":4,\"params\":{},\"processBy\":1,\"processResult\":\"通过\",\"processTime\":\"2025-09-23\",\"recordId\":1,\"studentId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:24:22', 14);
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_college_info\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:25:52', 58);
INSERT INTO `sys_oper_log` VALUES (150, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"college_info\",\"className\":\"TCollegeInfo\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"学院ID\",\"columnId\":28,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CollegeName\",\"columnComment\":\"学院名称\",\"columnId\":29,\"columnName\":\"college_name\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"collegeName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CollegeCode\",\"columnComment\":\"学院代码\",\"columnId\":30,\"columnName\":\"college_code\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"collegeCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DirectorId\",\"columnComment\":\"负责人ID（关联sys_user）\",\"columnId\":31,\"columnName\":\"director_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:26:54', 27);
INSERT INTO `sys_oper_log` VALUES (151, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_college_info\"}', NULL, 0, NULL, '2025-09-27 20:26:58', 152);
INSERT INTO `sys_oper_log` VALUES (152, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"college_info\",\"className\":\"TCollegeInfo\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"学院ID\",\"columnId\":28,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 20:26:54\",\"usableColumn\":false},{\"capJavaField\":\"CollegeName\",\"columnComment\":\"学院名称\",\"columnId\":29,\"columnName\":\"college_name\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"collegeName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 20:26:54\",\"usableColumn\":false},{\"capJavaField\":\"CollegeCode\",\"columnComment\":\"学院代码\",\"columnId\":30,\"columnName\":\"college_code\",\"columnType\":\"varchar(32)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"collegeCode\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-09-27 20:26:54\",\"usableColumn\":false},{\"capJavaField\":\"DirectorId\",\"columnComment\":\"负责人ID（关联sys_user）\",\"columnId\":31,\"columnName\":\"director_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-27 20:25:52\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"inp', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:37:48', 42);
INSERT INTO `sys_oper_log` VALUES (153, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_college_info\"}', NULL, 0, NULL, '2025-09-27 20:37:52', 138);
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2032', '127.0.0.1', '内网IP', '2032', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:43:33', 37);
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2033', '127.0.0.1', '内网IP', '2033', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:43:35', 20);
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2034', '127.0.0.1', '内网IP', '2034', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:43:36', 17);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2035', '127.0.0.1', '内网IP', '2035', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:43:37', 14);
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2036', '127.0.0.1', '内网IP', '2036', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:43:39', 25);
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2031', '127.0.0.1', '内网IP', '2031', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:43:43', 20);
INSERT INTO `sys_oper_log` VALUES (160, '学院信息', 1, 'com.ruoyi.web.controller.evaluation.TCollegeInfoController.add()', 'POST', 1, 'admin', '研发部门', '/evaluation/college_info', '127.0.0.1', '内网IP', '{\"collegeCode\":\"JC\",\"collegeName\":\"机械与材料工程学院\",\"createTime\":\"2025-09-27 20:45:37\",\"id\":4,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-27 20:45:37', 18);
INSERT INTO `sys_oper_log` VALUES (161, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_score_record\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-28 17:03:27', 65);
INSERT INTO `sys_oper_log` VALUES (162, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_score_record\",\"className\":\"TScoreRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录ID\",\"columnId\":35,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-28 17:03:27\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID（关联sys_user）\",\"columnId\":36,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-28 17:03:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RuleId\",\"columnComment\":\"关联规则ID\",\"columnId\":37,\"columnName\":\"rule_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-09-28 17:03:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"ruleId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MaterialPath\",\"columnComment\":\"材料存储路径\",\"columnId\":38,\"columnName\":\"material_path\",\"columnType\":\"varchar(256)\",\"createBy\":\"admin\",\"createTime\":\"2025-09-28 17:03:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-09-28 17:04:49', 32);
INSERT INTO `sys_oper_log` VALUES (163, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_score_record\"}', NULL, 0, NULL, '2025-09-28 17:04:52', 112);
INSERT INTO `sys_oper_log` VALUES (164, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"西安文理学院\",\"email\":\"ry@qq.com\",\"leader\":\"Ynchen\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:55:32', 20);
INSERT INTO `sys_oper_log` VALUES (165, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"信息工程学院\",\"email\":\"ry@qq.com\",\"leader\":\"胡淇\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"西安文理学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:55:53', 39);
INSERT INTO `sys_oper_log` VALUES (166, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"机械与材料工程学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"西安文理学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:56:28', 30);
INSERT INTO `sys_oper_log` VALUES (167, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"软件工程\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:57:44', 22);
INSERT INTO `sys_oper_log` VALUES (168, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"计算机与科学\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:58:02', 21);
INSERT INTO `sys_oper_log` VALUES (169, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"人工智能\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:58:12', 28);
INSERT INTO `sys_oper_log` VALUES (170, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":106,\"deptName\":\"大数据科学\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":4,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:58:21', 23);
INSERT INTO `sys_oper_log` VALUES (171, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":107,\"deptName\":\"网络安全\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":5,\"params\":{},\"parentId\":101,\"parentName\":\"信息工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 14:59:32', 16);
INSERT INTO `sys_oper_log` VALUES (172, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:22:50\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":200,\"deptName\":\"学生部门\",\"leader\":\"胡淇\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":103,\"email\":\"1911779729@qq.com\",\"loginDate\":\"2025-09-27 16:59:23\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"Ynchen\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[4],\"pwdUpdateDate\":\"2025-09-24 12:42:18\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"胡淇\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 15:00:14', 34);
INSERT INTO `sys_oper_log` VALUES (173, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 12:41:06\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":200,\"deptName\":\"学生部门\",\"leader\":\"胡淇\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":104,\"email\":\"2364598338@qq.com\",\"loginIp\":\"\",\"nickName\":\"test\",\"params\":{},\"phonenumber\":\"17589733957\",\"postIds\":[4],\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":101,\"userName\":\"test\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 15:00:24', 17);
INSERT INTO `sys_oper_log` VALUES (174, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '软件工程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_evaluation_system\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 16:27:06', 52);
INSERT INTO `sys_oper_log` VALUES (175, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '软件工程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_evaluation\",\"className\":\"TEvaluationSystem\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"测评体系ID\",\"columnId\":45,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 16:27:06\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SystemName\",\"columnComment\":\"测评体系名称\",\"columnId\":46,\"columnName\":\"system_name\",\"columnType\":\"varchar(128)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 16:27:06\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"systemName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AcademicYear\",\"columnComment\":\"学年，如2023-2024\",\"columnId\":47,\"columnName\":\"academic_year\",\"columnType\":\"varchar(16)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 16:27:06\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"academicYear\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Semester\",\"columnComment\":\"学期：1-第一学期，2-第二学期\",\"columnId\":48,\"columnName\":\"semester\",\"columnType\":\"tinyint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 16:27:06\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 16:28:46', 34);
INSERT INTO `sys_oper_log` VALUES (176, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '软件工程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_evaluation_system\"}', NULL, 0, NULL, '2025-10-01 16:28:57', 115);
INSERT INTO `sys_oper_log` VALUES (177, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '软件工程', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"t_student_total_score,t_student_score_detail\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 17:34:48', 94);
INSERT INTO `sys_oper_log` VALUES (178, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '软件工程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_student_score_detail\",\"className\":\"TStudentScoreDetail\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"成绩明细ID\",\"columnId\":56,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID\",\"columnId\":57,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SystemId\",\"columnComment\":\"测评体系ID\",\"columnId\":58,\"columnName\":\"system_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"systemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"测评项目ID\",\"columnId\":59,\"columnName\":\"item_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 17:35:29', 37);
INSERT INTO `sys_oper_log` VALUES (179, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '软件工程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_student_total_score\",\"className\":\"TStudentTotalScore\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"总成绩ID\",\"columnId\":70,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID\",\"columnId\":71,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SystemId\",\"columnComment\":\"测评体系ID\",\"columnId\":72,\"columnName\":\"system_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"systemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TotalScore\",\"columnComment\":\"总分\",\"columnId\":73,\"columnName\":\"total_score\",\"columnType\":\"decimal(8,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 17:35:54', 40);
INSERT INTO `sys_oper_log` VALUES (180, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '软件工程', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"t_student_total_score\",\"className\":\"TStudentTotalScore\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"总成绩ID\",\"columnId\":70,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-10-01 17:35:54\",\"usableColumn\":false},{\"capJavaField\":\"StudentId\",\"columnComment\":\"学生ID\",\"columnId\":71,\"columnName\":\"student_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-10-01 17:35:54\",\"usableColumn\":false},{\"capJavaField\":\"SystemId\",\"columnComment\":\"测评体系ID\",\"columnId\":72,\"columnName\":\"system_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"systemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-10-01 17:35:54\",\"usableColumn\":false},{\"capJavaField\":\"TotalScore\",\"columnComment\":\"总分\",\"columnId\":73,\"columnName\":\"total_score\",\"columnType\":\"decimal(8,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-10-01 17:34:47\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 17:36:21', 23);
INSERT INTO `sys_oper_log` VALUES (181, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '软件工程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_student_score_detail\"}', NULL, 0, NULL, '2025-10-01 17:36:43', 42);
INSERT INTO `sys_oper_log` VALUES (182, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '软件工程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_student_score_detail\"}', NULL, 0, NULL, '2025-10-01 17:37:39', 25);
INSERT INTO `sys_oper_log` VALUES (183, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '软件工程', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"t_student_total_score\"}', NULL, 0, NULL, '2025-10-01 17:40:35', 53);
INSERT INTO `sys_oper_log` VALUES (184, '在线用户', 7, 'com.ruoyi.web.controller.monitor.SysUserOnlineController.forceLogout()', 'DELETE', 1, '胡淇', '软件工程', '/monitor/online/fcee1954-da33-4814-861a-793664e22e89', '127.0.0.1', '内网IP', '\"fcee1954-da33-4814-861a-793664e22e89\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 20:17:33', 6);
INSERT INTO `sys_oper_log` VALUES (185, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"综测填报\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"comprehensive-evaluation\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-01 20:35:12', 12);
INSERT INTO `sys_oper_log` VALUES (186, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/submission/index\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2101,\"menuName\":\"我的填报\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2100,\"path\":\"submission\",\"perms\":\"evaluation:submission:list\",\"routeName\":\"Submission\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 09:59:30', 35);
INSERT INTO `sys_oper_log` VALUES (187, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/submission/history\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"time-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2102,\"menuName\":\"填报历史\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2100,\"path\":\"history\",\"perms\":\"evaluation:submission:history\",\"routeName\":\"History\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 09:59:36', 20);
INSERT INTO `sys_oper_log` VALUES (188, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/audit/index\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"check\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2120,\"menuName\":\"填报审核\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2100,\"path\":\"audit\",\"perms\":\"evaluation:audit:list\",\"routeName\":\"Audit\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 09:59:42', 29);
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/statistics/index\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2121,\"menuName\":\"成绩统计\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2100,\"path\":\"statistics\",\"perms\":\"evaluation:statistics:list\",\"routeName\":\"Statistics\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 09:59:46', 30);
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/audit/index\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"checkbox\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2120,\"menuName\":\"填报审核\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2100,\"path\":\"audit\",\"perms\":\"evaluation:audit:list\",\"routeName\":\"Audit\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 10:00:49', 32);
INSERT INTO `sys_oper_log` VALUES (191, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[3,116,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,1060,2100,2101,2111,2112,2113,2114,2115,2116,2117,2102,2120,2131,2132,2133,2121],\"params\":{},\"remark\":\"学生角色 - 可提交材料和查看自己成绩\",\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 10:54:51', 50);
INSERT INTO `sys_oper_log` VALUES (192, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2100,2101,2111,2112,2113,2114,2115,2116,2117,2102,2120,2131,2132,2133,2121],\"params\":{},\"remark\":\"班委角色 - 可初审学生材料\",\"roleId\":101,\"roleKey\":\"monitor\",\"roleName\":\"班委\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-18 10:55:05', 55);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2100,\"menuName\":\"综测填报\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":2006,\"path\":\"evaluation-submit\",\"perms\":\"\",\"routeName\":\"Evaluation\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-20 18:20:47', 19);
INSERT INTO `sys_oper_log` VALUES (194, '通知公告', 1, 'com.ruoyi.web.controller.system.SysNoticeController.add()', 'POST', 1, 'admin', '软件工程', '/system/notice', '192.168.220.240', '内网IP', '{\"createBy\":\"admin\",\"noticeContent\":\"<p>AI助手可随意拖拽，点击即可开始对话，可控制对话框大小，欢迎使用呀！</p>\",\"noticeTitle\":\"AI助手功能上线啦\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-21 10:05:26', 22);
INSERT INTO `sys_oper_log` VALUES (195, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":201,\"email\":\"gaojin@qq.com\",\"nickName\":\"高瑾\",\"params\":{},\"phonenumber\":\"13203094366\",\"postIds\":[],\"roleIds\":[102],\"sex\":\"1\",\"status\":\"0\",\"userId\":102,\"userName\":\"高瑾\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 19:50:33', 152);
INSERT INTO `sys_oper_log` VALUES (196, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":202,\"email\":\"1911779729@qq.com\",\"nickName\":\"huqi\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[],\"roleIds\":[101,100],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"胡淇\"}', '{\"msg\":\"新增用户\'胡淇\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-10-22 19:51:41', 10);
INSERT INTO `sys_oper_log` VALUES (197, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":202,\"email\":\"1911779729@qq.com\",\"nickName\":\"huqi\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[],\"roleIds\":[101,100],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"胡淇\"}', '{\"msg\":\"新增用户\'胡淇\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-10-22 19:52:03', 9);
INSERT INTO `sys_oper_log` VALUES (198, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-09-24 09:22:50\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"软件工程\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"1911779729@qq.com\",\"loginDate\":\"2025-10-20 15:46:17\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"Ynchen\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[4],\"pwdUpdateDate\":\"2025-09-24 12:42:18\",\"roleIds\":[100,101],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"胡淇\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-22 20:01:32', 58);
INSERT INTO `sys_oper_log` VALUES (199, '角色管理', 5, 'com.ruoyi.web.controller.system.SysRoleController.export()', 'POST', 1, 'admin', '软件工程', '/system/role/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-10-22 21:26:51', 593);
INSERT INTO `sys_oper_log` VALUES (200, '用户管理', 5, 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', 1, 'admin', '软件工程', '/system/user/export', '127.0.0.1', '内网IP', '{\"deptId\":\"100\",\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-10-22 21:27:11', 45);
INSERT INTO `sys_oper_log` VALUES (201, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, '胡淇', '班委部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/10/22/759d6d17fade46d18deb67f53d93668f.jpg\",\"code\":200}', 0, NULL, '2025-10-22 21:30:58', 371);
INSERT INTO `sys_oper_log` VALUES (202, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '软件工程', '/system/dept/200', '127.0.0.1', '内网IP', '200', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 14:42:14', 34);
INSERT INTO `sys_oper_log` VALUES (203, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"机械\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"parentName\":\"机械与材料工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 14:42:34', 23);
INSERT INTO `sys_oper_log` VALUES (204, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":109,\"deptName\":\"材料\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":102,\"parentName\":\"机械与材料工程学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 14:42:42', 44);
INSERT INTO `sys_oper_log` VALUES (205, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,3,116,2100,2101,2111,2112,2113,2114,2115,2116,2117,2102,2120,2131,2132,2133,2121,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,1060],\"params\":{},\"remark\":\"学生角色 - 可提交材料和查看自己成绩\",\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 14:52:59', 80);
INSERT INTO `sys_oper_log` VALUES (206, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2100,2101,2111,2112,2113,2114,2115,2116,2117,2102,2120,2131,2132,2133,2121,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"remark\":\"班委角色 - 可初审学生材料\",\"roleId\":101,\"roleKey\":\"monitor\",\"roleName\":\"班委\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 14:53:09', 42);
INSERT INTO `sys_oper_log` VALUES (207, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/submission/index\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2101,\"menuName\":\"我的填报\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2100,\"path\":\"submission\",\"perms\":\"evaluation:submission:list\",\"routeName\":\"Submission\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 20:08:14', 23);
INSERT INTO `sys_oper_log` VALUES (208, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"createTime\":\"2025-10-23 21:32:43\",\"params\":{},\"semester\":1,\"status\":0,\"totalScore\":0.00}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'student_id\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'student_id\' cannot be null\n; Column \'student_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'student_id\' cannot be null', '2025-10-23 21:32:44', 330);
INSERT INTO `sys_oper_log` VALUES (209, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"createTime\":\"2025-10-23 21:32:47\",\"params\":{},\"semester\":1,\"status\":1,\"submitTime\":\"2025-10-23 21:32:46\",\"totalScore\":0.00}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'student_id\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'student_id\' cannot be null\n; Column \'student_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'student_id\' cannot be null', '2025-10-23 21:32:47', 7);
INSERT INTO `sys_oper_log` VALUES (210, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"createTime\":\"2025-10-23 21:41:37\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"1\",\"studentName\":\"若依\",\"submitTime\":\"2025-10-23 21:41:36\",\"totalScore\":0.00}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 21:41:37', 23);
INSERT INTO `sys_oper_log` VALUES (211, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"100\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:42:47\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:42:47', 0);
INSERT INTO `sys_oper_log` VALUES (212, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"100\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:42:52\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:42:52', 1);
INSERT INTO `sys_oper_log` VALUES (213, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":0,\"studentId\":\"100\",\"studentName\":\"Ynchen\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:42:55', 1);
INSERT INTO `sys_oper_log` VALUES (214, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"100\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:42:58\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:42:58', 1);
INSERT INTO `sys_oper_log` VALUES (215, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"100\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:49:18\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:49:18', 1);
INSERT INTO `sys_oper_log` VALUES (216, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"100\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:50:02\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:50:02', 1);
INSERT INTO `sys_oper_log` VALUES (217, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"100\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:50:11\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:50:11', 1);
INSERT INTO `sys_oper_log` VALUES (218, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"胡淇\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:53:26\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:53:26', 1);
INSERT INTO `sys_oper_log` VALUES (219, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"胡淇\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 21:53:48\"}', '{\"msg\":\"无权限操作该学生数据\",\"code\":500}', 0, NULL, '2025-10-23 21:53:48', 0);
INSERT INTO `sys_oper_log` VALUES (220, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"createTime\":\"2025-10-23 22:01:18\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"胡淇\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 22:01:17\",\"totalScore\":0.00}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-23 22:01:18', 148);
INSERT INTO `sys_oper_log` VALUES (221, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"createTime\":\"2025-10-23 22:03:02\",\"params\":{},\"semester\":1,\"status\":1,\"studentId\":\"胡淇\",\"studentName\":\"Ynchen\",\"submitTime\":\"2025-10-23 22:03:02\",\"totalScore\":0.00}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\n; Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'', '2025-10-23 22:03:03', 77);
INSERT INTO `sys_oper_log` VALUES (222, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 09:34:35\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[]\",\"moralScore\":0,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":1,\"status\":0,\"studentId\":\"胡淇\",\"studentName\":\"Ynchen\",\"totalScore\":0.00}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\n; Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'胡淇-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'', '2025-10-24 09:34:35', 65);
INSERT INTO `sys_oper_log` VALUES (223, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 10:37:29\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[{\\\"type\\\":\\\"custom\\\",\\\"name\\\":\\\"jj\\\",\\\"score\\\":4,\\\"remark\\\":\\\"\\\",\\\"attachment\\\":\\\"/profile/upload/2025/10/24/2686_lg_66b05056b8_20251024103631A001.jpg\\\"}]\",\"moralScore\":4,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":1,\"status\":0,\"studentId\":\"admin\",\"studentName\":\"若依\",\"totalScore\":0.80}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 10:37:29', 23);
INSERT INTO `sys_oper_log` VALUES (224, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 10:37:35\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[{\\\"type\\\":\\\"custom\\\",\\\"name\\\":\\\"jj\\\",\\\"score\\\":4,\\\"remark\\\":\\\"\\\",\\\"attachment\\\":\\\"/profile/upload/2025/10/24/2686_lg_66b05056b8_20251024103631A001.jpg\\\"}]\",\"moralScore\":4,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":1,\"status\":1,\"studentId\":\"admin\",\"studentName\":\"若依\",\"submitTime\":\"2025-10-24 10:37:35\",\"totalScore\":0.80}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\n; Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'', '2025-10-24 10:37:35', 12);
INSERT INTO `sys_oper_log` VALUES (225, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 10:39:46\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[{\\\"type\\\":\\\"custom\\\",\\\"name\\\":\\\"jj\\\",\\\"score\\\":4,\\\"remark\\\":\\\"\\\",\\\"attachment\\\":\\\"/profile/upload/2025/10/24/2686_lg_66b05056b8_20251024103631A001.jpg\\\"}]\",\"moralScore\":4,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":1,\"status\":1,\"studentId\":\"admin\",\"studentName\":\"若依\",\"submitTime\":\"2025-10-24 10:39:46\",\"totalScore\":0.80}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 10:39:46', 16);
INSERT INTO `sys_oper_log` VALUES (226, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 11:54:03\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[]\",\"moralScore\":0,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":1,\"status\":1,\"studentId\":\"admin\",\"studentName\":\"若依\",\"submitTime\":\"2025-10-24 11:54:03\",\"totalScore\":0.00}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2025-2026-1\' for key \'t_semester_score_detail.uk_student_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2025-2026-1\' for key \'t_semester_score_detail.uk_student_semester\'\n; Duplicate entry \'admin-2025-2026-1\' for key \'t_semester_score_detail.uk_student_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2025-2026-1\' for key \'t_semester_score_detail.uk_student_semester\'', '2025-10-24 11:54:03', 28);
INSERT INTO `sys_oper_log` VALUES (227, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 11:54:11\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[]\",\"moralScore\":0,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":1,\"status\":1,\"studentId\":\"admin\",\"studentName\":\"若依\",\"submitTime\":\"2025-10-24 11:54:10\",\"totalScore\":0.00}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\evaluation\\TSemesterScoreDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TSemesterScoreDetailMapper.insertTSemesterScoreDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_semester_score_detail(       student_id, student_name, academic_year, semester,       intellectual_score, intellectual_rank, intellectual_details,       moral_score, moral_rank, moral_details,       physical_score, physical_rank, physical_details,       aesthetic_score, aesthetic_rank, aesthetic_details,       labor_score, labor_rank, labor_details,       total_score, class_rank, major_rank,       class_id, class_name, major_id, major_name,       status, submit_time, audit_time, auditor_id, audit_remark,       create_time, update_time     ) VALUES(       ?, ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?,       ?, ?, ?, ?,       ?, ?, ?, ?, ?,       ?, ?     )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'\n; Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'admin-2024-2025-1\' for key \'t_semester_score_detail.uk_student_semester\'', '2025-10-24 11:54:11', 32);
INSERT INTO `sys_oper_log` VALUES (228, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2024-2025\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"软件工程2402\",\"createTime\":\"2025-10-24 11:54:16\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[]\",\"moralScore\":0,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":2,\"status\":1,\"studentId\":\"admin\",\"studentName\":\"若依\",\"submitTime\":\"2025-10-24 11:54:16\",\"totalScore\":0.00}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 11:54:16', 14);
INSERT INTO `sys_oper_log` VALUES (229, '学期成绩明细', 1, 'com.ruoyi.web.controller.evaluation.TSemesterScoreDetailController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/semesterScore', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticDetails\":\"[]\",\"aestheticScore\":0,\"className\":\"2402\",\"createTime\":\"2025-10-24 17:52:41\",\"intellectualDetails\":\"[]\",\"intellectualScore\":0,\"laborDetails\":\"[]\",\"laborScore\":0,\"majorName\":\"\",\"moralDetails\":\"[{\\\"name\\\":\\\"蓝桥杯\\\",\\\"score\\\":3,\\\"remark\\\":\\\"lqb\\\",\\\"attachment\\\":\\\"\\\",\\\"type\\\":\\\"custom\\\"}]\",\"moralScore\":3,\"params\":{},\"physicalDetails\":\"[]\",\"physicalScore\":0,\"semester\":2,\"status\":0,\"studentId\":\"admin\",\"studentName\":\"若依\",\"totalScore\":0.60}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 17:52:41', 280);
INSERT INTO `sys_oper_log` VALUES (230, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"evaluation-submit/submission/SubmissionForm\",\"createTime\":\"2025-10-17 22:05:56\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2101,\"menuName\":\"我的填报\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2100,\"path\":\"submission\",\"perms\":\"evaluation:submission:list\",\"routeName\":\"Submission\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-24 21:03:51', 49);
INSERT INTO `sys_oper_log` VALUES (231, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"admin\",\"createTime\":\"2025-10-25 10:49:59\",\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'class_id\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into t_submission_main          ( academic_year,             semester,             class_id,                                                                                                                                                                         create_by,             create_time,                                       remark )           values ( ?,             ?,             ?,                                                                                                                                                                         ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'class_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'class_id\' in \'field list\'', '2025-10-25 10:49:59', 92);
INSERT INTO `sys_oper_log` VALUES (232, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"admin\",\"createTime\":\"2025-10-25 10:51:25\",\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'class_id\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into t_submission_main          ( academic_year,             semester,             class_id,                                                                                                                                                                         create_by,             create_time,                                       remark )           values ( ?,             ?,             ?,                                                                                                                                                                         ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'class_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'class_id\' in \'field list\'', '2025-10-25 10:51:25', 16);
INSERT INTO `sys_oper_log` VALUES (233, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"admin\",\"createTime\":\"2025-10-25 11:06:43\",\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'student_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission          ( academic_year,             semester,             class_id,                                                                                                                                                                         create_by,             create_time,                                       remark )           values ( ?,             ?,             ?,                                                                                                                                                                         ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLException: Field \'student_id\' doesn\'t have a default value\n; Field \'student_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'student_id\' doesn\'t have a default value', '2025-10-25 11:06:44', 134);
INSERT INTO `sys_oper_log` VALUES (234, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"admin\",\"createTime\":\"2025-10-25 11:12:42\",\"details\":[],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 11:12:42', 99);
INSERT INTO `sys_oper_log` VALUES (235, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"admin\",\"createTime\":\"2025-10-25 20:40:18\",\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission          ( student_id,             academic_year,             semester,             class_id,                                                                                                                                                                         create_by,             create_time,                                       remark )           values ( ?,             ?,             ?,             ?,                                                                                                                                                                         ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'\n; Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'', '2025-10-25 20:40:18', 113);
INSERT INTO `sys_oper_log` VALUES (236, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"admin\",\"createTime\":\"2025-10-25 20:43:07\",\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission          ( student_id,             academic_year,             semester,             class_id,                                                                                                                                                                         create_by,             create_time,                                       remark )           values ( ?,             ?,             ?,             ?,                                                                                                                                                                         ?,             ?,                                       ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'\n; Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1-2025-2026-1\' for key \'evaluation_submission.uk_student_year_semester\'', '2025-10-25 20:43:07', 8);
INSERT INTO `sys_oper_log` VALUES (237, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"userId\":1}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'self_evaluation\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.selectEvaluationSubmissionList-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select id, student_id, academic_year, semester, class_id, status, moral_score, intellectual_score, physical_score, aesthetic_score, labor_score, total_score, self_evaluation, submit_time, audit_time, audit_by, audit_comment, create_by, create_time, update_by, update_time, remark from evaluation_submission                WHERE  user_id = ?              and academic_year = ?              and semester = ?          order by create_time desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'self_evaluation\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'self_evaluation\' in \'field list\'', '2025-10-25 21:02:11', 69);
INSERT INTO `sys_oper_log` VALUES (238, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"userId\":1}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'self_evaluation\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.selectEvaluationSubmissionList-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select id, student_id, academic_year, semester, class_id, status, moral_score, intellectual_score, physical_score, aesthetic_score, labor_score, total_score, self_evaluation, submit_time, audit_time, audit_by, audit_comment, create_by, create_time, update_by, update_time, remark from evaluation_submission                WHERE  user_id = ?              and academic_year = ?              and semester = ?          order by create_time desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'self_evaluation\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'self_evaluation\' in \'field list\'', '2025-10-25 21:04:56', 116);
INSERT INTO `sys_oper_log` VALUES (239, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"userId\":1}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'audit_by\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.selectEvaluationSubmissionList-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select id, student_id, academic_year, semester, class_id, status, moral_score, intellectual_score, physical_score, aesthetic_score, labor_score, total_score, submit_time, audit_time, audit_by, audit_comment, create_by, create_time, update_by, update_time, remark from evaluation_submission                WHERE  user_id = ?              and academic_year = ?              and semester = ?          order by create_time desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'audit_by\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'audit_by\' in \'field list\'', '2025-10-25 21:07:27', 90);
INSERT INTO `sys_oper_log` VALUES (240, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"userId\":1}', NULL, 1, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_id\' in \'where clause\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.selectEvaluationSubmissionList-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select id, student_id, academic_year, semester, class_id, status, moral_score, intellectual_score, physical_score, aesthetic_score, labor_score, total_score, submit_time, audit_time, audit_by, audit_comment, create_by, create_time, update_by, update_time, remark from evaluation_submission                WHERE  user_id = ?              and academic_year = ?              and semester = ?          order by create_time desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'user_id\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'user_id\' in \'where clause\'', '2025-10-25 21:16:32', 68);
INSERT INTO `sys_oper_log` VALUES (241, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-25 21:20:05\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 21:20:05', 45);
INSERT INTO `sys_oper_log` VALUES (242, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-25 21:20:23\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 21:20:23', 19);
INSERT INTO `sys_oper_log` VALUES (243, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-25 21:20:32\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 21:20:32', 28);
INSERT INTO `sys_oper_log` VALUES (244, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":0,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-25 21:23:17\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-25 21:23:17', 45);
INSERT INTO `sys_oper_log` VALUES (245, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[],\"finalScore\":2,\"params\":{},\"remark\":\"\",\"ruleId\":4}],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-27 10:57:03\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-27 10:57:03', 118);
INSERT INTO `sys_oper_log` VALUES (246, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[],\"finalScore\":2,\"params\":{},\"remark\":\"\",\"ruleId\":4}],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-27 10:57:14\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-27 10:57:14', 22);
INSERT INTO `sys_oper_log` VALUES (247, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[{\"fileName\":\"P020240923636477667817 (3)_20251027110948A009.doc\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-27 11:09:59\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-27 11:09:59', 19);
INSERT INTO `sys_oper_log` VALUES (248, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"胡淇\",\"createTime\":\"2025-10-27 17:51:59\",\"details\":[{\"attachments\":[{\"fileName\":\"0a83ec3709135c1c5e08d8a7592ea50a_20251027175136A001.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"2686_lg_66b05056b8_20251027175153A002.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"userId\":100}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'moral_score\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission (             student_id,             academic_year,             semester,             class_id,             status,             moral_score,             intellectual_score,             physical_score,             aesthetic_score,             labor_score,             total_score,             submit_time,             audit_time,             audit_by,             audit_comment,             create_by,             create_time,             update_by,             update_time,             remark         ) values (                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?                  )         on duplicate key update                              class_id = values(class_id),                              status = values(status),                              moral_score = values(moral_score),                              intellectual_score = values(intellectual_score),                              physical_score = values(physical_score),                              aesthetic_score = values(aesthetic_score),                              labor_score = values(labor_score),                         ', '2025-10-27 17:52:00', 170);
INSERT INTO `sys_oper_log` VALUES (249, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"胡淇\",\"createTime\":\"2025-10-27 17:54:04\",\"details\":[{\"attachments\":[{\"fileName\":\"0a83ec3709135c1c5e08d8a7592ea50a_20251027175136A001.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"2686_lg_66b05056b8_20251027175153A002.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"userId\":100}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'moral_score\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission (             student_id,             academic_year,             semester,             class_id,             status,             moral_score,             intellectual_score,             physical_score,             aesthetic_score,             labor_score,             total_score,             submit_time,             audit_time,             audit_by,             audit_comment,             create_by,             create_time,             update_by,             update_time,             remark         ) values (                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?                  )         on duplicate key update                              class_id = values(class_id),                              status = values(status),                              moral_score = values(moral_score),                              intellectual_score = values(intellectual_score),                              physical_score = values(physical_score),                              aesthetic_score = values(aesthetic_score),                              labor_score = values(labor_score),                         ', '2025-10-27 17:54:04', 8);
INSERT INTO `sys_oper_log` VALUES (250, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"胡淇\",\"createTime\":\"2025-10-27 17:58:20\",\"details\":[{\"attachments\":[{\"fileName\":\"0a83ec3709135c1c5e08d8a7592ea50a_20251027175136A001.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"2686_lg_66b05056b8_20251027175153A002.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"userId\":100}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'update_time\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionMapper.insertEvaluationSubmission-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission (             student_id,             academic_year,             semester,             class_id,             status,             moral_score,             intellectual_score,             physical_score,             aesthetic_score,             labor_score,             total_score,             submit_time,             audit_time,             audit_by,             audit_comment,             create_by,             create_time,             update_by,             update_time,             remark         ) values (                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?,                      ?                  )         on duplicate key update                              class_id = values(class_id),                              status = values(status),                              moral_score = values(moral_score),                              intellectual_score = values(intellectual_score),                              physical_score = values(physical_score),                              aesthetic_score = values(aesthetic_score),                              labor_score = values(labor_score),                         ', '2025-10-27 17:58:20', 19);
INSERT INTO `sys_oper_log` VALUES (251, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"createBy\":\"胡淇\",\"createTime\":\"2025-10-27 17:58:34\",\"details\":[{\"attachments\":[{\"fileName\":\"0a83ec3709135c1c5e08d8a7592ea50a_20251027175136A001.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"2686_lg_66b05056b8_20251027175153A002.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"id\":5,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-27 17:58:34', 44);
INSERT INTO `sys_oper_log` VALUES (252, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[{\"fileName\":\"3085b1a6e2b422d5e4eb4709a5de30a_20251027180550A004.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"unnamed (22)_20251027180538A003.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"id\":5,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"updateBy\":\"胡淇\",\"updateTime\":\"2025-10-27 18:05:56\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-27 18:05:56', 49);
INSERT INTO `sys_oper_log` VALUES (253, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[{\"fileName\":\"eb1233fcf28758c9480e58f82a119635_20251027180851A006.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"unnamed (22)_20251027180538A003.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"default_20251027180822A005.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"id\":5,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"updateBy\":\"胡淇\",\"updateTime\":\"2025-10-27 18:08:54\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-27 18:08:54', 45);
INSERT INTO `sys_oper_log` VALUES (254, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[{\"fileName\":\"7a16f348527be5165bd93cb0967b376_20251028212005A001.jpg\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"default_20251028212020A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2}],\"id\":5,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"updateBy\":\"胡淇\",\"updateTime\":\"2025-10-28 21:20:47\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-28 21:20:47', 97);
INSERT INTO `sys_oper_log` VALUES (255, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[{\"fileName\":\"default_20251028212020A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":5,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"updateBy\":\"胡淇\",\"updateTime\":\"2025-10-28 21:22:03\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-28 21:22:03', 14);
INSERT INTO `sys_oper_log` VALUES (256, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, '胡淇', '班委部门', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":201,\"details\":[{\"attachments\":[{\"fileName\":\"default_20251028212020A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":5,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":100,\"updateBy\":\"胡淇\",\"updateTime\":\"2025-10-28 21:28:46\",\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-28 21:28:46', 18);
INSERT INTO `sys_oper_log` VALUES (257, '综测审核', 2, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.audit()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission/audit', '127.0.0.1', '内网IP', '{\"operation\":\"APPROVE\",\"remark\":\"\",\"submissionId\":5}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"submissionId\":5,\"auditorId\":1,\"newStatus\":2,\"oldStatus\":1,\"auditTime\":\"2025-10-28 21:49:32.415\",\"success\":true,\"remark\":\"\",\"operation\":\"APPROVE\",\"auditorName\":\"admin\"}}', 0, NULL, '2025-10-28 21:49:32', 73);
INSERT INTO `sys_oper_log` VALUES (258, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":202,\"details\":[{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (9)_20251029205202A001.png\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":2,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-10-29 20:52:07\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 20:52:07', 39);
INSERT INTO `sys_oper_log` VALUES (259, '综测审核', 2, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.audit()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission/audit', '127.0.0.1', '内网IP', '{\"operation\":\"APPROVE\",\"remark\":\"\",\"submissionId\":2}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"submissionId\":2,\"auditorId\":1,\"newStatus\":2,\"oldStatus\":1,\"auditTime\":\"2025-10-29 20:52:26.874\",\"success\":true,\"remark\":\"\",\"operation\":\"APPROVE\",\"auditorName\":\"admin\"}}', 0, NULL, '2025-10-29 20:52:26', 37);
INSERT INTO `sys_oper_log` VALUES (260, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":104,\"email\":\"hq760508@gmail.com\",\"nickName\":\"test\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[],\"roleIds\":[100,2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"test\"}', '{\"msg\":\"新增用户\'test\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-10-29 21:12:11', 21);
INSERT INTO `sys_oper_log` VALUES (261, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":104,\"email\":\"hq760508@gmail.com\",\"nickName\":\"test1\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[],\"roleIds\":[100,2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"test\"}', '{\"msg\":\"新增用户\'test\'失败，登录账号已存在\",\"code\":500}', 0, NULL, '2025-10-29 21:12:18', 5);
INSERT INTO `sys_oper_log` VALUES (262, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":104,\"email\":\"hq760508@gmail.com\",\"nickName\":\"test1\",\"params\":{},\"phonenumber\":\"13203094369\",\"postIds\":[],\"roleIds\":[100,2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"test1\"}', '{\"msg\":\"新增用户\'test1\'失败，手机号码已存在\",\"code\":500}', 0, NULL, '2025-10-29 21:12:22', 17);
INSERT INTO `sys_oper_log` VALUES (263, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":104,\"email\":\"hq760508@gmail.com\",\"nickName\":\"test1\",\"params\":{},\"phonenumber\":\"13203094368\",\"postIds\":[],\"roleIds\":[100,2],\"sex\":\"0\",\"status\":\"0\",\"userId\":103,\"userName\":\"test1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 21:12:29', 120);
INSERT INTO `sys_oper_log` VALUES (264, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '软件工程', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 21:12:50', 103);
INSERT INTO `sys_oper_log` VALUES (265, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":200,\"createBy\":\"test\",\"createTime\":\"2025-10-29 21:14:43\",\"details\":[{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (1)_20251029211351A001.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"222\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (9)_20251029211407A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (6)_20251029211420A003.png\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 21:14:43', 33);
INSERT INTO `sys_oper_log` VALUES (266, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (1)_20251029211351A001.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"222\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (9)_20251029211407A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (6)_20251029211420A003.png\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"params\":{},\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 21:15:26\",\"userId\":101}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 21:15:26', 18);
INSERT INTO `sys_oper_log` VALUES (267, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (1)_20251029211351A001.png\",\"params\":{}}],\"createTime\":\"2025-10-29 21:39:43\",\"finalScore\":6,\"params\":{},\"remark\":\"222\",\"ruleId\":2,\"submissionId\":6},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (9)_20251029211407A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (6)_20251029211420A003.png\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":16,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":16,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 21:39:43\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'apply_score\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission_detail (             submission_id,             rule_id,             rule_snapshot,             apply_score,             final_score,             status,             remark,             audit_time,             audit_by,             audit_comment,             create_by,             create_time,             update_by,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'apply_score\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'apply_score\' in \'field list\'', '2025-10-29 21:39:43', 179);
INSERT INTO `sys_oper_log` VALUES (268, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (1)_20251029211351A001.png\",\"params\":{}}],\"createTime\":\"2025-10-29 21:39:55\",\"finalScore\":6,\"params\":{},\"remark\":\"222\",\"ruleId\":2,\"submissionId\":6},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (9)_20251029211407A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (6)_20251029211420A003.png\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":16,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":16,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 21:39:55\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'apply_score\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission_detail (             submission_id,             rule_id,             rule_snapshot,             apply_score,             final_score,             status,             remark,             audit_time,             audit_by,             audit_comment,             create_by,             create_time,             update_by,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'apply_score\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'apply_score\' in \'field list\'', '2025-10-29 21:39:55', 67);
INSERT INTO `sys_oper_log` VALUES (269, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (1)_20251029211351A001.png\",\"params\":{}}],\"createTime\":\"2025-10-29 21:46:26\",\"finalScore\":6,\"params\":{},\"remark\":\"222\",\"ruleId\":2,\"submissionId\":6},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (9)_20251029211407A002.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"《金杖之梦》绘本创作 (6)_20251029211420A003.png\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":16,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":16,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 21:46:26\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'rule_snapshot\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission_detail (             submission_id,             rule_snapshot,             final_score,             status,             remark,             audit_time,             auditor_id,             audit_comment,             create_by,             create_time,             update_by,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'rule_snapshot\' cannot be null\n; Column \'rule_snapshot\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'rule_snapshot\' cannot be null', '2025-10-29 21:46:26', 96);
INSERT INTO `sys_oper_log` VALUES (270, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"default_20251028212020A002.png\",\"params\":{}}],\"createTime\":\"2025-10-29 21:52:46\",\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"submissionId\":6},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 21:52:46\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'status\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission_detail (             submission_id,             rule_snapshot,             final_score,             status,             remark,             audit_time,             auditor_id,             audit_comment,             create_by,             create_time,             update_by,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'status\' cannot be null\n; Column \'status\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'status\' cannot be null', '2025-10-29 21:52:47', 253);
INSERT INTO `sys_oper_log` VALUES (271, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"default_20251028212020A002.png\",\"params\":{}}],\"createTime\":\"2025-10-29 21:56:19\",\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 21:56:19\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'update_time\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission_detail (             submission_id,             rule_snapshot,             final_score,             status,             remark,             audit_time,             auditor_id,             audit_comment,             create_by,             create_time,             update_by,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'update_time\' cannot be null\n; Column \'update_time\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'update_time\' cannot be null', '2025-10-29 21:56:19', 201);
INSERT INTO `sys_oper_log` VALUES (272, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"fileName\":\"default_20251028212020A002.png\",\"params\":{}}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:00:51\",\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:00:51\"},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:00:51\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'rule_id\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationSubmissionDetailMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationSubmissionDetailMapper.insertEvaluationSubmissionDetail-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_submission_detail (             submission_id,             rule_snapshot,             final_score,             status,             remark,             audit_time,             auditor_id,             audit_comment,             create_by,             create_time,             update_by,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLException: Field \'rule_id\' doesn\'t have a default value\n; Field \'rule_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'rule_id\' doesn\'t have a default value', '2025-10-29 22:00:51', 379);
INSERT INTO `sys_oper_log` VALUES (273, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"detailId\":2,\"fileName\":\"default_20251028212020A002.png\",\"params\":{},\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:06:15\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:06:15\",\"finalScore\":6,\"id\":2,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:06:15\"},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:06:15\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_time\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationAttachmentMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationAttachmentMapper.insertEvaluationAttachment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_attachment (             detail_id,             file_name,             original_name,             file_path,             file_size,             file_type,             upload_time,             upload_by,             create_time,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_time\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'create_time\' in \'field list\'', '2025-10-29 22:06:15', 187);
INSERT INTO `sys_oper_log` VALUES (274, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"detailId\":3,\"fileName\":\"default_20251028212020A002.png\",\"params\":{},\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:07:14\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:07:14\",\"finalScore\":6,\"id\":3,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:07:14\"},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:07:14\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'original_name\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationAttachmentMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationAttachmentMapper.insertEvaluationAttachment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_attachment (             detail_id,             file_name,             original_name,             file_path,             file_size,             file_type,             upload_time,             upload_by,             create_time,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'original_name\' cannot be null\n; Column \'original_name\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'original_name\' cannot be null', '2025-10-29 22:07:14', 31);
INSERT INTO `sys_oper_log` VALUES (275, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"createTime\":\"2025-10-29 22:11:02\",\"detailId\":4,\"fileName\":\"default_20251028212020A002.png\",\"filePath\":\"/default_20251028212020A002.png\",\"fileType\":\"PNG\",\"originalName\":\"default_20251028212020A002.png\",\"params\":{},\"updateTime\":\"2025-10-29 22:11:02\",\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:11:02\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:11:02\",\"finalScore\":6,\"id\":4,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:11:02\"},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:11:02\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'file_size\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationAttachmentMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationAttachmentMapper.insertEvaluationAttachment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_attachment (             detail_id,             file_name,             original_name,             file_path,             file_size,             file_type,             upload_time,             upload_by,             create_time,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'file_size\' cannot be null\n; Column \'file_size\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'file_size\' cannot be null', '2025-10-29 22:11:02', 178);
INSERT INTO `sys_oper_log` VALUES (276, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"createTime\":\"2025-10-29 22:13:53\",\"detailId\":5,\"fileName\":\"default_20251028212020A002.png\",\"filePath\":\"/default_20251028212020A002.png\",\"fileType\":\"PNG\",\"originalName\":\"default_20251028212020A002.png\",\"params\":{},\"updateTime\":\"2025-10-29 22:13:53\",\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:13:53\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:13:53\",\"finalScore\":6,\"id\":5,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:13:53\"},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:13:53\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'file_size\' cannot be null\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationAttachmentMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationAttachmentMapper.insertEvaluationAttachment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_attachment (             detail_id,             file_name,             original_name,             file_path,             file_size,             file_type,             upload_time,             upload_by,             create_time,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'file_size\' cannot be null\n; Column \'file_size\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'file_size\' cannot be null', '2025-10-29 22:13:53', 71);
INSERT INTO `sys_oper_log` VALUES (277, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"createTime\":\"2025-10-29 22:14:13\",\"detailId\":6,\"fileName\":\"default_20251028212020A002.png\",\"filePath\":\"/default_20251028212020A002.png\",\"fileSize\":0,\"fileType\":\"PNG\",\"originalName\":\"default_20251028212020A002.png\",\"params\":{},\"updateTime\":\"2025-10-29 22:14:13\",\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:14:13\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:14:13\",\"finalScore\":6,\"id\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:14:13\"},{\"attachments\":[{\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{}}],\"finalScore\":6,\"params\":{},\"remark\":\"\",\"ruleId\":2},{\"attachments\":[{\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3},{\"attachments\":[{\"fileName\":\"349c0cc60488b7de720deb5fe047c4d8_20251028212839A005.jpg\",\"params\":{}}],\"finalScore\":4,\"params\":{},\"remark\":\"\",\"ruleId\":3}],\"id\":6,\"intellectualScore\":20,\"laborScore\":0,\"moralScore\":0,\"params\":{},\"physicalScore\":0,\"remark\":\"\",\"semester\":1,\"status\":1,\"studentId\":101,\"totalScore\":20,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:14:13\",\"userId\":101}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'url\' doesn\'t have a default value\r\n### The error may exist in file [C:\\Users\\Ynchen\\Desktop\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\EvaluationAttachmentMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.EvaluationAttachmentMapper.insertEvaluationAttachment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into evaluation_attachment (             detail_id,             file_name,             original_name,             file_path,             file_size,             file_type,             upload_time,             upload_by,             create_time,             update_time         ) values (             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?,             ?         )\r\n### Cause: java.sql.SQLException: Field \'url\' doesn\'t have a default value\n; Field \'url\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'url\' doesn\'t have a default value', '2025-10-29 22:14:13', 206);
INSERT INTO `sys_oper_log` VALUES (278, '综测填报', 1, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.add()', 'POST', 1, 'test', '计算机与科学', '/evaluation/submission', '127.0.0.1', '内网IP', '{\"academicYear\":\"2025-2026\",\"aestheticScore\":0,\"classId\":200,\"details\":[{\"attachments\":[{\"createTime\":\"2025-10-29 22:18:36\",\"detailId\":7,\"fileName\":\"default_20251028212020A002.png\",\"filePath\":\"/default_20251028212020A002.png\",\"fileSize\":0,\"fileType\":\"PNG\",\"id\":2,\"originalName\":\"default_20251028212020A002.png\",\"params\":{},\"updateTime\":\"2025-10-29 22:18:36\",\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:18:36\",\"url\":\"/profile/upload/2025/10/28/default_20251028212020A002.png\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:18:35\",\"finalScore\":6,\"id\":7,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:18:35\"},{\"attachments\":[{\"createTime\":\"2025-10-29 22:18:36\",\"detailId\":8,\"fileName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"filePath\":\"/2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"fileSize\":0,\"fileType\":\"PNG\",\"id\":3,\"originalName\":\"2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\",\"params\":{},\"updateTime\":\"2025-10-29 22:18:36\",\"uploadBy\":101,\"uploadTime\":\"2025-10-29 22:18:36\",\"url\":\"/profile/upload/2025/10/28/2b80e307f45ff4ae8132e35909026b0_20251028212823A003.png\"}],\"createBy\":\"test\",\"createTime\":\"2025-10-29 22:18:36\",\"finalScore\":6,\"id\":8,\"params\":{},\"remark\":\"\",\"ruleId\":2,\"ruleSnapshot\":\"{\\\"id\\\":2,\\\"dimensionType\\\":1,\\\"itemCode\\\":\\\"ACADEMIC_COMPETITION\\\",\\\"itemName\\\":\\\"学科竞赛\\\",\\\"maxScore\\\":20.00,\\\"minScore\\\":0.00,\\\"defaultScore\\\":0.00,\\\"scoreType\\\":1,\\\"weight\\\":0.10}\",\"status\":0,\"submissionId\":6,\"updateBy\":\"test\",\"updateTime\":\"2025-10-29 22:18:36\"},{\"attachments\":[{\"createTime\":\"2025-10-29 22:18:36\",\"detailId\":9,\"fileName\":\"7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"filePath\":\"/7ea8978de4c4cb5a96c6a9f3c843dfd_20251028212831A004.jpg\",\"fileSize\":0,\"fileType\":\"JPG\",\"id\":4,\"or', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-10-29 22:18:36', 146);
INSERT INTO `sys_oper_log` VALUES (279, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2100,3,116,2101,2111,2112,2113,2114,2115,2116,2117,2102,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,1060],\"params\":{},\"remark\":\"学生角色 - 可提交材料和查看自己成绩\",\"roleId\":100,\"roleKey\":\"student\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-02 17:06:54', 41);
INSERT INTO `sys_oper_log` VALUES (280, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2100,2101,2111,2112,2113,2114,2115,2116,2117,2102,2120,2131,2132,2133,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"remark\":\"班委角色 - 可初审学生材料\",\"roleId\":101,\"roleKey\":\"monitor\",\"roleName\":\"班委\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-02 17:07:48', 23);
INSERT INTO `sys_oper_log` VALUES (281, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:44:52\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2100,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2055,2056,2057,2058,2059,2060,2061,2062,2063,2064,2065,2066,2120,2131,2132,2133,2121,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"remark\":\"辅导员角色 - 可审核学生材料和管理学院事务\",\"roleId\":102,\"roleKey\":\"counselor\",\"roleName\":\"辅导员\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-02 17:09:39', 42);
INSERT INTO `sys_oper_log` VALUES (282, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-09-22 08:19:54\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2006,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2055,2056,2057,2058,2059,2060,2061,2062,2063,2064,2065,2066,2100,2101,2111,2112,2113,2114,2115,2116,2117,2102,2120,2131,2132,2133,2121,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-02 17:10:15', 50);
INSERT INTO `sys_oper_log` VALUES (283, '综测审核', 2, 'com.ruoyi.web.controller.evaluation.EvaluationSubmissionController.audit()', 'POST', 1, 'admin', '软件工程', '/evaluation/submission/audit', '127.0.0.1', '内网IP', '{\"operation\":\"APPROVE\",\"remark\":\"\",\"submissionId\":6}', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"submissionId\":6,\"auditorId\":1,\"newStatus\":2,\"oldStatus\":1,\"auditTime\":\"2025-11-02 17:22:37.272\",\"success\":true,\"remark\":\"\",\"operation\":\"APPROVE\",\"auditorName\":\"admin\"}}', 0, NULL, '2025-11-02 17:22:37', 60);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-09-22 08:19:54', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-09-22 08:19:54', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-09-22 08:19:54', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-09-22 08:19:54', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:19:54', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-09-22 08:19:54', 'admin', '2025-11-02 17:10:15', '普通角色');
INSERT INTO `sys_role` VALUES (100, '学生', 'student', 3, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:44:52', 'admin', '2025-11-02 17:06:54', '学生角色 - 可提交材料和查看自己成绩');
INSERT INTO `sys_role` VALUES (101, '班委', 'monitor', 4, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:44:52', 'admin', '2025-11-02 17:07:48', '班委角色 - 可初审学生材料');
INSERT INTO `sys_role` VALUES (102, '辅导员', 'counselor', 5, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:44:52', 'admin', '2025-11-02 17:09:39', '辅导员角色 - 可审核学生材料和管理学院事务');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2019);
INSERT INTO `sys_role_menu` VALUES (2, 2020);
INSERT INTO `sys_role_menu` VALUES (2, 2021);
INSERT INTO `sys_role_menu` VALUES (2, 2022);
INSERT INTO `sys_role_menu` VALUES (2, 2023);
INSERT INTO `sys_role_menu` VALUES (2, 2024);
INSERT INTO `sys_role_menu` VALUES (2, 2025);
INSERT INTO `sys_role_menu` VALUES (2, 2026);
INSERT INTO `sys_role_menu` VALUES (2, 2027);
INSERT INTO `sys_role_menu` VALUES (2, 2028);
INSERT INTO `sys_role_menu` VALUES (2, 2029);
INSERT INTO `sys_role_menu` VALUES (2, 2030);
INSERT INTO `sys_role_menu` VALUES (2, 2037);
INSERT INTO `sys_role_menu` VALUES (2, 2038);
INSERT INTO `sys_role_menu` VALUES (2, 2039);
INSERT INTO `sys_role_menu` VALUES (2, 2040);
INSERT INTO `sys_role_menu` VALUES (2, 2041);
INSERT INTO `sys_role_menu` VALUES (2, 2042);
INSERT INTO `sys_role_menu` VALUES (2, 2043);
INSERT INTO `sys_role_menu` VALUES (2, 2044);
INSERT INTO `sys_role_menu` VALUES (2, 2045);
INSERT INTO `sys_role_menu` VALUES (2, 2046);
INSERT INTO `sys_role_menu` VALUES (2, 2047);
INSERT INTO `sys_role_menu` VALUES (2, 2048);
INSERT INTO `sys_role_menu` VALUES (2, 2049);
INSERT INTO `sys_role_menu` VALUES (2, 2050);
INSERT INTO `sys_role_menu` VALUES (2, 2051);
INSERT INTO `sys_role_menu` VALUES (2, 2052);
INSERT INTO `sys_role_menu` VALUES (2, 2053);
INSERT INTO `sys_role_menu` VALUES (2, 2054);
INSERT INTO `sys_role_menu` VALUES (2, 2055);
INSERT INTO `sys_role_menu` VALUES (2, 2056);
INSERT INTO `sys_role_menu` VALUES (2, 2057);
INSERT INTO `sys_role_menu` VALUES (2, 2058);
INSERT INTO `sys_role_menu` VALUES (2, 2059);
INSERT INTO `sys_role_menu` VALUES (2, 2060);
INSERT INTO `sys_role_menu` VALUES (2, 2061);
INSERT INTO `sys_role_menu` VALUES (2, 2062);
INSERT INTO `sys_role_menu` VALUES (2, 2063);
INSERT INTO `sys_role_menu` VALUES (2, 2064);
INSERT INTO `sys_role_menu` VALUES (2, 2065);
INSERT INTO `sys_role_menu` VALUES (2, 2066);
INSERT INTO `sys_role_menu` VALUES (2, 2100);
INSERT INTO `sys_role_menu` VALUES (2, 2101);
INSERT INTO `sys_role_menu` VALUES (2, 2102);
INSERT INTO `sys_role_menu` VALUES (2, 2111);
INSERT INTO `sys_role_menu` VALUES (2, 2112);
INSERT INTO `sys_role_menu` VALUES (2, 2113);
INSERT INTO `sys_role_menu` VALUES (2, 2114);
INSERT INTO `sys_role_menu` VALUES (2, 2115);
INSERT INTO `sys_role_menu` VALUES (2, 2116);
INSERT INTO `sys_role_menu` VALUES (2, 2117);
INSERT INTO `sys_role_menu` VALUES (2, 2120);
INSERT INTO `sys_role_menu` VALUES (2, 2121);
INSERT INTO `sys_role_menu` VALUES (2, 2131);
INSERT INTO `sys_role_menu` VALUES (2, 2132);
INSERT INTO `sys_role_menu` VALUES (2, 2133);
INSERT INTO `sys_role_menu` VALUES (100, 2);
INSERT INTO `sys_role_menu` VALUES (100, 3);
INSERT INTO `sys_role_menu` VALUES (100, 109);
INSERT INTO `sys_role_menu` VALUES (100, 110);
INSERT INTO `sys_role_menu` VALUES (100, 111);
INSERT INTO `sys_role_menu` VALUES (100, 112);
INSERT INTO `sys_role_menu` VALUES (100, 113);
INSERT INTO `sys_role_menu` VALUES (100, 114);
INSERT INTO `sys_role_menu` VALUES (100, 116);
INSERT INTO `sys_role_menu` VALUES (100, 1046);
INSERT INTO `sys_role_menu` VALUES (100, 1047);
INSERT INTO `sys_role_menu` VALUES (100, 1048);
INSERT INTO `sys_role_menu` VALUES (100, 1049);
INSERT INTO `sys_role_menu` VALUES (100, 1050);
INSERT INTO `sys_role_menu` VALUES (100, 1051);
INSERT INTO `sys_role_menu` VALUES (100, 1052);
INSERT INTO `sys_role_menu` VALUES (100, 1053);
INSERT INTO `sys_role_menu` VALUES (100, 1054);
INSERT INTO `sys_role_menu` VALUES (100, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2100);
INSERT INTO `sys_role_menu` VALUES (100, 2101);
INSERT INTO `sys_role_menu` VALUES (100, 2102);
INSERT INTO `sys_role_menu` VALUES (100, 2111);
INSERT INTO `sys_role_menu` VALUES (100, 2112);
INSERT INTO `sys_role_menu` VALUES (100, 2113);
INSERT INTO `sys_role_menu` VALUES (100, 2114);
INSERT INTO `sys_role_menu` VALUES (100, 2115);
INSERT INTO `sys_role_menu` VALUES (100, 2116);
INSERT INTO `sys_role_menu` VALUES (100, 2117);
INSERT INTO `sys_role_menu` VALUES (101, 2);
INSERT INTO `sys_role_menu` VALUES (101, 109);
INSERT INTO `sys_role_menu` VALUES (101, 110);
INSERT INTO `sys_role_menu` VALUES (101, 111);
INSERT INTO `sys_role_menu` VALUES (101, 112);
INSERT INTO `sys_role_menu` VALUES (101, 113);
INSERT INTO `sys_role_menu` VALUES (101, 114);
INSERT INTO `sys_role_menu` VALUES (101, 1046);
INSERT INTO `sys_role_menu` VALUES (101, 1047);
INSERT INTO `sys_role_menu` VALUES (101, 1048);
INSERT INTO `sys_role_menu` VALUES (101, 1049);
INSERT INTO `sys_role_menu` VALUES (101, 1050);
INSERT INTO `sys_role_menu` VALUES (101, 1051);
INSERT INTO `sys_role_menu` VALUES (101, 1052);
INSERT INTO `sys_role_menu` VALUES (101, 1053);
INSERT INTO `sys_role_menu` VALUES (101, 1054);
INSERT INTO `sys_role_menu` VALUES (101, 2006);
INSERT INTO `sys_role_menu` VALUES (101, 2100);
INSERT INTO `sys_role_menu` VALUES (101, 2101);
INSERT INTO `sys_role_menu` VALUES (101, 2102);
INSERT INTO `sys_role_menu` VALUES (101, 2111);
INSERT INTO `sys_role_menu` VALUES (101, 2112);
INSERT INTO `sys_role_menu` VALUES (101, 2113);
INSERT INTO `sys_role_menu` VALUES (101, 2114);
INSERT INTO `sys_role_menu` VALUES (101, 2115);
INSERT INTO `sys_role_menu` VALUES (101, 2116);
INSERT INTO `sys_role_menu` VALUES (101, 2117);
INSERT INTO `sys_role_menu` VALUES (101, 2120);
INSERT INTO `sys_role_menu` VALUES (101, 2131);
INSERT INTO `sys_role_menu` VALUES (101, 2132);
INSERT INTO `sys_role_menu` VALUES (101, 2133);
INSERT INTO `sys_role_menu` VALUES (102, 2);
INSERT INTO `sys_role_menu` VALUES (102, 109);
INSERT INTO `sys_role_menu` VALUES (102, 110);
INSERT INTO `sys_role_menu` VALUES (102, 111);
INSERT INTO `sys_role_menu` VALUES (102, 112);
INSERT INTO `sys_role_menu` VALUES (102, 113);
INSERT INTO `sys_role_menu` VALUES (102, 114);
INSERT INTO `sys_role_menu` VALUES (102, 1046);
INSERT INTO `sys_role_menu` VALUES (102, 1047);
INSERT INTO `sys_role_menu` VALUES (102, 1048);
INSERT INTO `sys_role_menu` VALUES (102, 1049);
INSERT INTO `sys_role_menu` VALUES (102, 1050);
INSERT INTO `sys_role_menu` VALUES (102, 1051);
INSERT INTO `sys_role_menu` VALUES (102, 1052);
INSERT INTO `sys_role_menu` VALUES (102, 1053);
INSERT INTO `sys_role_menu` VALUES (102, 1054);
INSERT INTO `sys_role_menu` VALUES (102, 2006);
INSERT INTO `sys_role_menu` VALUES (102, 2019);
INSERT INTO `sys_role_menu` VALUES (102, 2020);
INSERT INTO `sys_role_menu` VALUES (102, 2021);
INSERT INTO `sys_role_menu` VALUES (102, 2022);
INSERT INTO `sys_role_menu` VALUES (102, 2023);
INSERT INTO `sys_role_menu` VALUES (102, 2024);
INSERT INTO `sys_role_menu` VALUES (102, 2025);
INSERT INTO `sys_role_menu` VALUES (102, 2026);
INSERT INTO `sys_role_menu` VALUES (102, 2027);
INSERT INTO `sys_role_menu` VALUES (102, 2028);
INSERT INTO `sys_role_menu` VALUES (102, 2029);
INSERT INTO `sys_role_menu` VALUES (102, 2030);
INSERT INTO `sys_role_menu` VALUES (102, 2037);
INSERT INTO `sys_role_menu` VALUES (102, 2038);
INSERT INTO `sys_role_menu` VALUES (102, 2039);
INSERT INTO `sys_role_menu` VALUES (102, 2040);
INSERT INTO `sys_role_menu` VALUES (102, 2041);
INSERT INTO `sys_role_menu` VALUES (102, 2042);
INSERT INTO `sys_role_menu` VALUES (102, 2043);
INSERT INTO `sys_role_menu` VALUES (102, 2044);
INSERT INTO `sys_role_menu` VALUES (102, 2045);
INSERT INTO `sys_role_menu` VALUES (102, 2046);
INSERT INTO `sys_role_menu` VALUES (102, 2047);
INSERT INTO `sys_role_menu` VALUES (102, 2048);
INSERT INTO `sys_role_menu` VALUES (102, 2049);
INSERT INTO `sys_role_menu` VALUES (102, 2050);
INSERT INTO `sys_role_menu` VALUES (102, 2051);
INSERT INTO `sys_role_menu` VALUES (102, 2052);
INSERT INTO `sys_role_menu` VALUES (102, 2053);
INSERT INTO `sys_role_menu` VALUES (102, 2054);
INSERT INTO `sys_role_menu` VALUES (102, 2055);
INSERT INTO `sys_role_menu` VALUES (102, 2056);
INSERT INTO `sys_role_menu` VALUES (102, 2057);
INSERT INTO `sys_role_menu` VALUES (102, 2058);
INSERT INTO `sys_role_menu` VALUES (102, 2059);
INSERT INTO `sys_role_menu` VALUES (102, 2060);
INSERT INTO `sys_role_menu` VALUES (102, 2061);
INSERT INTO `sys_role_menu` VALUES (102, 2062);
INSERT INTO `sys_role_menu` VALUES (102, 2063);
INSERT INTO `sys_role_menu` VALUES (102, 2064);
INSERT INTO `sys_role_menu` VALUES (102, 2065);
INSERT INTO `sys_role_menu` VALUES (102, 2066);
INSERT INTO `sys_role_menu` VALUES (102, 2100);
INSERT INTO `sys_role_menu` VALUES (102, 2120);
INSERT INTO `sys_role_menu` VALUES (102, 2121);
INSERT INTO `sys_role_menu` VALUES (102, 2131);
INSERT INTO `sys_role_menu` VALUES (102, 2132);
INSERT INTO `sys_role_menu` VALUES (102, 2133);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-02 17:05:30', '2025-09-22 08:19:54', 'admin', '2025-09-22 08:19:54', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-09-22 08:19:54', '2025-09-22 08:19:54', 'admin', '2025-09-22 08:19:54', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 202, '胡淇', 'Ynchen', '00', '1911779729@qq.com', '13203094369', '0', '/profile/avatar/2025/10/22/759d6d17fade46d18deb67f53d93668f.jpg', '$2a$10$DhOaE/JwCT6QQ8NuetVWUOamb0UV8QJaBUARDpQ3u8BBpb3NWD84m', '0', '0', '127.0.0.1', '2025-10-29 20:52:49', '2025-09-24 12:42:18', 'admin', '2025-09-24 09:22:50', 'admin', '2025-10-22 21:30:58', NULL);
INSERT INTO `sys_user` VALUES (101, 104, 'test', 'test', '00', '2364598338@qq.com', '17589733957', '0', '', '$2a$10$UBcpldrNlOK9PPdgDEPanu8UjCtUx86qW5a8vWNQ220482J4r/79C', '0', '0', '127.0.0.1', '2025-10-29 21:13:24', '2025-10-29 21:12:50', 'admin', '2025-09-24 12:41:06', 'admin', '2025-10-29 21:12:50', NULL);
INSERT INTO `sys_user` VALUES (102, 201, '高瑾', '高瑾', '00', 'gaojin@qq.com', '13203094366', '1', '', '$2a$10$Gfr/mRSwyQNcu//3Qg5/2.dY7AVvLGod8fVqFf3OGHkIv/uvTbyyW', '0', '0', '', NULL, NULL, 'admin', '2025-10-22 19:50:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (103, 104, 'test1', 'test1', '00', 'hq760508@gmail.com', '13203094368', '0', '', '$2a$10$.j7zCYkG5sHhReNS343KVepWjznjHdUeeVk6/5AEI84np/nr3Gtdy', '0', '0', '127.0.0.1', '2025-11-02 16:29:35', NULL, 'admin', '2025-10-29 21:12:29', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (100, 4);
INSERT INTO `sys_user_post` VALUES (101, 4);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 100);
INSERT INTO `sys_user_role` VALUES (100, 101);
INSERT INTO `sys_user_role` VALUES (101, 100);
INSERT INTO `sys_user_role` VALUES (102, 102);
INSERT INTO `sys_user_role` VALUES (103, 2);
INSERT INTO `sys_user_role` VALUES (103, 100);

-- ----------------------------
-- Table structure for t_appeal
-- ----------------------------
DROP TABLE IF EXISTS `t_appeal`;
CREATE TABLE `t_appeal`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '申诉ID',
  `record_id` bigint NOT NULL COMMENT '关联加分记录ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `appeal_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申诉理由',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-待处理，1-已同意，2-已拒绝',
  `process_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理结果',
  `process_by` bigint NULL DEFAULT NULL COMMENT '处理人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `process_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_record_id`(`record_id` ASC) USING BTREE,
  INDEX `idx_student_id`(`student_id` ASC) USING BTREE,
  INDEX `idx_process_by`(`process_by` ASC) USING BTREE,
  CONSTRAINT `fk_appeal_processor` FOREIGN KEY (`process_by`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_appeal_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_appeal_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '申诉表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_appeal
-- ----------------------------
INSERT INTO `t_appeal` VALUES (4, 1, 100, '蓝桥杯没加分', 0, '通过', 1, '2025-09-27 20:24:23', '2025-09-23 00:00:00');

-- ----------------------------
-- Table structure for t_audit_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_audit_flow`;
CREATE TABLE `t_audit_flow`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `record_id` bigint NOT NULL COMMENT '关联加分记录ID',
  `auditor_id` bigint NOT NULL COMMENT '审核人ID',
  `audit_opinion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核意见',
  `audit_status` tinyint NOT NULL COMMENT '审核状态：1-通过，2-拒绝',
  `audit_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_record_id`(`record_id` ASC) USING BTREE,
  INDEX `idx_auditor_id`(`auditor_id` ASC) USING BTREE,
  CONSTRAINT `fk_audit_flow_auditor` FOREIGN KEY (`auditor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_audit_flow_record` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审核流程记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_audit_flow
-- ----------------------------

-- ----------------------------
-- Table structure for t_class_score_statistics
-- ----------------------------
DROP TABLE IF EXISTS `t_class_score_statistics`;
CREATE TABLE `t_class_score_statistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `class_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班级ID',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班级名称',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学年',
  `semester` tinyint NOT NULL COMMENT '学期',
  `total_students` int NULL DEFAULT 0 COMMENT '总学生数',
  `submitted_students` int NULL DEFAULT 0 COMMENT '已提交学生数',
  `audited_students` int NULL DEFAULT 0 COMMENT '已审核学生数',
  `avg_total_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均总成绩',
  `max_total_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '最高总成绩',
  `min_total_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '最低总成绩',
  `avg_intellectual_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均智育成绩',
  `avg_moral_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均德育成绩',
  `avg_physical_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均体育成绩',
  `avg_aesthetic_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均美育成绩',
  `avg_labor_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均劳育成绩',
  `statistics_time` datetime NULL DEFAULT NULL COMMENT '统计时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_class_semester`(`class_id` ASC, `academic_year` ASC, `semester` ASC) USING BTREE COMMENT '班级学期唯一索引',
  INDEX `idx_statistics_time`(`statistics_time` ASC) USING BTREE COMMENT '统计时间索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '班级综测统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_class_score_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for t_college_info
-- ----------------------------
DROP TABLE IF EXISTS `t_college_info`;
CREATE TABLE `t_college_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '学院ID',
  `college_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院名称',
  `college_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院代码',
  `director_id` bigint NULL DEFAULT NULL COMMENT '负责人ID（关联sys_user）',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_college_code`(`college_code` ASC) USING BTREE,
  INDEX `idx_director`(`director_id` ASC) USING BTREE,
  CONSTRAINT `fk_college_director` FOREIGN KEY (`director_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学院信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_college_info
-- ----------------------------
INSERT INTO `t_college_info` VALUES (1, '信息工程学院', 'CS', NULL, 1, '2025-09-22 08:44:52', '2025-09-27 19:46:30');
INSERT INTO `t_college_info` VALUES (2, '电子工程学院', 'EE', NULL, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_college_info` VALUES (3, '数学学院', 'MATH', NULL, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_college_info` VALUES (4, '机械与材料工程学院', 'JC', NULL, 1, '2025-09-27 20:45:38', '2025-09-27 20:45:37');

-- ----------------------------
-- Table structure for t_evaluation_item
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_item`;
CREATE TABLE `t_evaluation_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `system_id` bigint NOT NULL COMMENT '关联测评体系ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父级项目ID，用于层级结构',
  `item_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `weight` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '权重',
  `score_rule` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评分规则描述',
  `item_type` tinyint NULL DEFAULT 1 COMMENT '项目类型：0-模块，1-具体项目',
  `max_score` int NULL DEFAULT 100 COMMENT '满分值',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_id`(`system_id` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `fk_evaluation_item_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_item
-- ----------------------------
INSERT INTO `t_evaluation_item` VALUES (1, 1, 0, '思想品德', 0.20, '思想品德评分规则', 0, 100, 1, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (2, 1, 1, '政治表现', 0.50, '政治表现评分细则', 1, 50, 1, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (3, 1, 1, '道德修养', 0.50, '道德修养评分细则', 1, 50, 2, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (4, 1, 0, '学习成绩', 0.60, '学习成绩评分规则', 0, 100, 2, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (5, 1, 4, '专业课成绩', 0.80, '专业课成绩评分细则', 1, 80, 1, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (6, 1, 4, '公共课成绩', 0.20, '公共课成绩评分细则', 1, 20, 2, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (7, 1, 0, '社会实践', 0.15, '社会实践评分规则', 0, 100, 3, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (8, 1, 7, '志愿服务', 0.60, '志愿服务评分细则', 1, 60, 1, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (9, 1, 7, '社会调研', 0.40, '社会调研评分细则', 1, 40, 2, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_item` VALUES (10, 1, 0, '创新创业', 0.05, '创新创业评分规则', 0, 100, 4, 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');

-- ----------------------------
-- Table structure for t_evaluation_item_config
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_item_config`;
CREATE TABLE `t_evaluation_item_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `dimension_type` tinyint NOT NULL COMMENT '维度类型（1智育，2德育，3体育，4美育，5劳育）',
  `item_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编码',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目名称',
  `item_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目描述',
  `max_score` decimal(5, 2) NOT NULL COMMENT '最高分值',
  `min_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '最低分值',
  `default_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '默认分值',
  `score_type` tinyint NULL DEFAULT 1 COMMENT '评分类型（1数值型，2等级型，3布尔型）',
  `score_options` json NULL COMMENT '评分选项（等级型时使用）',
  `weight` decimal(3, 2) NULL DEFAULT 1.00 COMMENT '权重系数',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序序号',
  `is_required` tinyint NULL DEFAULT 1 COMMENT '是否必填（0否，1是）',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否启用（0否，1是）',
  `applicable_grades` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '适用年级（JSON数组）',
  `applicable_majors` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '适用专业（JSON数组）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_dimension_code`(`dimension_type` ASC, `item_code` ASC) USING BTREE COMMENT '维度项目编码唯一索引',
  INDEX `idx_dimension_active`(`dimension_type` ASC, `is_active` ASC) USING BTREE COMMENT '维度启用状态索引',
  INDEX `idx_sort_order`(`sort_order` ASC) USING BTREE COMMENT '排序索引'
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '综测评分项目配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_item_config
-- ----------------------------
INSERT INTO `t_evaluation_item_config` VALUES (1, 1, 'COURSE_SCORE', '课程成绩', '各科目课程成绩的加权平均', 100.00, 0.00, 0.00, 1, NULL, 0.80, 1, 1, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (2, 1, 'ACADEMIC_COMPETITION', '学科竞赛', '参加学科竞赛获得的加分', 20.00, 0.00, 0.00, 1, NULL, 0.10, 2, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (3, 1, 'RESEARCH_PROJECT', '科研项目', '参与科研项目获得的加分', 15.00, 0.00, 0.00, 1, NULL, 0.10, 3, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (4, 2, 'MORAL_CONDUCT', '思想品德', '日常思想品德表现评分', 100.00, 0.00, 0.00, 1, NULL, 0.60, 1, 1, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (5, 2, 'VOLUNTEER_SERVICE', '志愿服务', '参与志愿服务活动获得的加分', 20.00, 0.00, 0.00, 1, NULL, 0.20, 2, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (6, 2, 'SOCIAL_ACTIVITY', '社会实践', '参与社会实践活动获得的加分', 20.00, 0.00, 0.00, 1, NULL, 0.20, 3, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (7, 3, 'PHYSICAL_TEST', '体能测试', '国家学生体质健康标准测试成绩', 100.00, 0.00, 0.00, 1, NULL, 0.70, 1, 1, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (8, 3, 'SPORTS_COMPETITION', '体育竞赛', '参加体育竞赛获得的加分', 30.00, 0.00, 0.00, 1, NULL, 0.20, 2, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (9, 3, 'SPORTS_ACTIVITY', '体育活动', '参与体育活动获得的加分', 10.00, 0.00, 0.00, 1, NULL, 0.10, 3, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (10, 4, 'ART_COURSE', '艺术课程', '艺术类课程成绩', 100.00, 0.00, 0.00, 1, NULL, 0.60, 1, 1, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (11, 4, 'ART_COMPETITION', '艺术竞赛', '参加艺术竞赛获得的加分', 25.00, 0.00, 0.00, 1, NULL, 0.25, 2, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (12, 4, 'CULTURAL_ACTIVITY', '文化活动', '参与文化艺术活动获得的加分', 15.00, 0.00, 0.00, 1, NULL, 0.15, 3, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (13, 5, 'LABOR_PRACTICE', '劳动实践', '劳动实践课程和活动评分', 100.00, 0.00, 0.00, 1, NULL, 0.70, 1, 1, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (14, 5, 'SKILL_TRAINING', '技能培训', '参与技能培训获得的加分', 20.00, 0.00, 0.00, 1, NULL, 0.20, 2, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);
INSERT INTO `t_evaluation_item_config` VALUES (15, 5, 'INNOVATION_PROJECT', '创新创业', '参与创新创业项目获得的加分', 10.00, 0.00, 0.00, 1, NULL, 0.10, 3, 0, 1, NULL, NULL, '', '2025-10-23 15:15:00', '', '2025-10-23 15:15:00', NULL);

-- ----------------------------
-- Table structure for t_evaluation_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_rule`;
CREATE TABLE `t_evaluation_rule`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `college_id` bigint NOT NULL COMMENT '学院ID',
  `rule_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则名称',
  `indicators` json NOT NULL COMMENT '考评指标集合',
  `semester` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '生效学期（如2025-2026-1）',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_college_semester`(`college_id` ASC, `semester` ASC) USING BTREE,
  CONSTRAINT `fk_evaluation_rule_college` FOREIGN KEY (`college_id`) REFERENCES `t_college_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评规则配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_rule
-- ----------------------------
INSERT INTO `t_evaluation_rule` VALUES (1, 1, '计算机学院2024-2025-1学期评价规则', '[{\"name\": \"学业成绩\", \"weight\": 55}, {\"name\": \"社会实践\", \"weight\": 20}, {\"name\": \"科技创新\", \"weight\": 15}, {\"name\": \"文体活动\", \"weight\": 10}]', '2024-2025-1', 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_rule` VALUES (2, 2, '电子工程学院2024-2025-1学期评价规则', '[{\"name\": \"学业成绩\", \"weight\": 60}, {\"name\": \"实验技能\", \"weight\": 25}, {\"name\": \"创新项目\", \"weight\": 15}]', '2024-2025-1', 1, '2025-09-22 08:44:52', '2025-09-22 08:44:52');

-- ----------------------------
-- Table structure for t_evaluation_system
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_system`;
CREATE TABLE `t_evaluation_system`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '测评体系ID',
  `system_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '测评体系名称',
  `academic_year` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学年，如2023-2024',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测评体系描述',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-未启用，1-已启用，2-已结束',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `creator_id` bigint NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_academic_year`(`academic_year` ASC) USING BTREE,
  INDEX `idx_semester`(`semester` ASC) USING BTREE,
  INDEX `idx_creator`(`creator_id` ASC) USING BTREE,
  CONSTRAINT `fk_evaluation_system_creator` FOREIGN KEY (`creator_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测评体系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_system
-- ----------------------------
INSERT INTO `t_evaluation_system` VALUES (1, '2024-2025学年第一学期综合测评', '2024-2025', 1, '2024-2025学年第一学期学生综合素质测评体系', 1, '2024-09-01 00:00:00', '2025-01-31 23:59:59', NULL, '2025-09-22 08:44:52', '2025-09-22 08:44:52');
INSERT INTO `t_evaluation_system` VALUES (2, '2024-2025学年第二学期综合测评', '2024-2025', 2, '2024-2025学年第二学期学生综合素质测评体系', 0, '2025-02-01 00:00:00', '2025-07-31 23:59:59', NULL, '2025-09-22 08:44:52', '2025-09-22 08:44:52');

-- ----------------------------
-- Table structure for t_score_record
-- ----------------------------
DROP TABLE IF EXISTS `t_score_record`;
CREATE TABLE `t_score_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID（关联sys_user）',
  `rule_id` bigint NOT NULL COMMENT '关联规则ID',
  `material_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '材料存储路径',
  `material_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '材料类型：PDF/JPG/PNG',
  `reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加分事由',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-待班委审核，1-待辅导员审核，2-已通过，3-已拒绝',
  `score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '最终加分值',
  `submit_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_rule_id`(`rule_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_submit_time`(`submit_time` ASC) USING BTREE,
  CONSTRAINT `fk_score_record_rule` FOREIGN KEY (`rule_id`) REFERENCES `t_evaluation_rule` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_score_record_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评加分记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_score_record
-- ----------------------------
INSERT INTO `t_score_record` VALUES (1, 100, 1, '999', 'PDF', '蓝桥杯', 0, 0.00, '2025-09-27 20:23:56', '2025-09-27 20:23:56');

-- ----------------------------
-- Table structure for t_score_trend_analysis
-- ----------------------------
DROP TABLE IF EXISTS `t_score_trend_analysis`;
CREATE TABLE `t_score_trend_analysis`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学号',
  `student_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `analysis_type` tinyint NOT NULL COMMENT '分析类型（1智育趋势，2德育趋势，3体育趋势，4美育趋势，5劳育趋势，6综合趋势）',
  `trend_data` json NULL COMMENT '趋势数据，格式：{\"semesters\":[\"2023-2024-1\",\"2023-2024-2\"],\"scores\":[85.5,87.2],\"ranks\":[15,12]}',
  `avg_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均成绩',
  `max_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '最高成绩',
  `min_score` decimal(5, 2) NULL DEFAULT NULL COMMENT '最低成绩',
  `trend_direction` tinyint NULL DEFAULT NULL COMMENT '趋势方向（1上升，0平稳，-1下降）',
  `improvement_rate` decimal(5, 2) NULL DEFAULT NULL COMMENT '提升幅度（百分比）',
  `class_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '班级ID',
  `major_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专业ID',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_type`(`student_id` ASC, `analysis_type` ASC) USING BTREE COMMENT '学生分析类型唯一索引',
  INDEX `idx_class_type`(`class_id` ASC, `analysis_type` ASC) USING BTREE COMMENT '班级分析类型索引',
  INDEX `idx_trend_direction`(`trend_direction` ASC) USING BTREE COMMENT '趋势方向索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成绩趋势分析表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_score_trend_analysis
-- ----------------------------

-- ----------------------------
-- Table structure for t_semester_score_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_semester_score_detail`;
CREATE TABLE `t_semester_score_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学号',
  `student_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学年（如2023-2024）',
  `semester` tinyint NOT NULL COMMENT '学期（1上学期，2下学期）',
  `intellectual_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '智育成绩',
  `intellectual_rank` int NULL DEFAULT 0 COMMENT '智育排名',
  `intellectual_details` json NULL COMMENT '智育详细项目得分（JSON格式）',
  `moral_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '德育成绩',
  `moral_rank` int NULL DEFAULT 0 COMMENT '德育排名',
  `moral_details` json NULL COMMENT '德育详细项目得分（JSON格式）',
  `physical_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '体育成绩',
  `physical_rank` int NULL DEFAULT 0 COMMENT '体育排名',
  `physical_details` json NULL COMMENT '体育详细项目得分（JSON格式）',
  `aesthetic_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '美育成绩',
  `aesthetic_rank` int NULL DEFAULT 0 COMMENT '美育排名',
  `aesthetic_details` json NULL COMMENT '美育详细项目得分（JSON格式）',
  `labor_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '劳育成绩',
  `labor_rank` int NULL DEFAULT 0 COMMENT '劳育排名',
  `labor_details` json NULL COMMENT '劳育详细项目得分（JSON格式）',
  `total_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '综合成绩',
  `class_rank` int NULL DEFAULT 0 COMMENT '班级排名',
  `major_rank` int NULL DEFAULT 0 COMMENT '专业排名',
  `class_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '班级ID',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '班级名称',
  `major_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专业ID',
  `major_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专业名称',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态（0草稿，1已提交，2已审核，3已发布）',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `auditor_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人ID',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_semester`(`student_id` ASC, `academic_year` ASC, `semester` ASC) USING BTREE COMMENT '学生学期唯一索引',
  INDEX `idx_class_semester`(`class_id` ASC, `academic_year` ASC, `semester` ASC) USING BTREE COMMENT '班级学期索引',
  INDEX `idx_major_semester`(`major_id` ASC, `academic_year` ASC, `semester` ASC) USING BTREE COMMENT '专业学期索引',
  INDEX `idx_status`(`status` ASC) USING BTREE COMMENT '状态索引',
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE COMMENT '创建时间索引'
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学期成绩明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_semester_score_detail
-- ----------------------------
INSERT INTO `t_semester_score_detail` VALUES (1, '1', '若依', '2024-2025', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-10-23 21:41:36', NULL, NULL, NULL, '', '2025-10-23 21:41:37', '', NULL, NULL);
INSERT INTO `t_semester_score_detail` VALUES (2, '胡淇', 'Ynchen', '2024-2025', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2025-10-23 22:01:17', NULL, NULL, NULL, '', '2025-10-23 22:01:18', '', NULL, NULL);
INSERT INTO `t_semester_score_detail` VALUES (5, 'admin', '若依', '2024-2025', 1, 0.00, NULL, '[]', 4.00, NULL, '[{\"name\": \"jj\", \"type\": \"custom\", \"score\": 4, \"remark\": \"\", \"attachment\": \"/profile/upload/2025/10/24/2686_lg_66b05056b8_20251024103631A001.jpg\"}]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.80, NULL, NULL, NULL, '软件工程2402', NULL, '', 0, NULL, NULL, NULL, NULL, '', '2025-10-24 10:37:30', '', NULL, NULL);
INSERT INTO `t_semester_score_detail` VALUES (7, 'admin', '若依', '2025-2026', 1, 0.00, NULL, '[]', 4.00, NULL, '[{\"name\": \"jj\", \"type\": \"custom\", \"score\": 4, \"remark\": \"\", \"attachment\": \"/profile/upload/2025/10/24/2686_lg_66b05056b8_20251024103631A001.jpg\"}]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.80, NULL, NULL, NULL, '软件工程2402', NULL, '', 1, '2025-10-24 10:39:46', NULL, NULL, NULL, '', '2025-10-24 10:39:47', '', NULL, NULL);
INSERT INTO `t_semester_score_detail` VALUES (10, 'admin', '若依', '2024-2025', 2, 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, NULL, NULL, '软件工程2402', NULL, '', 1, '2025-10-24 11:54:16', NULL, NULL, NULL, '', '2025-10-24 11:54:17', '', NULL, NULL);
INSERT INTO `t_semester_score_detail` VALUES (11, 'admin', '若依', '2025-2026', 2, 0.00, NULL, '[]', 3.00, NULL, '[{\"name\": \"蓝桥杯\", \"type\": \"custom\", \"score\": 3, \"remark\": \"lqb\", \"attachment\": \"\"}]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.00, NULL, '[]', 0.60, NULL, NULL, NULL, '2402', NULL, '', 0, NULL, NULL, NULL, NULL, '', '2025-10-24 17:52:41', '', NULL, NULL);

-- ----------------------------
-- Table structure for t_student_score_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_student_score_detail`;
CREATE TABLE `t_student_score_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '成绩明细ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `system_id` bigint NOT NULL COMMENT '测评体系ID',
  `item_id` bigint NOT NULL COMMENT '测评项目ID',
  `score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '得分',
  `evidence_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '证明材料URL',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '申请说明',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-待提交，1-待审核，2-已通过，3-已驳回',
  `audit_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审核意见',
  `auditor_id` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_student_system`(`student_id` ASC, `system_id` ASC) USING BTREE,
  INDEX `idx_item_id`(`item_id` ASC) USING BTREE,
  INDEX `idx_auditor_id`(`auditor_id` ASC) USING BTREE,
  INDEX `fk_score_detail_system`(`system_id` ASC) USING BTREE,
  CONSTRAINT `fk_score_detail_auditor` FOREIGN KEY (`auditor_id`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_score_detail_item` FOREIGN KEY (`item_id`) REFERENCES `t_evaluation_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_score_detail_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_score_detail_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生成绩明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_student_score_detail
-- ----------------------------

-- ----------------------------
-- Table structure for t_student_total_score
-- ----------------------------
DROP TABLE IF EXISTS `t_student_total_score`;
CREATE TABLE `t_student_total_score`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '总成绩ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `system_id` bigint NOT NULL COMMENT '测评体系ID',
  `total_score` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '总分',
  `moral_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '思想品德分',
  `study_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '学习成绩分',
  `practice_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '社会实践分',
  `innovation_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '创新创业分',
  `other_score` decimal(6, 2) NULL DEFAULT 0.00 COMMENT '其他加分',
  `ranking` int NULL DEFAULT NULL COMMENT '排名',
  `academic_year` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学年',
  `semester` tinyint NULL DEFAULT NULL COMMENT '学期',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-计算中，1-已完成，2-已公示',
  `calculate_time` datetime NULL DEFAULT NULL COMMENT '计算时间',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_system`(`student_id` ASC, `system_id` ASC) USING BTREE,
  INDEX `idx_system_id`(`system_id` ASC) USING BTREE,
  INDEX `idx_ranking`(`ranking` ASC) USING BTREE,
  CONSTRAINT `fk_total_score_student` FOREIGN KEY (`student_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_total_score_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生总成绩表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_student_total_score
-- ----------------------------

-- ----------------------------
-- Table structure for t_submission_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_submission_attachment`;
CREATE TABLE `t_submission_attachment`  (
  `attachment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件主键ID',
  `submission_item_id` bigint NOT NULL COMMENT '关联加分项ID',
  `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原始文件名',
  `object_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件在Minio中的对象名称/路径',
  `file_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件MIME类型',
  `file_size` bigint NOT NULL COMMENT '文件大小（字节）',
  `file_extension` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `upload_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'success' COMMENT '上传状态：success-成功，failed-失败',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '上传者账号',
  PRIMARY KEY (`attachment_id`) USING BTREE,
  INDEX `idx_attachment_item`(`submission_item_id` ASC) USING BTREE,
  CONSTRAINT `fk_attachment_item` FOREIGN KEY (`submission_item_id`) REFERENCES `t_submission_item` (`item_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '综测填报附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_submission_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for t_submission_item
-- ----------------------------
DROP TABLE IF EXISTS `t_submission_item`;
CREATE TABLE `t_submission_item`  (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '加分项主键ID',
  `submission_id` bigint NOT NULL COMMENT '关联填报主表ID',
  `evaluation_item_id` bigint NOT NULL COMMENT '评测项目ID',
  `item_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加分项名称',
  `item_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '加分项描述说明',
  `apply_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '申请分数',
  `actual_score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '实际得分（审核后）',
  `item_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '状态：draft-草稿，submitted-已提交，approved-已通过，rejected-已驳回',
  `audit_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审核意见',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_by` bigint NULL DEFAULT NULL COMMENT '审核人用户ID (关联 sys_user.user_id)',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者账号',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者账号',
  PRIMARY KEY (`item_id`) USING BTREE,
  INDEX `idx_item_submission`(`submission_id` ASC) USING BTREE,
  INDEX `idx_item_evaluation`(`evaluation_item_id` ASC) USING BTREE,
  INDEX `idx_item_status`(`item_status` ASC) USING BTREE,
  INDEX `fk_item_auditor`(`audit_by` ASC) USING BTREE,
  CONSTRAINT `fk_item_auditor` FOREIGN KEY (`audit_by`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_item_evaluation` FOREIGN KEY (`evaluation_item_id`) REFERENCES `t_evaluation_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_item_submission` FOREIGN KEY (`submission_id`) REFERENCES `t_submission_main` (`submission_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '综测填报加分项明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_submission_item
-- ----------------------------

-- ----------------------------
-- Table structure for t_submission_main
-- ----------------------------
DROP TABLE IF EXISTS `t_submission_main`;
CREATE TABLE `t_submission_main`  (
  `submission_id` bigint NOT NULL AUTO_INCREMENT COMMENT '填报主键ID',
  `user_id` bigint NOT NULL COMMENT '学生用户ID (关联 sys_user.user_id)',
  `evaluation_system_id` bigint NOT NULL COMMENT '评测系统ID',
  `academic_year` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学年，如2023-2024',
  `semester` tinyint NOT NULL COMMENT '学期，1表示第一学期，2表示第二学期',
  `submission_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'draft' COMMENT '填报状态：draft-草稿，submitted-已提交，approved-已通过，rejected-已驳回',
  `total_score` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '总分（系统计算）',
  `self_evaluation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '自我评价',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `audit_by` bigint NULL DEFAULT NULL COMMENT '审核人用户ID (关联 sys_user.user_id)',
  `audit_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '审核意见',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者账号',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者账号',
  PRIMARY KEY (`submission_id`) USING BTREE,
  UNIQUE INDEX `uk_user_system_year_semester`(`user_id` ASC, `academic_year` ASC, `semester` ASC) USING BTREE,
  INDEX `idx_submission_status`(`submission_status` ASC) USING BTREE,
  INDEX `fk_submission_system`(`evaluation_system_id` ASC) USING BTREE,
  INDEX `fk_submission_auditor`(`audit_by` ASC) USING BTREE,
  CONSTRAINT `fk_submission_auditor` FOREIGN KEY (`audit_by`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_submission_system` FOREIGN KEY (`evaluation_system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_submission_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '综测填报主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_submission_main
-- ----------------------------

-- ----------------------------
-- Table structure for t_user_profile
-- ----------------------------
DROP TABLE IF EXISTS `t_user_profile`;
CREATE TABLE `t_user_profile`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '档案ID',
  `user_id` bigint NOT NULL COMMENT '关联sys_user表的用户ID',
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学号',
  `college` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学院名称',
  `major` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业',
  `grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年级',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级名称',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别：0-男，1-女，2-未知',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `political_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `enrollment_date` date NULL DEFAULT NULL COMMENT '入学日期',
  `dormitory` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宿舍',
  `home_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `emergency_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系电话',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_id`(`student_id` ASC) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_profile_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户档案扩展表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_profile
-- ----------------------------
INSERT INTO `t_user_profile` VALUES (1, 100, '2507240211', '信息工程学院', '软件工程', '24级', '2402', 0, '2019-09-02', '群众', '2024-09-01', '615', '湖南', '父亲', '13203094369', 1, '2025-09-27 19:08:41', '2025-10-25 11:17:45');

-- ----------------------------
-- View structure for v_student_score_summary
-- ----------------------------
DROP VIEW IF EXISTS `v_student_score_summary`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_score_summary` AS select `ssd`.`student_id` AS `student_id`,`ssd`.`student_name` AS `student_name`,`ssd`.`class_id` AS `class_id`,`ssd`.`class_name` AS `class_name`,`ssd`.`major_id` AS `major_id`,`ssd`.`major_name` AS `major_name`,`ssd`.`academic_year` AS `academic_year`,`ssd`.`semester` AS `semester`,`ssd`.`intellectual_score` AS `intellectual_score`,`ssd`.`moral_score` AS `moral_score`,`ssd`.`physical_score` AS `physical_score`,`ssd`.`aesthetic_score` AS `aesthetic_score`,`ssd`.`labor_score` AS `labor_score`,`ssd`.`total_score` AS `total_score`,`ssd`.`class_rank` AS `class_rank`,`ssd`.`major_rank` AS `major_rank`,`ssd`.`status` AS `status`,`ssd`.`submit_time` AS `submit_time`,`ssd`.`audit_time` AS `audit_time`,round(((`ssd`.`class_rank` * 100.0) / `css`.`total_students`),2) AS `class_rank_percentile`,(case when (`ssd`.`class_rank` <= (`css`.`total_students` * 0.2)) then 1 else 0 end) AS `is_excellent` from (`t_semester_score_detail` `ssd` left join `t_class_score_statistics` `css` on(((`ssd`.`class_id` = `css`.`class_id`) and (`ssd`.`academic_year` = `css`.`academic_year`) and (`ssd`.`semester` = `css`.`semester`))));

-- ----------------------------
-- View structure for v_student_submission_stats
-- ----------------------------
DROP VIEW IF EXISTS `v_student_submission_stats`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_submission_stats` AS select `s`.`id` AS `id`,`s`.`student_id` AS `student_id`,`u`.`nick_name` AS `student_name`,`u`.`user_name` AS `student_code`,`s`.`academic_year` AS `academic_year`,`s`.`semester` AS `semester`,`s`.`class_id` AS `class_id`,`d`.`dept_name` AS `class_name`,`s`.`status` AS `status`,`s`.`total_score` AS `total_score`,`s`.`moral_score` AS `moral_score`,`s`.`intellectual_score` AS `intellectual_score`,`s`.`physical_score` AS `physical_score`,`s`.`aesthetic_score` AS `aesthetic_score`,`s`.`labor_score` AS `labor_score`,count(`sd`.`id`) AS `detail_count`,count((case when (`sd`.`status` = 1) then 1 end)) AS `approved_count`,count((case when (`sd`.`status` = 2) then 1 end)) AS `rejected_count`,`s`.`submit_time` AS `submit_time`,`s`.`audit_time` AS `audit_time`,`s`.`create_time` AS `create_time`,`s`.`update_time` AS `update_time` from (((`evaluation_submission` `s` left join `sys_user` `u` on((`s`.`student_id` = `u`.`user_id`))) left join `sys_dept` `d` on((`s`.`class_id` = `d`.`dept_id`))) left join `evaluation_submission_detail` `sd` on((`s`.`id` = `sd`.`submission_id`))) group by `s`.`id`;

-- ----------------------------
-- View structure for v_publicity_stats (公示统计视图)
-- ----------------------------
DROP VIEW IF EXISTS `v_publicity_stats`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_publicity_stats` AS
SELECT
    p.id,
    p.academic_year,
    p.semester,
    p.title,
    p.start_time,
    p.end_time,
    p.status,
    p.total_count,
    p.view_count,
    COUNT(DISTINCT pd.student_id) AS actual_student_count,
    AVG(pd.total_score) AS avg_total_score,
    MAX(pd.total_score) AS max_total_score,
    MIN(pd.total_score) AS min_total_score,
    p.create_by,
    p.create_time
FROM evaluation_publicity p
LEFT JOIN evaluation_publicity_detail pd ON p.id = pd.publicity_id
GROUP BY p.id;

SET FOREIGN_KEY_CHECKS = 1;
