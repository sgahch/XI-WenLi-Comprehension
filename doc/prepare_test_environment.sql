-- ============================================================
-- 学生批量导入功能测试环境准备脚本
-- ============================================================
-- 说明：
-- 1. 此脚本用于创建测试所需的部门结构
-- 2. 请在执行导入测试前运行此脚本
-- 3. 如果部门已存在，可以跳过相应的INSERT语句
-- ============================================================

-- 检查并创建测试部门结构
-- 部门层级：学院 -> 专业 -> 班级

-- ============================================================
-- 1. 创建学院（如果不存在）
-- ============================================================

-- 检查信息学院是否存在
SELECT dept_id, dept_name, parent_id FROM sys_dept WHERE dept_name = '信息学院' AND del_flag = '0';

-- 如果不存在，插入信息学院（假设parent_id=100为根部门）
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, status, del_flag, create_by, create_time)
SELECT 101, 100, '0,100', '信息学院', 1, NULL, '0', '0', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_name = '信息学院' AND del_flag = '0');

-- ============================================================
-- 2. 创建专业（如果不存在）
-- ============================================================

-- 软件工程专业
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, status, del_flag, create_by, create_time)
SELECT 103, 101, '0,100,101', '软件工程', 1, NULL, '0', '0', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_name = '软件工程' AND parent_id = 101 AND del_flag = '0');

-- 计算机科学与技术专业
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, status, del_flag, create_by, create_time)
SELECT 104, 101, '0,100,101', '计算机科学与技术', 2, NULL, '0', '0', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_name = '计算机科学与技术' AND parent_id = 101 AND del_flag = '0');

-- ============================================================
-- 3. 创建班级（如果不存在）
-- ============================================================

-- 软件工程 2401班
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, status, del_flag, create_by, create_time)
SELECT 500, 103, '0,100,101,103', '2401', 1, NULL, '0', '0', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_name = '2401' AND parent_id = 103 AND del_flag = '0');

-- 软件工程 2402班
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, status, del_flag, create_by, create_time)
SELECT 501, 103, '0,100,101,103', '2402', 2, NULL, '0', '0', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_name = '2402' AND parent_id = 103 AND del_flag = '0');

-- 计算机科学与技术 2401班
INSERT INTO sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, status, del_flag, create_by, create_time)
SELECT 502, 104, '0,100,101,104', '2401', 1, NULL, '0', '0', 'admin', NOW()
WHERE NOT EXISTS (SELECT 1 FROM sys_dept WHERE dept_name = '2401' AND parent_id = 104 AND del_flag = '0');

-- ============================================================
-- 4. 验证部门结构
-- ============================================================

-- 查看完整的部门树结构
SELECT 
    d1.dept_id AS '学院ID',
    d1.dept_name AS '学院',
    d2.dept_id AS '专业ID',
    d2.dept_name AS '专业',
    d3.dept_id AS '班级ID',
    d3.dept_name AS '班级'
FROM sys_dept d1
LEFT JOIN sys_dept d2 ON d2.parent_id = d1.dept_id AND d2.del_flag = '0'
LEFT JOIN sys_dept d3 ON d3.parent_id = d2.dept_id AND d3.del_flag = '0'
WHERE d1.dept_name = '信息学院' AND d1.del_flag = '0'
ORDER BY d2.dept_id, d3.dept_id;

-- ============================================================
-- 5. 检查角色配置
-- ============================================================

-- 验证学生角色（role_id=100）
SELECT role_id, role_name, role_key, status FROM sys_role WHERE role_id = 100;

-- 如果学生角色不存在，创建它
INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, status, del_flag, create_by, create_time, remark)
SELECT 100, '学生', 'student', 3, '5', '0', '0', 'admin', NOW(), '学生角色'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE role_id = 100);

-- 验证班委角色（role_id=101）
SELECT role_id, role_name, role_key, status FROM sys_role WHERE role_id = 101;

-- 如果班委角色不存在，创建它
INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, status, del_flag, create_by, create_time, remark)
SELECT 101, '班委', 'class_leader', 4, '5', '0', '0', 'admin', NOW(), '班委角色'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE role_id = 101);

-- 验证辅导员角色（role_id=102）
SELECT role_id, role_name, role_key, status FROM sys_role WHERE role_id = 102;

-- 如果辅导员角色不存在，创建它
INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, status, del_flag, create_by, create_time, remark)
SELECT 102, '辅导员', 'counselor', 5, '2', '0', '0', 'admin', NOW(), '辅导员角色'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE role_id = 102);

-- ============================================================
-- 6. 检查系统配置
-- ============================================================

-- 验证初始密码配置
SELECT config_id, config_name, config_key, config_value FROM sys_config WHERE config_key = 'sys.user.initPassword';

-- 如果配置不存在，创建它（默认密码123456）
INSERT INTO sys_config (config_name, config_key, config_value, config_type, create_by, create_time, remark)
SELECT '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', NOW(), '初始化密码 123456'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key = 'sys.user.initPassword');

-- ============================================================
-- 7. 清理测试数据（可选）
-- ============================================================

-- 如果需要重新测试，可以执行以下语句清理之前的测试数据
-- 注意：请谨慎使用，确保不会删除生产数据

-- 删除测试用户（学号以2507开头或教职工号以T2024开头）
-- DELETE FROM sys_user WHERE user_name LIKE '2507%' OR user_name LIKE 'T2024%';

-- 删除测试学生档案
-- DELETE FROM t_user_profile WHERE student_id LIKE '2507%' OR student_id LIKE 'T2024%';

-- 删除测试用户角色关联
-- DELETE FROM sys_user_role WHERE user_id IN (SELECT user_id FROM sys_user WHERE user_name LIKE '2507%' OR user_name LIKE 'T2024%');

-- ============================================================
-- 8. 测试前验证清单
-- ============================================================

-- 验证部门数量
SELECT 
    '部门验证' AS '检查项',
    COUNT(*) AS '数量',
    CASE WHEN COUNT(*) >= 6 THEN '✓ 通过' ELSE '✗ 失败' END AS '状态'
FROM sys_dept 
WHERE dept_name IN ('信息学院', '软件工程', '计算机科学与技术', '2401', '2402') 
AND del_flag = '0';

-- 验证角色数量
SELECT 
    '角色验证' AS '检查项',
    COUNT(*) AS '数量',
    CASE WHEN COUNT(*) >= 3 THEN '✓ 通过' ELSE '✗ 失败' END AS '状态'
FROM sys_role 
WHERE role_id IN (100, 101, 102) 
AND del_flag = '0';

-- 验证配置
SELECT 
    '配置验证' AS '检查项',
    COUNT(*) AS '数量',
    CASE WHEN COUNT(*) >= 1 THEN '✓ 通过' ELSE '✗ 失败' END AS '状态'
FROM sys_config 
WHERE config_key = 'sys.user.initPassword';

-- ============================================================
-- 9. 测试数据查询模板
-- ============================================================

-- 查询导入的用户
-- SELECT user_id, user_name, nick_name, dept_id, phonenumber, email, sex, status, create_time
-- FROM sys_user
-- WHERE user_name LIKE '2507%' OR user_name LIKE 'T2024%'
-- ORDER BY create_time DESC;

-- 查询用户角色关联
-- SELECT u.user_name, u.nick_name, r.role_name
-- FROM sys_user u
-- JOIN sys_user_role ur ON u.user_id = ur.user_id
-- JOIN sys_role r ON ur.role_id = r.role_id
-- WHERE u.user_name LIKE '2507%' OR u.user_name LIKE 'T2024%'
-- ORDER BY u.user_name, r.role_id;

-- 查询学生档案
-- SELECT p.student_id, p.college, p.major, p.grade, p.class_name, p.political_status, p.enrollment_date
-- FROM t_user_profile p
-- WHERE p.student_id LIKE '2507%'
-- ORDER BY p.student_id;

-- ============================================================
-- 完成
-- ============================================================

SELECT '测试环境准备完成！' AS '状态', 
       '请执行上述验证查询确认环境配置正确' AS '提示';

