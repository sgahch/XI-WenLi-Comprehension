/*
 修复 submission_id=2 的详情数据
 问题：该填报记录没有对应的详情数据，导致前端无法显示条目明细
 创建时间: 2025-11-11
 说明: 为 submission_id=2 添加测试详情数据
*/

SET NAMES utf8mb4;

-- 检查是否已存在详情数据
SELECT COUNT(*) AS existing_count FROM evaluation_submission_detail WHERE submission_id = 2;

-- 如果不存在，则插入测试数据
-- 注意：这里使用的 rule_id 需要确保在 evaluation_rule 表中存在

-- 插入德育维度的详情（假设 rule_id=1 是德育相关规则）
INSERT INTO `evaluation_submission_detail` 
(`submission_id`, `rule_id`, `rule_snapshot`, `final_score`, `remark`, `status`, `audit_time`, `auditor_id`, `audit_comment`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
(
    2, 
    1, 
    '{"id": 1, "dimensionType": 0, "itemCode": "VOLUNTEER_SERVICE", "itemName": "志愿服务", "maxScore": 10.00, "minScore": 0.00, "defaultScore": 0.00, "scoreType": 1, "weight": 0.10, "category": "社会实践", "dimension": "moral"}', 
    8.00, 
    '参加社区志愿服务活动', 
    0, 
    NULL, 
    NULL, 
    NULL, 
    'admin', 
    '2025-10-25 11:12:42', 
    'admin', 
    '2025-10-25 11:12:42'
);

-- 插入智育维度的详情（假设 rule_id=2 是智育相关规则）
INSERT INTO `evaluation_submission_detail` 
(`submission_id`, `rule_id`, `rule_snapshot`, `final_score`, `remark`, `status`, `audit_time`, `auditor_id`, `audit_comment`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
(
    2, 
    2, 
    '{"id": 2, "dimensionType": 1, "itemCode": "ACADEMIC_COMPETITION", "itemName": "学科竞赛", "maxScore": 20.00, "minScore": 0.00, "defaultScore": 0.00, "scoreType": 1, "weight": 0.10, "category": "学科竞赛", "dimension": "intellectual"}', 
    4.00, 
    '参加数学建模竞赛', 
    0, 
    NULL, 
    NULL, 
    NULL, 
    'admin', 
    '2025-10-25 11:12:42', 
    'admin', 
    '2025-10-25 11:12:42'
);

-- 插入体育维度的详情（假设 rule_id=4 是体育相关规则）
INSERT INTO `evaluation_submission_detail` 
(`submission_id`, `rule_id`, `rule_snapshot`, `final_score`, `remark`, `status`, `audit_time`, `auditor_id`, `audit_comment`, `create_by`, `create_time`, `update_by`, `update_time`)
VALUES 
(
    2, 
    4, 
    '{"id": 4, "dimensionType": 2, "itemCode": "SPORTS_ACTIVITY", "itemName": "体育活动", "maxScore": 15.00, "minScore": 0.00, "defaultScore": 0.00, "scoreType": 1, "weight": 0.10, "category": "体育锻炼", "dimension": "physical"}', 
    15.00, 
    '参加校运会并获奖', 
    0, 
    NULL, 
    NULL, 
    NULL, 
    'admin', 
    '2025-10-25 11:12:42', 
    'admin', 
    '2025-10-25 11:12:42'
);

-- 验证插入的详情记录
SELECT
    d.id,
    d.submission_id,
    d.rule_id,
    d.final_score,
    d.remark,
    JSON_EXTRACT(d.rule_snapshot, '$.itemName') AS item_name,
    JSON_EXTRACT(d.rule_snapshot, '$.dimensionType') AS dimension_type
FROM evaluation_submission_detail d
WHERE d.submission_id = 2
ORDER BY d.id;

-- 获取刚插入的详情ID（用于后续插入附件）
SET @detail_id_moral = (SELECT id FROM evaluation_submission_detail WHERE submission_id = 2 AND rule_id = 1 ORDER BY id DESC LIMIT 1);
SET @detail_id_intellectual = (SELECT id FROM evaluation_submission_detail WHERE submission_id = 2 AND rule_id = 2 ORDER BY id DESC LIMIT 1);
SET @detail_id_physical = (SELECT id FROM evaluation_submission_detail WHERE submission_id = 2 AND rule_id = 4 ORDER BY id DESC LIMIT 1);

-- 为德育详情添加附件（志愿服务证明）
INSERT INTO `evaluation_attachment`
(`detail_id`, `file_name`, `original_name`, `file_path`, `file_size`, `file_type`, `attachment_type`, `url`, `upload_by`, `upload_time`, `create_time`, `update_time`)
VALUES
(
    @detail_id_moral,
    'volunteer_certificate_20251025.pdf',
    '志愿服务证明.pdf',
    '/profile/upload/2025/10/25/volunteer_certificate_20251025.pdf',
    512000,
    'PDF',
    'CERTIFICATE',
    '/profile/upload/2025/10/25/volunteer_certificate_20251025.pdf',
    1,
    '2025-10-25 11:12:42',
    '2025-10-25 11:12:42',
    '2025-10-25 11:12:42'
);

-- 为智育详情添加附件（竞赛获奖证书）
INSERT INTO `evaluation_attachment`
(`detail_id`, `file_name`, `original_name`, `file_path`, `file_size`, `file_type`, `attachment_type`, `url`, `upload_by`, `upload_time`, `create_time`, `update_time`)
VALUES
(
    @detail_id_intellectual,
    'competition_certificate_20251025.jpg',
    '数学建模竞赛证书.jpg',
    '/profile/upload/2025/10/25/competition_certificate_20251025.jpg',
    256000,
    'JPG',
    'CERTIFICATE',
    '/profile/upload/2025/10/25/competition_certificate_20251025.jpg',
    1,
    '2025-10-25 11:12:42',
    '2025-10-25 11:12:42',
    '2025-10-25 11:12:42'
);

-- 为体育详情添加附件（运动会照片）
INSERT INTO `evaluation_attachment`
(`detail_id`, `file_name`, `original_name`, `file_path`, `file_size`, `file_type`, `attachment_type`, `url`, `upload_by`, `upload_time`, `create_time`, `update_time`)
VALUES
(
    @detail_id_physical,
    'sports_photo_20251025.jpg',
    '校运会获奖照片.jpg',
    '/profile/upload/2025/10/25/sports_photo_20251025.jpg',
    384000,
    'JPG',
    'CERTIFICATE',
    '/profile/upload/2025/10/25/sports_photo_20251025.jpg',
    1,
    '2025-10-25 11:12:42',
    '2025-10-25 11:12:42',
    '2025-10-25 11:12:42'
);

-- 验证附件插入结果
SELECT
    a.id,
    a.detail_id,
    a.file_name,
    a.original_name,
    a.url,
    a.file_type,
    a.attachment_type,
    d.submission_id,
    JSON_EXTRACT(d.rule_snapshot, '$.itemName') AS item_name
FROM evaluation_attachment a
JOIN evaluation_submission_detail d ON a.detail_id = d.id
WHERE d.submission_id = 2
ORDER BY a.id;

-- 验证总分是否匹配
SELECT
    s.id,
    s.total_score AS submission_total_score,
    SUM(d.final_score) AS calculated_total_score,
    (s.total_score - SUM(d.final_score)) AS difference
FROM evaluation_submission s
LEFT JOIN evaluation_submission_detail d ON s.id = d.submission_id
WHERE s.id = 2
GROUP BY s.id, s.total_score;

SELECT '✅ 修复完成！submission_id=2 的详情数据和附件已添加' AS message;

