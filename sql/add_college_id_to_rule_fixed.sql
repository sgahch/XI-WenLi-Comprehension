-- =============================================
-- 为 evaluation_rule 表添加 college_id 字段（修复版）
-- 用于支持不同学院对同一课程的差异化评分标准
-- =============================================
-- 作者: AI Assistant
-- 创建时间: 2025-11-03
-- 修复时间: 2025-11-03
-- 修复内容: 
--   1. 添加字段/索引存在性检查，避免重复执行错误
--   2. 移除不存在的 status 字段
-- =============================================

USE `ry-vue`;

-- =============================================
-- 第一部分：添加字段和索引（带存在性检查）
-- =============================================

-- 1. 添加 college_id 字段（如果不存在）
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                   WHERE TABLE_SCHEMA = DATABASE() 
                   AND TABLE_NAME = 'evaluation_rule' 
                   AND COLUMN_NAME = 'college_id');

SET @sql = IF(@col_exists = 0, 
              'ALTER TABLE `evaluation_rule` ADD COLUMN `college_id` bigint NULL COMMENT ''学院ID，关联sys_dept.dept_id，用于区分不同学院的评分标准。NULL表示通用规则，适用于所有学院'' AFTER `dimension`',
              'SELECT ''✅ 字段 college_id 已存在，跳过添加'' AS message');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 2. 添加索引（如果不存在）
SET @idx1_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                    WHERE TABLE_SCHEMA = DATABASE() 
                    AND TABLE_NAME = 'evaluation_rule' 
                    AND INDEX_NAME = 'idx_college_dimension');

SET @sql = IF(@idx1_exists = 0,
              'CREATE INDEX `idx_college_dimension` ON `evaluation_rule`(`college_id`, `dimension`)',
              'SELECT ''✅ 索引 idx_college_dimension 已存在，跳过创建'' AS message');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 3. 添加复合索引（如果不存在）
SET @idx2_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                    WHERE TABLE_SCHEMA = DATABASE() 
                    AND TABLE_NAME = 'evaluation_rule' 
                    AND INDEX_NAME = 'idx_college_category');

SET @sql = IF(@idx2_exists = 0,
              'CREATE INDEX `idx_college_category` ON `evaluation_rule`(`college_id`, `category`)',
              'SELECT ''✅ 索引 idx_college_category 已存在，跳过创建'' AS message');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =============================================
-- 第二部分：插入示例课程成绩规则
-- =============================================

-- 假设学院ID：
-- 201 = 信息工程学院
-- 202 = 文学院
-- 203 = 理学院

-- 注意：请根据实际情况修改学院ID
-- 查询学院ID的SQL：SELECT dept_id, dept_name FROM sys_dept WHERE parent_id = 100;

-- =============================================
-- 信息工程学院 - 高等数学
-- =============================================

INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`) 
VALUES 
('intellectual', 201, '课程成绩', '高等数学', '90分以上', 5.00, '课程成绩达到90分以上', 0, NULL, NOW(), NOW()),
('intellectual', 201, '课程成绩', '高等数学', '85-89分', 3.00, '课程成绩达到85-89分', 0, NULL, NOW(), NOW()),
('intellectual', 201, '课程成绩', '高等数学', '80-84分', 2.00, '课程成绩达到80-84分', 0, NULL, NOW(), NOW());

-- =============================================
-- 文学院 - 高等数学（加分较少）
-- =============================================

INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`) 
VALUES 
('intellectual', 202, '课程成绩', '高等数学', '90分以上', 3.00, '课程成绩达到90分以上', 0, NULL, NOW(), NOW()),
('intellectual', 202, '课程成绩', '高等数学', '85-89分', 2.00, '课程成绩达到85-89分', 0, NULL, NOW(), NOW()),
('intellectual', 202, '课程成绩', '高等数学', '80-84分', 1.00, '课程成绩达到80-84分', 0, NULL, NOW(), NOW());

-- =============================================
-- 信息工程学院 - 大学英语
-- =============================================

INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`) 
VALUES 
('intellectual', 201, '课程成绩', '大学英语', '90分以上', 4.00, '课程成绩达到90分以上', 0, NULL, NOW(), NOW()),
('intellectual', 201, '课程成绩', '大学英语', '85-89分', 2.50, '课程成绩达到85-89分', 0, NULL, NOW(), NOW()),
('intellectual', 201, '课程成绩', '大学英语', '80-84分', 1.50, '课程成绩达到80-84分', 0, NULL, NOW(), NOW());

-- =============================================
-- 验证
-- =============================================

-- 查询所有课程成绩规则
SELECT '✅ 课程成绩规则列表：' AS message;
SELECT 
  id,
  college_id AS '学院ID',
  item_name AS '课程名称',
  level AS '等级',
  score AS '加分',
  description AS '描述'
FROM evaluation_rule 
WHERE category = '课程成绩' 
ORDER BY college_id, item_name, score DESC;

-- 统计课程成绩规则数量
SELECT '✅ 课程成绩规则统计：' AS message;
SELECT 
  college_id AS '学院ID',
  item_name AS '课程名称',
  COUNT(*) AS '规则数量'
FROM evaluation_rule 
WHERE category = '课程成绩' 
GROUP BY college_id, item_name;

SELECT '✅ 数据库修改完成！' AS message;

