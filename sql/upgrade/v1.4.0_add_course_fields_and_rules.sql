-- ============================
-- 综合测评系统升级脚本 v1.4.0
-- 功能：
-- 1. 为 evaluation_rule 表添加课程相关字段（课程代码、学分、绩点）
-- 2. 添加新的加分项规则（蓝桥杯、计算机设计大赛、普通话、四六级等）
-- 创建时间：2025-01-04
-- ============================

-- ============================
-- 第一部分：添加课程相关字段
-- ============================

-- 检查并添加 course_code 字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() 
  AND TABLE_NAME = 'evaluation_rule' 
  AND COLUMN_NAME = 'course_code';

SET @sql = IF(@col_exists = 0,
  'ALTER TABLE `evaluation_rule` ADD COLUMN `course_code` varchar(32) NULL COMMENT ''课程代码'' AFTER `level`',
  'SELECT ''course_code字段已存在'' AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加 credit 字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() 
  AND TABLE_NAME = 'evaluation_rule' 
  AND COLUMN_NAME = 'credit';

SET @sql = IF(@col_exists = 0,
  'ALTER TABLE `evaluation_rule` ADD COLUMN `credit` decimal(3,1) NULL COMMENT ''学分'' AFTER `course_code`',
  'SELECT ''credit字段已存在'' AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加 grade_point 字段
SET @col_exists = 0;
SELECT COUNT(*) INTO @col_exists 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() 
  AND TABLE_NAME = 'evaluation_rule' 
  AND COLUMN_NAME = 'grade_point';

SET @sql = IF(@col_exists = 0,
  'ALTER TABLE `evaluation_rule` ADD COLUMN `grade_point` decimal(3,2) NULL COMMENT ''绩点'' AFTER `credit`',
  'SELECT ''grade_point字段已存在'' AS message');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================
-- 第二部分：添加新的加分项规则
-- ============================

-- 智育维度 - 学科竞赛类

-- 蓝桥杯软件设计大赛
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('intellectual', '学科竞赛', '蓝桥杯软件设计大赛', '国家级一等奖', 15.00, 1, 'PDF,JPG,PNG', '蓝桥杯软件设计大赛国家级一等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '蓝桥杯软件设计大赛', '国家级二等奖', 12.00, 1, 'PDF,JPG,PNG', '蓝桥杯软件设计大赛国家级二等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '蓝桥杯软件设计大赛', '国家级三等奖', 10.00, 1, 'PDF,JPG,PNG', '蓝桥杯软件设计大赛国家级三等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '蓝桥杯软件设计大赛', '省级一等奖', 8.00, 1, 'PDF,JPG,PNG', '蓝桥杯软件设计大赛省级一等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '蓝桥杯软件设计大赛', '省级二等奖', 6.00, 1, 'PDF,JPG,PNG', '蓝桥杯软件设计大赛省级二等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '蓝桥杯软件设计大赛', '省级三等奖', 4.00, 1, 'PDF,JPG,PNG', '蓝桥杯软件设计大赛省级三等奖', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 中国大学生计算机设计大赛
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('intellectual', '学科竞赛', '中国大学生计算机设计大赛', '国家级一等奖', 18.00, 1, 'PDF,JPG,PNG', '中国大学生计算机设计大赛国家级一等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '中国大学生计算机设计大赛', '国家级二等奖', 15.00, 1, 'PDF,JPG,PNG', '中国大学生计算机设计大赛国家级二等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '中国大学生计算机设计大赛', '国家级三等奖', 12.00, 1, 'PDF,JPG,PNG', '中国大学生计算机设计大赛国家级三等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '中国大学生计算机设计大赛', '省级一等奖', 10.00, 1, 'PDF,JPG,PNG', '中国大学生计算机设计大赛省级一等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '中国大学生计算机设计大赛', '省级二等奖', 8.00, 1, 'PDF,JPG,PNG', '中国大学生计算机设计大赛省级二等奖', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '学科竞赛', '中国大学生计算机设计大赛', '省级三等奖', 6.00, 1, 'PDF,JPG,PNG', '中国大学生计算机设计大赛省级三等奖', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 智育维度 - 语言能力类

-- 英语四级
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('intellectual', '语言能力', '大学英语四级', '550分以上', 5.00, 1, 'PDF,JPG,PNG', '大学英语四级成绩550分以上', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '大学英语四级', '500-549分', 3.00, 1, 'PDF,JPG,PNG', '大学英语四级成绩500-549分', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '大学英语四级', '425-499分', 2.00, 1, 'PDF,JPG,PNG', '大学英语四级成绩425-499分（及格）', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 英语六级
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('intellectual', '语言能力', '大学英语六级', '550分以上', 8.00, 1, 'PDF,JPG,PNG', '大学英语六级成绩550分以上', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '大学英语六级', '500-549分', 6.00, 1, 'PDF,JPG,PNG', '大学英语六级成绩500-549分', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '大学英语六级', '425-499分', 4.00, 1, 'PDF,JPG,PNG', '大学英语六级成绩425-499分（及格）', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 普通话水平测试
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('intellectual', '语言能力', '普通话水平测试', '一级甲等', 5.00, 1, 'PDF,JPG,PNG', '普通话水平测试一级甲等（97分以上）', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '普通话水平测试', '一级乙等', 4.00, 1, 'PDF,JPG,PNG', '普通话水平测试一级乙等（92-96.9分）', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '普通话水平测试', '二级甲等', 3.00, 1, 'PDF,JPG,PNG', '普通话水平测试二级甲等（87-91.9分）', 1, 'admin', NOW(), 'admin', NOW()),
('intellectual', '语言能力', '普通话水平测试', '二级乙等', 2.00, 1, 'PDF,JPG,PNG', '普通话水平测试二级乙等（80-86.9分）', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 德育维度 - 社会实践类

-- 志愿服务
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('moral', '社会实践', '志愿服务活动', '国家级优秀', 8.00, 1, 'PDF,JPG,PNG', '国家级优秀志愿服务活动', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '社会实践', '志愿服务活动', '省级优秀', 6.00, 1, 'PDF,JPG,PNG', '省级优秀志愿服务活动', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '社会实践', '志愿服务活动', '校级优秀', 3.00, 1, 'PDF,JPG,PNG', '校级优秀志愿服务活动', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '社会实践', '志愿服务活动', '参与（20小时以上）', 2.00, 1, 'PDF,JPG,PNG', '参与志愿服务活动累计20小时以上', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 德育维度 - 荣誉称号类

-- 三好学生
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('moral', '荣誉称号', '三好学生', '国家级', 15.00, 1, 'PDF,JPG,PNG', '国家级三好学生', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '荣誉称号', '三好学生', '省级', 10.00, 1, 'PDF,JPG,PNG', '省级三好学生', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '荣誉称号', '三好学生', '校级', 5.00, 1, 'PDF,JPG,PNG', '校级三好学生', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 优秀学生干部
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('moral', '荣誉称号', '优秀学生干部', '国家级', 15.00, 1, 'PDF,JPG,PNG', '国家级优秀学生干部', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '荣誉称号', '优秀学生干部', '省级', 10.00, 1, 'PDF,JPG,PNG', '省级优秀学生干部', 1, 'admin', NOW(), 'admin', NOW()),
('moral', '荣誉称号', '优秀学生干部', '校级', 5.00, 1, 'PDF,JPG,PNG', '校级优秀学生干部', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 体育维度 - 体育竞赛类

-- 运动会
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('physical', '体育竞赛', '运动会', '国家级前三名', 15.00, 1, 'PDF,JPG,PNG', '国家级运动会前三名', 1, 'admin', NOW(), 'admin', NOW()),
('physical', '体育竞赛', '运动会', '省级前三名', 10.00, 1, 'PDF,JPG,PNG', '省级运动会前三名', 1, 'admin', NOW(), 'admin', NOW()),
('physical', '体育竞赛', '运动会', '校级前三名', 5.00, 1, 'PDF,JPG,PNG', '校级运动会前三名', 1, 'admin', NOW(), 'admin', NOW()),
('physical', '体育竞赛', '运动会', '校级前八名', 3.00, 1, 'PDF,JPG,PNG', '校级运动会前八名', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 美育维度 - 文艺竞赛类

-- 文艺比赛
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('aesthetic', '文艺竞赛', '文艺比赛', '国家级一等奖', 15.00, 1, 'PDF,JPG,PNG', '国家级文艺比赛一等奖', 1, 'admin', NOW(), 'admin', NOW()),
('aesthetic', '文艺竞赛', '文艺比赛', '省级一等奖', 10.00, 1, 'PDF,JPG,PNG', '省级文艺比赛一等奖', 1, 'admin', NOW(), 'admin', NOW()),
('aesthetic', '文艺竞赛', '文艺比赛', '校级一等奖', 5.00, 1, 'PDF,JPG,PNG', '校级文艺比赛一等奖', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- 劳育维度 - 劳动实践类

-- 劳动实践
INSERT INTO `evaluation_rule` (`dimension`, `category`, `item_name`, `level`, `score`, `require_attachment`, `attachment_types`, `description`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
('labor', '劳动实践', '劳动实践活动', '优秀', 5.00, 1, 'PDF,JPG,PNG', '劳动实践活动优秀', 1, 'admin', NOW(), 'admin', NOW()),
('labor', '劳动实践', '劳动实践活动', '良好', 3.00, 1, 'PDF,JPG,PNG', '劳动实践活动良好', 1, 'admin', NOW(), 'admin', NOW()),
('labor', '劳动实践', '劳动实践活动', '合格', 2.00, 1, 'PDF,JPG,PNG', '劳动实践活动合格', 1, 'admin', NOW(), 'admin', NOW())
ON DUPLICATE KEY UPDATE `update_time` = NOW();

-- ============================
-- 升级完成提示
-- ============================
SELECT '数据库升级脚本 v1.4.0 执行完成！' AS message;

