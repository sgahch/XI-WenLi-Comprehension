-- =============================================
-- 为 evaluation_rule 表添加 college_id 字段
-- 用于支持不同学院对同一课程的差异化评分标准
-- =============================================
-- 作者: AI Assistant
-- 创建时间: 2025-11-03
-- =============================================

USE `ry-vue`;

-- 1. 添加 college_id 字段（如果不存在）
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE TABLE_SCHEMA = DATABASE()
                   AND TABLE_NAME = 'evaluation_rule'
                   AND COLUMN_NAME = 'college_id');

SET @sql = IF(@col_exists = 0,
              'ALTER TABLE `evaluation_rule` ADD COLUMN `college_id` bigint NULL COMMENT ''学院ID，关联sys_dept.dept_id，用于区分不同学院的评分标准。NULL表示通用规则，适用于所有学院'' AFTER `dimension`',
              'SELECT ''字段 college_id 已存在，跳过添加'' AS message');

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
              'SELECT ''索引 idx_college_dimension 已存在，跳过创建'' AS message');

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
              'SELECT ''索引 idx_college_category 已存在，跳过创建'' AS message');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =============================================
-- 示例数据：课程成绩规则
-- =============================================

-- 假设学院ID：
-- 201 = 信息工程学院
-- 202 = 文学院
-- 203 = 理学院

-- =============================================
-- 信息工程学院 - 高等数学
-- =============================================

-- 90分以上
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',           -- 维度：智育
  201,                      -- 学院ID：信息工程学院
  '课程成绩',               -- 类别
  '高等数学',               -- 项目名称
  '90分以上',               -- 等级
  5.00,                     -- 分数
  '课程成绩达到90分以上',   -- 描述
  0,                        -- 不需要附件（成绩截图作为整体核验）
  NULL,                     -- 附件类型
  NOW(),
  NOW()
);

-- 85-89分
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  201,
  '课程成绩',
  '高等数学',
  '85-89分',
  3.00,
  '课程成绩达到85-89分',
  0,
  NULL,
  NOW(),
  NOW()
);

-- 80-84分
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  201,
  '课程成绩',
  '高等数学',
  '80-84分',
  2.00,
  '课程成绩达到80-84分',
  0,
  NULL,
  NOW(),
  NOW()
);

-- =============================================
-- 文学院 - 高等数学（加分较少）
-- =============================================

-- 90分以上
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  202,                      -- 学院ID：文学院
  '课程成绩',
  '高等数学',
  '90分以上',
  3.00,                     -- 文学院加分较少
  '课程成绩达到90分以上',
  0,
  NULL,
  NOW(),
  NOW()
);

-- 85-89分
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  202,
  '课程成绩',
  '高等数学',
  '85-89分',
  2.00,
  '课程成绩达到85-89分',
  0,
  NULL,
  NOW(),
  NOW()
);

-- 80-84分
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  202,
  '课程成绩',
  '高等数学',
  '80-84分',
  1.00,
  '课程成绩达到80-84分',
  0,
  NULL,
  NOW(),
  NOW()
);

-- =============================================
-- 信息工程学院 - 大学英语
-- =============================================

-- 90分以上
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  201,
  '课程成绩',
  '大学英语',
  '90分以上',
  4.00,
  '课程成绩达到90分以上',
  0,
  NULL,
  NOW(),
  NOW()
);

-- 85-89分
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  201,
  '课程成绩',
  '大学英语',
  '85-89分',
  2.50,
  '课程成绩达到85-89分',
  0,
  NULL,
  NOW(),
  NOW()
);

-- 80-84分
INSERT INTO `evaluation_rule` (`dimension`, `college_id`, `category`, `item_name`, `level`, `score`, `description`, `require_attachment`, `attachment_types`, `create_time`, `update_time`)
VALUES (
  'intellectual',
  201,
  '课程成绩',
  '大学英语',
  '80-84分',
  1.50,
  '课程成绩达到80-84分',
  0,
  NULL,
  NOW(),
  NOW()
);

-- =============================================
-- 说明
-- =============================================
-- 1. college_id 为 NULL 的规则表示通用规则，适用于所有学院
-- 2. 课程成绩规则的 category 统一为 "课程成绩"
-- 3. 课程成绩规则的 require_attachment 为 0，因为成绩截图作为整体核验依据
-- 4. 不同学院可以为同一课程设置不同的加分标准
-- 5. 管理员可以通过批量导入功能快速添加课程规则

-- =============================================
-- 验证
-- =============================================
-- 查询信息工程学院的课程成绩规则
-- SELECT * FROM evaluation_rule WHERE college_id = 201 AND category = '课程成绩';

-- 查询文学院的课程成绩规则
-- SELECT * FROM evaluation_rule WHERE college_id = 202 AND category = '课程成绩';

-- 查询所有课程成绩规则
-- SELECT * FROM evaluation_rule WHERE category = '课程成绩' ORDER BY college_id, item_name, score DESC;

