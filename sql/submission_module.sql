/*
 学生综合测评填报模块数据库表结构
 
 创建时间: 2025-01-27
 说明: 本文件包含学生综测填报功能所需的核心数据表
 依赖: 需要先执行 comprehensive_evaluation.sql 创建基础表结构
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_submission_main
-- ----------------------------
DROP TABLE IF EXISTS `t_submission_main`;
CREATE TABLE `t_submission_main` (
  `submission_id` bigint NOT NULL AUTO_INCREMENT COMMENT '填报主键ID',
  `user_id` bigint NOT NULL COMMENT '学生用户ID (关联 sys_user.user_id)',
  `evaluation_system_id` bigint NOT NULL COMMENT '评测系统ID',
  `academic_year` varchar(16) NOT NULL COMMENT '学年，如2023-2024',
  `semester` tinyint NOT NULL COMMENT '学期，1表示第一学期，2表示第二学期',
  `submission_status` varchar(20) NOT NULL DEFAULT 'draft' COMMENT '填报状态：draft-草稿，submitted-已提交，approved-已通过，rejected-已驳回',
  `total_score` decimal(8,2) DEFAULT 0.00 COMMENT '总分（系统计算）',
  `self_evaluation` text COMMENT '自我评价',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_by` bigint DEFAULT NULL COMMENT '审核人用户ID (关联 sys_user.user_id)',
  `audit_comment` text COMMENT '审核意见',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者账号',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者账号',
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `uk_user_system_year_semester` (`user_id`, `academic_year`, `semester`),
  KEY `idx_submission_status` (`submission_status`),
  KEY `fk_submission_system` (`evaluation_system_id`),
  CONSTRAINT `fk_submission_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_submission_system` FOREIGN KEY (`evaluation_system_id`) REFERENCES `t_evaluation_system` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_submission_auditor` FOREIGN KEY (`audit_by`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='综测填报主表';

-- ----------------------------
-- Table structure for t_submission_item
-- ----------------------------
DROP TABLE IF EXISTS `t_submission_item`;
CREATE TABLE `t_submission_item` (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '加分项主键ID',
  `submission_id` bigint NOT NULL COMMENT '关联填报主表ID',
  `evaluation_item_id` bigint NOT NULL COMMENT '评测项目ID',
  `item_name` varchar(128) NOT NULL COMMENT '加分项名称',
  `item_description` text COMMENT '加分项描述说明',
  `apply_score` decimal(5,2) DEFAULT 0.00 COMMENT '申请分数',
  `actual_score` decimal(5,2) DEFAULT 0.00 COMMENT '实际得分（审核后）',
  `item_status` varchar(20) NOT NULL DEFAULT 'draft' COMMENT '状态：draft-草稿，submitted-已提交，approved-已通过，rejected-已驳回',
  `audit_comment` text COMMENT '审核意见',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_by` bigint DEFAULT NULL COMMENT '审核人用户ID (关联 sys_user.user_id)',
  `sort_order` int DEFAULT 0 COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者账号',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者账号',
  PRIMARY KEY (`item_id`),
  KEY `idx_item_submission` (`submission_id`),
  KEY `idx_item_evaluation` (`evaluation_item_id`),
  KEY `idx_item_status` (`item_status`),
  CONSTRAINT `fk_item_submission` FOREIGN KEY (`submission_id`) REFERENCES `t_submission_main` (`submission_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_item_evaluation` FOREIGN KEY (`evaluation_item_id`) REFERENCES `t_evaluation_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_item_auditor` FOREIGN KEY (`audit_by`) REFERENCES `sys_user` (`user_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='综测填报加分项明细表';

-- ----------------------------
-- Table structure for t_submission_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_submission_attachment`;
CREATE TABLE `t_submission_attachment` (
  `attachment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '附件主键ID',
  `submission_item_id` bigint NOT NULL COMMENT '关联加分项ID',
  `original_file_name` varchar(255) NOT NULL COMMENT '原始文件名',
  `object_name` varchar(500) NOT NULL COMMENT '文件在Minio中的对象名称/路径',
  `file_type` varchar(100) NOT NULL COMMENT '文件MIME类型',
  `file_size` bigint NOT NULL COMMENT '文件大小（字节）',
  `file_extension` varchar(10) DEFAULT NULL COMMENT '文件扩展名',
  `upload_status` varchar(20) NOT NULL DEFAULT 'success' COMMENT '上传状态：success-成功，failed-失败',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '上传者账号',
  PRIMARY KEY (`attachment_id`),
  KEY `idx_attachment_item` (`submission_item_id`),
  CONSTRAINT `fk_attachment_item` FOREIGN KEY (`submission_item_id`) REFERENCES `t_submission_item` (`item_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='综测填报附件表';


-- ----------------------------
-- 初始化学生角色菜单权限数据 (已修正)
-- ----------------------------
-- 删除可能已存在的旧菜单，避免主键冲突
DELETE FROM sys_menu WHERE menu_id BETWEEN 2100 AND 2199;

-- 综测管理主菜单
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`remark`) 
VALUES (2100,'综测填报',0,6,'evaluation-submit',NULL,NULL,'Evaluation',1,0,'M','0','0',NULL,'education','admin',NOW(),'','综合测评管理');

-- 学生端菜单
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`remark`) 
VALUES (2101,'我的填报',2100,1,'submission','evaluation-submit/submission/index',NULL,'Submission',1,0,'C','0','0','evaluation:submission:list','edit','admin',NOW(),'','综测填报');
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`remark`) 
VALUES (2102,'填报历史',2100,2,'history','evaluation-submit/submission/history',NULL,'History',1,0,'C','0','0','evaluation:submission:history','time-range','admin',NOW(),'','填报历史');

-- 学生端按钮权限
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`perms`,`icon`,`create_by`,`create_time`,`menu_type`) 
VALUES 
(2111,'查看填报',2101,1,'evaluation:submission:query','#','admin',NOW(),'F'),
(2112,'新增填报',2101,2,'evaluation:submission:add','#','admin',NOW(),'F'),
(2113,'修改填报',2101,3,'evaluation:submission:edit','#','admin',NOW(),'F'),
(2114,'删除填报',2101,4,'evaluation:submission:remove','#','admin',NOW(),'F'),
(2115,'提交填报',2101,5,'evaluation:submission:submit','#','admin',NOW(),'F'),
(2116,'上传附件',2101,6,'evaluation:attachment:upload','#','admin',NOW(),'F'),
(2117,'下载附件',2101,7,'evaluation:attachment:download','#','admin',NOW(),'F');

-- 管理员端菜单（审核功能）
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`remark`) 
VALUES (2120,'填报审核',2100,3,'audit','evaluation-submit/audit/index',NULL,'Audit',1,0,'C','0','0','evaluation:audit:list','check','admin',NOW(),'','填报审核');
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`path`,`component`,`query`,`route_name`,`is_frame`,`is_cache`,`menu_type`,`visible`,`status`,`perms`,`icon`,`create_by`,`create_time`,`update_by`,`remark`) 
VALUES (2121,'成绩统计',2100,4,'statistics','evaluation-submit/statistics/index',NULL,'Statistics',1,0,'C','0','0','evaluation:statistics:list','chart','admin',NOW(),'','成绩统计');

-- 管理员端按钮权限
INSERT INTO `sys_menu` (`menu_id`,`menu_name`,`parent_id`,`order_num`,`perms`,`icon`,`create_by`,`create_time`,`menu_type`) 
VALUES 
(2131,'审核通过',2120,1,'evaluation:audit:approve','#','admin',NOW(),'F'),
(2132,'审核驳回',2120,2,'evaluation:audit:reject','#','admin',NOW(),'F'),
(2133,'查看详情',2120,3,'evaluation:audit:detail','#','admin',NOW(),'F');

SET FOREIGN_KEY_CHECKS = 1;