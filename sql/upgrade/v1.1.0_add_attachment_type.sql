-- =============================================
-- 数据库升级脚本 v1.1.0
-- 功能: 添加附件类型字段，支持成绩截图核验
-- 日期: 2025-11-02
-- =============================================

USE `ry-vue`;

-- 1. 为 evaluation_attachment 表添加 attachment_type 字段
ALTER TABLE `evaluation_attachment` 
ADD COLUMN `attachment_type` VARCHAR(32) NOT NULL DEFAULT 'CERTIFICATE' 
COMMENT '附件类型：CERTIFICATE-证书材料，GRADE_SCREENSHOT-成绩截图' 
AFTER `file_type`;

-- 2. 添加索引以提高查询性能
CREATE INDEX `idx_attachment_type` ON `evaluation_attachment`(`attachment_type`);

-- 3. 更新现有数据（将所有现有附件标记为证书类型）
UPDATE `evaluation_attachment` SET `attachment_type` = 'CERTIFICATE' WHERE `attachment_type` IS NULL OR `attachment_type` = '';

-- 4. 验证修改
SELECT 
    COLUMN_NAME, 
    COLUMN_TYPE, 
    COLUMN_DEFAULT, 
    COLUMN_COMMENT 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_SCHEMA = 'ry-vue' 
    AND TABLE_NAME = 'evaluation_attachment' 
    AND COLUMN_NAME = 'attachment_type';

-- 升级完成
SELECT '数据库升级 v1.1.0 完成：已添加 attachment_type 字段' AS message;

