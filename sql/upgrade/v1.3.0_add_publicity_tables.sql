-- =============================================
-- 数据库升级脚本 v1.3.0
-- 功能：添加考评结果公示功能相关表
-- 创建时间：2025-11-03
-- =============================================

USE `ry-vue`;

-- ----------------------------
-- Table structure for evaluation_publicity (公示主表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_publicity`;
CREATE TABLE `evaluation_publicity` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '公示ID',
  `academic_year` varchar(20) NOT NULL COMMENT '学年',
  `semester` tinyint NOT NULL COMMENT '学期',
  `class_id` bigint NOT NULL COMMENT '班级ID',
  `class_name` varchar(100) NOT NULL COMMENT '班级名称（冗余）',
  `title` varchar(255) NOT NULL COMMENT '公示标题',
  `start_time` datetime NOT NULL COMMENT '公示开始时间',
  `end_time` datetime NOT NULL COMMENT '公示结束时间',
  `status` tinyint DEFAULT 0 COMMENT '状态：0-公示中，1-已结束',
  `total_count` int DEFAULT 0 COMMENT '公示人数',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_class_year_semester` (`class_id`, `academic_year`, `semester`),
  KEY `idx_status` (`status`),
  KEY `idx_end_time` (`end_time`),
  KEY `idx_academic_year` (`academic_year`, `semester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考评结果公示表';

-- ----------------------------
-- Table structure for evaluation_publicity_detail (公示详情表)
-- ----------------------------
DROP TABLE IF EXISTS `evaluation_publicity_detail`;
CREATE TABLE `evaluation_publicity_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详情ID',
  `publicity_id` bigint NOT NULL COMMENT '公示ID',
  `submission_id` bigint NOT NULL COMMENT '填报ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `student_name` varchar(64) NOT NULL COMMENT '学生姓名',
  `student_number` varchar(32) NOT NULL COMMENT '学号',
  `total_score` decimal(8,2) NOT NULL COMMENT '总分',
  `moral_score` decimal(6,2) NOT NULL COMMENT '德育分',
  `intellectual_score` decimal(6,2) NOT NULL COMMENT '智育分',
  `physical_score` decimal(6,2) NOT NULL COMMENT '体育分',
  `aesthetic_score` decimal(6,2) NOT NULL COMMENT '美育分',
  `labor_score` decimal(6,2) NOT NULL COMMENT '劳育分',
  `class_rank` int NOT NULL COMMENT '班级排名',
  PRIMARY KEY (`id`),
  KEY `idx_publicity_id` (`publicity_id`),
  KEY `idx_student_id` (`student_id`),
  KEY `idx_submission_id` (`submission_id`),
  KEY `idx_class_rank` (`class_rank`),
  CONSTRAINT `fk_publicity_detail_publicity` FOREIGN KEY (`publicity_id`) REFERENCES `evaluation_publicity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公示详情表';

-- ----------------------------
-- 说明文档
-- ----------------------------
/*
公示功能设计说明：

1. evaluation_publicity (公示主表)
   - 核心特点：按班级、学年学期管理公示
   - 唯一约束：同一班级、学年学期只能有一个公示记录
   - 状态管理：0-公示中，1-已结束
   - 自动结束：通过定时任务检查end_time自动结束公示

2. evaluation_publicity_detail (公示详情表)
   - 核心特点：保存公示时的数据快照
   - 数据完整性：包含学生基本信息和各项分数
   - 排名计算：class_rank字段记录班级排名
   - 级联删除：删除公示主记录时自动删除详情

设计原则：
- 数据快照：公示详情保存快照，防止后续修改影响公示数据
- 唯一约束：防止重复公示
- 级联删除：保证数据一致性
- 索引优化：支持高效查询
*/

