/*
 考评结果公示功能 - 数据库升级脚本
 版本: v1.3.0
 创建时间: 2025-11-11
 说明: 可直接在现有数据库上执行，升级公示功能表结构
 
 执行方式：
 1. 备份数据库（重要！）
 2. 在MySQL客户端执行：source /path/to/v1.3.0_publicity_upgrade.sql
 3. 或使用Navicat等工具直接运行本脚本
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 第一步：删除旧的公示表（如果存在）
-- ============================================
DROP TABLE IF EXISTS `evaluation_publicity_view_log`;
DROP TABLE IF EXISTS `evaluation_publicity_detail`;
DROP TABLE IF EXISTS `evaluation_publicity`;

-- ============================================
-- 第二步：创建新的公示主表
-- ============================================
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

-- ============================================
-- 第三步：创建公示详情表
-- ============================================
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

-- ============================================
-- 第四步：创建公示浏览日志表
-- ============================================
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

-- ============================================
-- 第五步：创建公示统计视图
-- ============================================
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

-- ============================================
-- 第六步：插入测试数据
-- ============================================
INSERT INTO `evaluation_publicity` VALUES 
(1, '2024-2025', 1, NULL, NULL, '2024-2025学年第一学期综合测评结果公示', 
 '根据《西安文理学院学生综合素质测评办法》，现将2024-2025学年第一学期综合测评结果予以公示。公示期为5个工作日，如有异议，请在公示期内向辅导员提出申诉。', 
 '2025-01-15 09:00:00', '2025-01-22 18:00:00', 5, 0, 0, 0, 'admin', NOW(), 'admin', NOW(), '全校公示');

-- ============================================
-- 第七步：验证表结构
-- ============================================
SELECT 'evaluation_publicity 表创建成功' AS message, COUNT(*) AS record_count FROM evaluation_publicity;
SELECT 'evaluation_publicity_detail 表创建成功' AS message, COUNT(*) AS record_count FROM evaluation_publicity_detail;
SELECT 'evaluation_publicity_view_log 表创建成功' AS message, COUNT(*) AS record_count FROM evaluation_publicity_view_log;
SELECT 'v_publicity_stats 视图创建成功' AS message;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- 升级完成说明
-- ============================================
/*
升级完成！

已创建的表：
1. evaluation_publicity - 公示主表
   - 支持全校/学院/班级三级公示
   - 包含公示期管理、浏览统计等功能

2. evaluation_publicity_detail - 公示详情表
   - 记录每个学生的公示数据
   - 包含数据快照、排名信息等

3. evaluation_publicity_view_log - 公示浏览日志表
   - 记录用户浏览公示的日志
   - 支持浏览量统计和用户行为分析

已创建的视图：
1. v_publicity_stats - 公示统计视图
   - 自动统计公示的关键指标

下一步操作：
1. 创建公示相关的Java实体类
2. 创建公示Service和Controller
3. 创建前端公示管理页面
4. 创建前端公示查看页面

注意事项：
- 公示删除时会自动级联删除详情和浏览日志
- 同一公示中不能重复添加同一学生（唯一约束）
- 公示支持全校、学院、班级三个级别
*/

