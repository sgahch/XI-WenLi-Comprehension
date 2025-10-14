-- =============================================
-- 添加业务相关角色和初始数据
-- =============================================

-- 添加学生综合测评系统专用角色
INSERT INTO sys_role (role_name, role_key, role_sort, status, remark, create_by, create_time) VALUES
('学生', 'student', 3, '0', '学生角色 - 可提交材料和查看自己成绩', 'admin', NOW()),
('班委', 'monitor', 4, '0', '班委角色 - 可初审学生材料', 'admin', NOW()),
('辅导员', 'counselor', 5, '0', '辅导员角色 - 可审核学生材料和管理学院事务', 'admin', NOW());

-- 添加测试学院数据
INSERT INTO t_college_info (college_name, college_code, status) VALUES
('计算机科学与技术学院', 'CS', 1),
('电子工程学院', 'EE', 1),
('数学学院', 'MATH', 1);

-- 添加默认测评体系
INSERT INTO t_evaluation_system (system_name, academic_year, semester, description, status, start_time, end_time) VALUES
('2024-2025学年第一学期综合测评', '2024-2025', 1, '2024-2025学年第一学期学生综合素质测评体系', 1, '2024-09-01 00:00:00', '2025-01-31 23:59:59'),
('2024-2025学年第二学期综合测评', '2024-2025', 2, '2024-2025学年第二学期学生综合素质测评体系', 0, '2025-02-01 00:00:00', '2025-07-31 23:59:59');

-- 添加默认测评项目
INSERT INTO t_evaluation_item (system_id, parent_id, item_name, weight, score_rule, item_type, max_score, sort_order) VALUES
(1, 0, '思想品德', 0.20, '思想品德评分规则', 0, 100, 1),
(1, 1, '政治表现', 0.50, '政治表现评分细则', 1, 50, 1),
(1, 1, '道德修养', 0.50, '道德修养评分细则', 1, 50, 2),
(1, 0, '学习成绩', 0.60, '学习成绩评分规则', 0, 100, 2),
(1, 4, '专业课成绩', 0.80, '专业课成绩评分细则', 1, 80, 1),
(1, 4, '公共课成绩', 0.20, '公共课成绩评分细则', 1, 20, 2),
(1, 0, '社会实践', 0.15, '社会实践评分规则', 0, 100, 3),
(1, 7, '志愿服务', 0.60, '志愿服务评分细则', 1, 60, 1),
(1, 7, '社会调研', 0.40, '社会调研评分细则', 1, 40, 2),
(1, 0, '创新创业', 0.05, '创新创业评分规则', 0, 100, 4);

-- 添加默认评价规则
INSERT INTO t_evaluation_rule (college_id, rule_name, indicators, semester, status) VALUES
(1, '计算机学院2024-2025-1学期评价规则', '[{"name": "学业成绩", "weight": 55}, {"name": "社会实践", "weight": 20}, {"name": "科技创新", "weight": 15}, {"name": "文体活动", "weight": 10}]', '2024-2025-1', 1),
(2, '电子工程学院2024-2025-1学期评价规则', '[{"name": "学业成绩", "weight": 60}, {"name": "实验技能", "weight": 25}, {"name": "创新项目", "weight": 15}]', '2024-2025-1', 1);

SELECT '业务初始数据添加完成！' AS message;