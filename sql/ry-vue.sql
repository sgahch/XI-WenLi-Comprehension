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

 Date: 22/10/2025 20:07:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-09-22 08:19:54', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '学生部门', 1, '胡淇', '13203094369', '1911779729@qq.com', '0', '0', 'admin', '2025-09-24 09:18:11', '', NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 260 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

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
INSERT INTO `sys_menu` VALUES (2101, '我的填报', 2100, 1, 'submission', 'evaluation-submit/submission/index', NULL, 'Submission', 1, 0, 'C', '0', '0', 'evaluation:submission:list', 'edit', 'admin', '2025-10-17 22:05:56', 'admin', '2025-10-18 09:59:30', '综测填报');
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
) ENGINE = InnoDB AUTO_INCREMENT = 199 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

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
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-09-22 08:19:54', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '学生', 'student', 3, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:44:52', 'admin', '2025-10-18 10:54:51', '学生角色 - 可提交材料和查看自己成绩');
INSERT INTO `sys_role` VALUES (101, '班委', 'monitor', 4, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:44:52', 'admin', '2025-10-18 10:55:05', '班委角色 - 可初审学生材料');
INSERT INTO `sys_role` VALUES (102, '辅导员', 'counselor', 5, '1', 1, 1, '0', '0', 'admin', '2025-09-22 08:44:52', '', NULL, '辅导员角色 - 可审核学生材料和管理学院事务');

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
INSERT INTO `sys_role_menu` VALUES (2, 4);
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
INSERT INTO `sys_role_menu` VALUES (100, 2120);
INSERT INTO `sys_role_menu` VALUES (100, 2121);
INSERT INTO `sys_role_menu` VALUES (100, 2131);
INSERT INTO `sys_role_menu` VALUES (100, 2132);
INSERT INTO `sys_role_menu` VALUES (100, 2133);
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
INSERT INTO `sys_role_menu` VALUES (101, 2121);
INSERT INTO `sys_role_menu` VALUES (101, 2131);
INSERT INTO `sys_role_menu` VALUES (101, 2132);
INSERT INTO `sys_role_menu` VALUES (101, 2133);

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
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-22 19:45:32', '2025-09-22 08:19:54', 'admin', '2025-09-22 08:19:54', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-09-22 08:19:54', '2025-09-22 08:19:54', 'admin', '2025-09-22 08:19:54', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 202, '胡淇', 'Ynchen', '00', '1911779729@qq.com', '13203094369', '0', '', '$2a$10$DhOaE/JwCT6QQ8NuetVWUOamb0UV8QJaBUARDpQ3u8BBpb3NWD84m', '0', '0', '127.0.0.1', '2025-10-20 15:46:17', '2025-09-24 12:42:18', 'admin', '2025-09-24 09:22:50', 'admin', '2025-10-22 20:01:32', NULL);
INSERT INTO `sys_user` VALUES (101, 104, 'test', 'test', '00', '2364598338@qq.com', '17589733957', '0', '', '$2a$10$1jKDNUVEDzBDhSdP9GrxVeMUhAAjVQHz6/7lhCaqnjeab.mE768eS', '0', '0', '', NULL, NULL, 'admin', '2025-09-24 12:41:06', 'admin', '2025-10-01 15:00:24', NULL);
INSERT INTO `sys_user` VALUES (102, 201, '高瑾', '高瑾', '00', 'gaojin@qq.com', '13203094366', '1', '', '$2a$10$Gfr/mRSwyQNcu//3Qg5/2.dY7AVvLGod8fVqFf3OGHkIv/uvTbyyW', '0', '0', '', NULL, NULL, 'admin', '2025-10-22 19:50:33', '', NULL, NULL);

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
INSERT INTO `t_user_profile` VALUES (1, 100, '2507240211', '信息工程学院', '软件工程', '24级', '2402', NULL, '2019-09-02', NULL, '2024-09-01', '615', '湖南', '父亲', '13203094369', 1, '2025-09-27 19:08:41', '2025-09-27 19:08:41');

SET FOREIGN_KEY_CHECKS = 1;
