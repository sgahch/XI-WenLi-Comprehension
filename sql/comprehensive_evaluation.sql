/*
 Navicat Premium Dump SQL

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : comprehensive_evaluation

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 21/09/2025 17:26:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_appeal
-- ----------------------------
DROP TABLE IF EXISTS `t_appeal`;
CREATE TABLE `t_appeal`  (
  `appeal_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申诉ID',
  `record_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联加分记录ID',
  `student_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生ID',
  `appeal_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申诉理由',
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PENDING' COMMENT '状态：PENDING/APPROVED/REJECTED',
  `process_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理结果',
  `process_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理人ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `process_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`appeal_id`) USING BTREE,
  INDEX `record_id`(`record_id` ASC) USING BTREE,
  INDEX `student_id`(`student_id` ASC) USING BTREE,
  INDEX `process_by`(`process_by` ASC) USING BTREE,
  CONSTRAINT `t_appeal_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`record_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_appeal_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `t_sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_appeal_ibfk_3` FOREIGN KEY (`process_by`) REFERENCES `t_sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '申诉表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_appeal
-- ----------------------------
INSERT INTO `t_appeal` VALUES ('APP_001', 'REC001', 'STU001', '我提交的志愿服务证明材料完整，但被驳回，请重新审核', 'PENDING', NULL, NULL, '2023-11-20 10:30:00', NULL);
INSERT INTO `t_appeal` VALUES ('APP_005', 'REC006', 'STU002', '我担任学生会主席虽然不足一年，但工作表现突出，组织了多项重要活动', 'PENDING', NULL, NULL, '2024-03-30 09:45:00', NULL);
INSERT INTO `t_appeal` VALUES ('APP_006', 'REC004', 'STU004', '电子设计竞赛获奖证书已补充提交，请重新审核', 'APPROVED', '补充材料完整，确认获奖真实，同意加分', 'TCH002', '2024-04-01 14:30:00', '2024-04-05 11:20:00');
INSERT INTO `t_appeal` VALUES ('APP001', 'REC001', 'STU001', '材料审核有误，请重新审核', 'PENDING', NULL, NULL, '2025-09-12 21:11:01', NULL);

-- ----------------------------
-- Table structure for t_audit_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_audit_flow`;
CREATE TABLE `t_audit_flow`  (
  `audit_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审核ID',
  `record_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联加分记录ID',
  `auditor_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审核人ID',
  `audit_opinion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核意见',
  `audit_status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审核状态：PASS/REJECT',
  `audit_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  PRIMARY KEY (`audit_id`) USING BTREE,
  INDEX `idx_audit_flow_record`(`record_id` ASC) USING BTREE,
  INDEX `idx_audit_flow_auditor`(`auditor_id` ASC) USING BTREE,
  CONSTRAINT `t_audit_flow_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `t_score_record` (`record_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_audit_flow_ibfk_2` FOREIGN KEY (`auditor_id`) REFERENCES `t_sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审核流程记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_audit_flow
-- ----------------------------
INSERT INTO `t_audit_flow` VALUES ('AUD001', 'REC002', 'MON001', '材料真实，创新项目具有较高价值', 'PASS', '2024-03-18 15:30:00');
INSERT INTO `t_audit_flow` VALUES ('AUD002', 'REC002', 'TCH001', '确认获奖证书真实有效，同意加分', 'PASS', '2024-03-20 14:45:00');
INSERT INTO `t_audit_flow` VALUES ('AUD003', 'REC003', 'MON001', '志愿服务时长充足，证明材料完整', 'PASS', '2024-03-20 10:20:00');
INSERT INTO `t_audit_flow` VALUES ('AUD004', 'REC003', 'TCH001', '志愿服务表现优秀，同意加分', 'PASS', '2024-03-22 16:20:00');
INSERT INTO `t_audit_flow` VALUES ('AUD005', 'REC006', 'MON001', '任职时间不足一年，不符合加分标准', 'REJECT', '2024-03-28 10:15:00');

-- ----------------------------
-- Table structure for t_college_info
-- ----------------------------
DROP TABLE IF EXISTS `t_college_info`;
CREATE TABLE `t_college_info`  (
  `college_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院ID',
  `college_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院名称',
  `director_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人ID（辅导员ID）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`college_id`) USING BTREE,
  INDEX `director_id`(`director_id` ASC) USING BTREE,
  CONSTRAINT `t_college_info_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `t_sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学院信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_college_info
-- ----------------------------
INSERT INTO `t_college_info` VALUES ('COLLEGE_CS', '计算机学院', 'TCH001', '2025-09-12 21:11:01');
INSERT INTO `t_college_info` VALUES ('COLLEGE_EE', '电子工程学院', NULL, '2025-09-12 21:11:01');
INSERT INTO `t_college_info` VALUES ('COLLEGE_MATH', '数学学院', NULL, '2025-09-12 21:11:01');

-- ----------------------------
-- Table structure for t_evaluation_item
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_item`;
CREATE TABLE `t_evaluation_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `system_id` bigint NULL DEFAULT NULL COMMENT '关联测评体系主表',
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
  INDEX `fk_item_system`(`system_id` ASC) USING BTREE,
  CONSTRAINT `fk_item_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_item
-- ----------------------------
INSERT INTO `t_evaluation_item` VALUES (1, 1, 0, '思想品德', 0.20, '思想品德评分规则', 0, 100, 1, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (2, 1, 1, '政治表现', 0.50, '政治表现评分细则', 1, 50, 1, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (3, 1, 1, '道德修养', 0.50, '道德修养评分细则', 1, 50, 2, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (4, 1, 0, '学习成绩', 0.60, '学习成绩评分规则', 0, 100, 2, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (5, 1, 4, '专业课成绩', 0.80, '专业课成绩评分细则', 1, 80, 1, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (6, 1, 4, '公共课成绩', 0.20, '公共课成绩评分细则', 1, 20, 2, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (7, 1, 0, '社会实践', 0.15, '社会实践评分规则', 0, 100, 3, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (8, 1, 7, '志愿服务', 0.60, '志愿服务评分细则', 1, 60, 1, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (9, 1, 7, '社会调研', 0.40, '社会调研评分细则', 1, 40, 2, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_item` VALUES (10, 1, 0, '创新创业', 0.05, '创新创业评分规则', 0, 100, 4, 1, '2025-09-12 21:11:01', '2025-09-12 21:11:01');

-- ----------------------------
-- Table structure for t_evaluation_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_rule`;
CREATE TABLE `t_evaluation_rule`  (
  `rule_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '规则ID',
  `college_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学院ID',
  `indicators` json NOT NULL COMMENT '考评指标集合：[{\"name\":\"学业成绩\",\"weight\":55},{\"name\":\"社会实践\",\"weight\":20}]',
  `semester` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '生效学期（如2025-2026-1）',
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ENABLED' COMMENT '状态：ENABLED/DISABLED',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`rule_id`) USING BTREE,
  INDEX `college_id`(`college_id` ASC) USING BTREE,
  CONSTRAINT `t_evaluation_rule_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `t_college_info` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评规则配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_rule
-- ----------------------------
INSERT INTO `t_evaluation_rule` VALUES ('RULE_CS_2025_1', 'COLLEGE_CS', '[{\"name\": \"学业成绩\", \"weight\": 55}, {\"name\": \"社会实践\", \"weight\": 20}, {\"name\": \"科技创新\", \"weight\": 15}, {\"name\": \"文体活动\", \"weight\": 10}]', '2025-2026-1', 'ENABLED', '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_evaluation_rule` VALUES ('RULE_EE_2025_1', 'COLLEGE_EE', '[{\"name\": \"学业成绩\", \"weight\": 60}, {\"name\": \"实验技能\", \"weight\": 25}, {\"name\": \"创新项目\", \"weight\": 15}]', '2025-2026-1', 'ENABLED', '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_evaluation_rule` VALUES ('RULE_MATH_2025_1', 'COLLEGE_MATH', '[{\"name\": \"理论成绩\", \"weight\": 70}, {\"name\": \"数学建模\", \"weight\": 20}, {\"name\": \"学术论文\", \"weight\": 10}]', '2025-2026-1', 'ENABLED', '2025-09-13 11:47:54', '2025-09-13 11:47:54');

-- ----------------------------
-- Table structure for t_evaluation_system
-- ----------------------------
DROP TABLE IF EXISTS `t_evaluation_system`;
CREATE TABLE `t_evaluation_system`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '测评体系ID',
  `system_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '测评体系名称',
  `academic_year` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学年，如2023-2024',
  `semester` tinyint NOT NULL COMMENT '学期，1表示第一学期，2表示第二学期',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测评体系描述',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-未启用，1-已启用，2-已结束',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` bigint NULL DEFAULT NULL COMMENT '创建者ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测评体系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_evaluation_system
-- ----------------------------
INSERT INTO `t_evaluation_system` VALUES (1, '2023-2024学年第一学期综合测评', '2023-2024', 1, '2023-2024学年第一学期学生综合素质测评体系', 1, '2023-09-01 00:00:00', '2024-01-31 23:59:59', '2025-09-12 21:11:01', '2025-09-12 21:11:01', 1);
INSERT INTO `t_evaluation_system` VALUES (2, '2023-2024学年第二学期综合测评', '2023-2024', 2, '2023-2024学年第二学期学生综合素质测评体系', 0, '2024-02-01 00:00:00', '2024-07-31 23:59:59', '2025-09-12 21:11:01', '2025-09-12 21:11:01', 1);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色描述',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, '管理员', 'admin', '系统管理员，拥有所有权限', 1);
INSERT INTO `t_role` VALUES (2, '学生', 'student', '学生用户，可以提交材料和查看成绩', 1);
INSERT INTO `t_role` VALUES (3, '辅导员', 'teacher', '辅导员，可以审核学生材料', 1);
INSERT INTO `t_role` VALUES (4, '班委', 'monitor', '班委，可以初审学生材料', 1);

-- ----------------------------
-- Table structure for t_score_record
-- ----------------------------
DROP TABLE IF EXISTS `t_score_record`;
CREATE TABLE `t_score_record`  (
  `record_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '记录ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
  `rule_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联规则ID',
  `material_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '材料存储路径',
  `material_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '材料类型：PDF/JPG',
  `reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加分事由',
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态：PENDING_MON/PENDING_TCH/PASS/REJECT',
  `score` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '最终加分值',
  `submit_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `rule_id`(`rule_id` ASC) USING BTREE,
  INDEX `idx_score_record_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_score_record_status`(`status` ASC) USING BTREE,
  INDEX `idx_score_record_submit_time`(`submit_time` ASC) USING BTREE,
  CONSTRAINT `t_score_record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_score_record_ibfk_2` FOREIGN KEY (`rule_id`) REFERENCES `t_evaluation_rule` (`rule_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '考评加分记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_score_record
-- ----------------------------
INSERT INTO `t_score_record` VALUES ('REC001', 'STU001', 'RULE_CS_2025_1', '/uploads/2024/STU001/certificate.pdf', 'PDF', '获得校级三好学生', 'PENDING_MON', 0.00, '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_score_record` VALUES ('REC002', 'STU002', 'RULE_CS_2025_1', '/uploads/2024/STU002/innovation_award.pdf', 'PDF', '获得全国大学生创新创业大赛二等奖', 'PASS', 15.00, '2024-03-15 10:30:00', '2024-03-20 14:45:00');
INSERT INTO `t_score_record` VALUES ('REC003', 'STU003', 'RULE_CS_2025_1', '/uploads/2024/STU003/volunteer_certificate.pdf', 'PDF', '参与社区志愿服务200小时', 'PASS', 8.00, '2024-03-18 09:15:00', '2024-03-22 16:20:00');
INSERT INTO `t_score_record` VALUES ('REC004', 'STU004', 'RULE_EE_2025_1', '/uploads/2024/STU004/competition_award.jpg', 'JPG', '电子设计竞赛省级一等奖', 'PENDING_TCH', 0.00, '2024-03-20 11:45:00', '2024-03-20 11:45:00');
INSERT INTO `t_score_record` VALUES ('REC005', 'STU005', 'RULE_EE_2025_1', '/uploads/2024/STU005/research_paper.pdf', 'PDF', '发表学术论文一篇', 'PENDING_MON', 0.00, '2024-03-22 14:20:00', '2024-03-22 14:20:00');
INSERT INTO `t_score_record` VALUES ('REC006', 'STU002', 'RULE_CS_2025_1', '/uploads/2024/STU002/leadership_cert.pdf', 'PDF', '担任学生会主席一年', 'REJECT', 0.00, '2024-03-25 08:30:00', '2024-03-28 10:15:00');

-- ----------------------------
-- Table structure for t_student_info
-- ----------------------------
DROP TABLE IF EXISTS `t_student_info`;
CREATE TABLE `t_student_info`  (
  `student_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生ID（学号）',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联用户ID',
  `student_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生姓名',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `class_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级名称',
  `major` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业',
  `grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年级',
  `enrollment_date` date NULL DEFAULT NULL COMMENT '入学日期',
  `political_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `dormitory` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '宿舍',
  `home_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `emergency_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系电话',
  `college_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属学院ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `college_id`(`college_id` ASC) USING BTREE,
  CONSTRAINT `t_student_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_student_info_ibfk_2` FOREIGN KEY (`college_id`) REFERENCES `t_college_info` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_student_info
-- ----------------------------
INSERT INTO `t_student_info` VALUES ('2021001234', 'STU001', '王学生', '男', '计算机科学与技术2021-1班', '计算机科学与技术', '2021', NULL, NULL, NULL, NULL, NULL, NULL, 'COLLEGE_CS', '2025-09-12 21:11:01', '2025-09-12 21:11:01');
INSERT INTO `t_student_info` VALUES ('2021001235', 'STU002', '张三丰', '男', '计算机科学与技术2021-1班', '计算机科学与技术', '2021', NULL, NULL, NULL, NULL, NULL, NULL, 'COLLEGE_CS', '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_student_info` VALUES ('2021001236', 'STU003', '李小龙', '男', '计算机科学与技术2021-2班', '计算机科学与技术', '2021', NULL, NULL, NULL, NULL, NULL, NULL, 'COLLEGE_CS', '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_student_info` VALUES ('2021002001', 'STU004', '王大锤', '男', '电子工程2021-1班', '电子工程', '2021', NULL, NULL, NULL, NULL, NULL, NULL, 'COLLEGE_EE', '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_student_info` VALUES ('2021002002', 'STU005', '赵铁柱', '男', '电子工程2021-1班', '电子工程', '2021', NULL, NULL, NULL, NULL, NULL, NULL, 'COLLEGE_EE', '2025-09-13 11:47:54', '2025-09-13 11:47:54');

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
  `audit_by` bigint NULL DEFAULT NULL COMMENT '审核人ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_score_student`(`student_id` ASC) USING BTREE,
  INDEX `fk_score_system`(`system_id` ASC) USING BTREE,
  INDEX `fk_score_item`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk_score_item` FOREIGN KEY (`item_id`) REFERENCES `t_evaluation_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_score_student` FOREIGN KEY (`student_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_score_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生成绩明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_student_score_detail
-- ----------------------------
INSERT INTO `t_student_score_detail` VALUES (1, 5, 1, 2, 45.00, '/uploads/2024/zhangsan/politics_cert.pdf', '参加党课学习并获得优秀学员证书', 2, '材料真实有效，表现优秀', NULL, '2023-10-15 09:30:00', '2023-10-18 14:20:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (2, 5, 1, 3, 48.00, '/uploads/2024/zhangsan/volunteer_cert.pdf', '参与社区志愿服务累计120小时', 2, '志愿服务时长充足，态度积极', NULL, '2023-10-16 10:15:00', '2023-10-19 16:45:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (3, 5, 1, 5, 78.50, '/uploads/2024/zhangsan/grade_report.pdf', '专业课平均分78.5分', 2, '成绩真实', NULL, '2023-11-01 08:00:00', '2023-11-03 09:30:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (4, 5, 1, 8, 35.00, '/uploads/2024/zhangsan/volunteer_activity.pdf', '组织班级志愿服务活动', 2, '组织能力强，活动效果好', NULL, '2023-11-15 14:30:00', '2023-11-18 11:20:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (5, 6, 1, 2, 42.00, '/uploads/2024/lisi/politics_study.pdf', '积极参与政治理论学习', 2, '学习态度认真', NULL, '2023-10-20 11:00:00', '2023-10-23 15:30:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (6, 6, 1, 5, 82.30, '/uploads/2024/lisi/academic_record.pdf', '专业课平均分82.3分', 2, '学习成绩优秀', NULL, '2023-11-02 09:15:00', '2023-11-05 10:45:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (7, 6, 1, 8, 30.00, '/uploads/2024/lisi/community_service.pdf', '参与社区服务活动', 1, NULL, NULL, '2023-11-20 16:20:00', NULL, '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);
INSERT INTO `t_student_score_detail` VALUES (8, 7, 1, 2, 40.00, '/uploads/2024/wangwu/political_activity.pdf', '参加政治学习活动', 2, '参与积极', NULL, '2023-10-25 13:45:00', '2023-10-28 09:15:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (9, 7, 1, 5, 75.80, '/uploads/2024/wangwu/transcript.pdf', '学期成绩单', 2, '成绩合格', NULL, '2023-11-03 10:30:00', '2023-11-06 14:20:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', 3);
INSERT INTO `t_student_score_detail` VALUES (10, 7, 1, 9, 25.00, '/uploads/2024/wangwu/research_report.pdf', '参与社会调研项目', 1, NULL, NULL, '2023-11-25 15:10:00', NULL, '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);
INSERT INTO `t_student_score_detail` VALUES (11, 8, 1, 2, 38.00, '/uploads/2024/zhaoliu/party_study.pdf', '参加入党积极分子培训', 1, NULL, NULL, '2023-12-01 09:00:00', NULL, '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);
INSERT INTO `t_student_score_detail` VALUES (12, 9, 1, 5, 73.20, '/uploads/2024/sunqi/grades.pdf', '期末考试成绩', 1, NULL, NULL, '2023-12-05 11:30:00', NULL, '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);
INSERT INTO `t_student_score_detail` VALUES (13, 10, 1, 8, 28.00, '/uploads/2024/zhouba/volunteer.pdf', '参与敬老院志愿服务', 0, NULL, NULL, '2023-12-10 14:15:00', NULL, '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);

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
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_total_student`(`student_id` ASC) USING BTREE,
  INDEX `fk_total_system`(`system_id` ASC) USING BTREE,
  CONSTRAINT `fk_total_student` FOREIGN KEY (`student_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_total_system` FOREIGN KEY (`system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生总成绩表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_student_total_score
-- ----------------------------
INSERT INTO `t_student_total_score` VALUES (28, 1, 1, 89.50, 18.50, 36.20, 22.80, 12.00, 0.00, 1, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (29, 2, 1, 87.30, 17.80, 35.10, 21.40, 13.00, 0.00, 2, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (30, 5, 1, 85.80, 17.20, 34.50, 20.80, 13.30, 0.00, 3, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (31, 6, 1, 83.60, 16.80, 33.20, 20.10, 13.50, 0.00, 4, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (32, 7, 1, 82.40, 16.50, 32.80, 19.70, 13.40, 0.00, 5, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (33, 8, 1, 81.20, 16.20, 32.10, 19.30, 13.60, 0.00, 6, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (34, 9, 1, 79.90, 15.80, 31.50, 18.90, 13.70, 0.00, 7, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (35, 10, 1, 78.50, 15.50, 30.80, 18.50, 13.70, 0.00, 8, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (36, 11, 1, 77.20, 15.20, 30.20, 18.10, 13.70, 0.00, 9, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (37, 12, 1, 75.80, 14.80, 29.50, 17.80, 13.70, 0.00, 10, '2023-2024', 1, 2, '2024-01-15 10:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', '2024-01-20 09:00:00');
INSERT INTO `t_student_total_score` VALUES (38, 1, 2, 91.20, 18.80, 37.50, 23.20, 11.70, 0.00, 1, '2023-2024', 2, 1, '2024-07-10 14:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);
INSERT INTO `t_student_total_score` VALUES (39, 2, 2, 88.90, 18.20, 36.80, 22.10, 11.80, 0.00, 2, '2023-2024', 2, 1, '2024-07-10 14:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);
INSERT INTO `t_student_total_score` VALUES (40, 5, 2, 86.40, 17.50, 35.20, 21.50, 12.20, 0.00, 3, '2023-2024', 2, 1, '2024-07-10 14:00:00', '2025-09-13 11:47:54', '2025-09-13 11:47:54', NULL);

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user`  (
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID（学号/工号）',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户姓名',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加密存储密码（BCrypt算法）',
  `role` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色：USER_STU/USER_MON/USER_TCH/USER_ADM',
  `college_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属学院ID',
  `contact_info` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系方式',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `idx_sys_user_role`(`role` ASC) USING BTREE,
  INDEX `idx_sys_user_college`(`college_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_user
-- ----------------------------
INSERT INTO `t_sys_user` VALUES ('ADM001', '系统管理员', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_ADM', 'COLLEGE_CS', 'admin@university.edu', 1, '2025-09-12 21:11:01', '2025-09-12 21:18:57');
INSERT INTO `t_sys_user` VALUES ('MON001', '张班委', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_MON', 'COLLEGE_CS', 'monitor@university.edu', 1, '2025-09-12 21:11:01', '2025-09-12 21:19:27');
INSERT INTO `t_sys_user` VALUES ('MON002', '陈班长', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_MON', 'COLLEGE_EE', 'chenmonitor@university.edu', 1, '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_sys_user` VALUES ('STU001', '王学生', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_STU', 'COLLEGE_CS', 'student@university.edu', 1, '2025-09-12 21:11:01', '2025-09-12 21:19:30');
INSERT INTO `t_sys_user` VALUES ('STU002', '张三丰', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_STU', 'COLLEGE_CS', 'zhangsanfeng@university.edu', 1, '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_sys_user` VALUES ('STU003', '李小龙', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_STU', 'COLLEGE_CS', 'lixiaolong@university.edu', 1, '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_sys_user` VALUES ('STU004', '王大锤', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_STU', 'COLLEGE_EE', 'wangdachui@university.edu', 1, '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_sys_user` VALUES ('STU005', '赵铁柱', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_STU', 'COLLEGE_EE', 'zhaotiezhu@university.edu', 1, '2025-09-13 11:47:54', '2025-09-13 11:47:54');
INSERT INTO `t_sys_user` VALUES ('TCH001', '李辅导员', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_TCH', 'COLLEGE_CS', 'teacher@university.edu', 1, '2025-09-12 21:11:01', '2025-09-12 21:19:34');
INSERT INTO `t_sys_user` VALUES ('TCH002', '王教授', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 'USER_TCH', 'COLLEGE_EE', 'wangprof@university.edu', 1, '2025-09-13 11:47:54', '2025-09-13 11:47:54');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名（学号/工号）',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加密密码',
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `real_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `email_verified` tinyint(1) NULL DEFAULT 0 COMMENT '邮箱验证状态',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `phone_verified` tinyint(1) NULL DEFAULT 0 COMMENT '电话验证状态',
  `college_id` bigint NULL DEFAULT NULL COMMENT '所属学院ID',
  `college` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学院名称',
  `major` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业',
  `grade` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年级',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级名称',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别(男/女)',
  `birth_date` datetime NULL DEFAULT NULL COMMENT '出生日期',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `student_id` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `列_name` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `fk_user_role`(`role_id` ASC) USING BTREE,
  INDEX `idx_user_college`(`college` ASC) USING BTREE,
  INDEX `idx_user_major`(`major` ASC) USING BTREE,
  INDEX `idx_user_grade`(`grade` ASC) USING BTREE,
  INDEX `idx_user_gender`(`gender` ASC) USING BTREE,
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表-包含完整的个人信息字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, '系统管理员', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 1, '2025-09-12 21:11:01', '2025-09-13 21:18:03', '系统管理员', 'admin@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (2, '丁学生', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-12 21:11:01', '2025-09-21 17:16:22', 'Ynchen', 'student@university.dev', 0, '13203094369', 0, NULL, '信息工程学院', '软件工程', '2024', '计算机科学与技术2021-1班', 'male', '2025-09-09 00:00:00', '时擦', 'http://192.168.182.128:9000/blog/user/avatar/41f86646-eeb2-4ec5-a469-ee591cca7b16.jpg', 1, '2507240211', NULL);
INSERT INTO `t_user` VALUES (3, '李辅导员', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 3, '2025-09-12 21:11:01', '2025-09-13 21:18:03', '李辅导员', 'teacher@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (4, '张委委', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 4, '2025-09-12 21:11:01', '2025-09-13 21:18:03', '张委委', 'monitor@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (5, '张三', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '张三', 'zhangsan@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (6, '李四', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '李四', 'lisi@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (7, '王五', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '王五', 'wangwu@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (8, '赵六', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '赵六', 'zhaoliu@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (9, '孙七', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '孙七', 'sunqi@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (10, '周八', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '周八', 'zhouba@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (11, '吴九', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '吴九', 'wujiu@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (12, '郑十', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 2, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '郑十', 'zhengshi@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (13, '陈老师', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 3, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '陈老师', 'chenteacher@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);
INSERT INTO `t_user` VALUES (14, '刘班委', '$2a$10$X7egFyMARHJCBmvVcfIp4.5wiKNx3ZNBKe4CCL7fMxp8rm9HXzvvK', 4, '2025-09-13 11:38:53', '2025-09-13 21:18:03', '刘班委', 'liumonitor@university.edu', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '', NULL);

SET FOREIGN_KEY_CHECKS = 1;
