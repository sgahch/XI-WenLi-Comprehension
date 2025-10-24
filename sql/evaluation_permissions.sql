-- 综测系统权限配置SQL
-- 创建综测相关角色和权限

-- 1. 插入综测相关菜单权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
-- 综测管理主菜单
('综测管理', 0, 6, 'evaluation', NULL, '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', NULL, '综合测评管理菜单'),

-- 学生填报子菜单
('综测填报', (SELECT menu_id FROM sys_menu WHERE menu_name = '综测管理' LIMIT 1), 1, 'submission', 'evaluation-submit/submission/index', '', 1, 0, 'C', '0', '0', 'evaluation:submission:list', 'edit', 'admin', sysdate(), '', NULL, '学生综测填报'),

-- 教师审核子菜单
('综测审核', (SELECT menu_id FROM sys_menu WHERE menu_name = '综测管理' LIMIT 1), 2, 'audit', 'evaluation-submit/audit/index', '', 1, 0, 'C', '0', '0', 'evaluation:audit:list', 'validCode', 'admin', sysdate(), '', NULL, '教师综测审核'),

-- 成绩统计子菜单
('成绩统计', (SELECT menu_id FROM sys_menu WHERE menu_name = '综测管理' LIMIT 1), 3, 'statistics', 'evaluation-submit/statistics/index', '', 1, 0, 'C', '0', '0', 'evaluation:statistics:list', 'chart', 'admin', sysdate(), '', NULL, '综测成绩统计'),

-- 系统配置子菜单
('评分配置', (SELECT menu_id FROM sys_menu WHERE menu_name = '综测管理' LIMIT 1), 4, 'config', 'evaluation/t_evaluation/index', '', 1, 0, 'C', '0', '0', 'evaluation:config:list', 'tool', 'admin', sysdate(), '', NULL, '评分项目配置');

-- 2. 插入具体操作权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES
-- 综测填报权限
('综测填报查询', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 1, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:query', '#', 'admin', sysdate(), '', NULL, ''),
('综测填报新增', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 2, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:add', '#', 'admin', sysdate(), '', NULL, ''),
('综测填报修改', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 3, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:edit', '#', 'admin', sysdate(), '', NULL, ''),
('综测填报删除', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 4, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:remove', '#', 'admin', sysdate(), '', NULL, ''),
('综测填报提交', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 5, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:submit', '#', 'admin', sysdate(), '', NULL, ''),
('综测填报导入', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 6, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:import', '#', 'admin', sysdate(), '', NULL, ''),
('综测填报导出', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:submission:list' LIMIT 1), 7, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:submission:export', '#', 'admin', sysdate(), '', NULL, ''),

-- 综测审核权限
('综测审核查询', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:audit:list' LIMIT 1), 1, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:audit:query', '#', 'admin', sysdate(), '', NULL, ''),
('综测审核通过', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:audit:list' LIMIT 1), 2, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:audit:approve', '#', 'admin', sysdate(), '', NULL, ''),
('综测审核驳回', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:audit:list' LIMIT 1), 3, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:audit:reject', '#', 'admin', sysdate(), '', NULL, ''),
('综测审核批量', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:audit:list' LIMIT 1), 4, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:audit:batch', '#', 'admin', sysdate(), '', NULL, ''),

-- 成绩统计权限
('成绩统计查询', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:statistics:list' LIMIT 1), 1, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:statistics:query', '#', 'admin', sysdate(), '', NULL, ''),
('成绩统计导出', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:statistics:list' LIMIT 1), 2, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:statistics:export', '#', 'admin', sysdate(), '', NULL, ''),

-- 评分配置权限
('评分配置查询', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:config:list' LIMIT 1), 1, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:config:query', '#', 'admin', sysdate(), '', NULL, ''),
('评分配置新增', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:config:list' LIMIT 1), 2, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:config:add', '#', 'admin', sysdate(), '', NULL, ''),
('评分配置修改', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:config:list' LIMIT 1), 3, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:config:edit', '#', 'admin', sysdate(), '', NULL, ''),
('评分配置删除', (SELECT menu_id FROM sys_menu WHERE perms = 'evaluation:config:list' LIMIT 1), 4, '', '', '', 1, 0, 'F', '0', '0', 'evaluation:config:remove', '#', 'admin', sysdate(), '', NULL, '');

-- 3. 创建综测相关角色
INSERT INTO sys_role (role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, remark) VALUES
('综测学生', 'evaluation_student', 4, '5', 1, 1, '0', '0', 'admin', sysdate(), '综合测评学生角色，只能填报自己的数据'),
('综测教师', 'evaluation_teacher', 3, '2', 1, 1, '0', '0', 'admin', sysdate(), '综合测评教师角色，可以审核班级学生数据'),
('综测管理员', 'evaluation_admin', 2, '1', 1, 1, '0', '0', 'admin', sysdate(), '综合测评管理员角色，可以管理所有数据');

-- 4. 为角色分配菜单权限
-- 学生角色权限（只能填报）
INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 
    (SELECT role_id FROM sys_role WHERE role_key = 'evaluation_student' LIMIT 1),
    menu_id 
FROM sys_menu 
WHERE perms IN (
    'evaluation:submission:list',
    'evaluation:submission:query', 
    'evaluation:submission:add',
    'evaluation:submission:edit',
    'evaluation:submission:submit'
);

-- 教师角色权限（填报+审核+统计）
INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 
    (SELECT role_id FROM sys_role WHERE role_key = 'evaluation_teacher' LIMIT 1),
    menu_id 
FROM sys_menu 
WHERE perms IN (
    'evaluation:submission:list',
    'evaluation:submission:query',
    'evaluation:submission:add',
    'evaluation:submission:edit',
    'evaluation:submission:submit',
    'evaluation:submission:import',
    'evaluation:submission:export',
    'evaluation:audit:list',
    'evaluation:audit:query',
    'evaluation:audit:approve',
    'evaluation:audit:reject',
    'evaluation:audit:batch',
    'evaluation:statistics:list',
    'evaluation:statistics:query',
    'evaluation:statistics:export'
);

-- 管理员角色权限（所有权限）
INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 
    (SELECT role_id FROM sys_role WHERE role_key = 'evaluation_admin' LIMIT 1),
    menu_id 
FROM sys_menu 
WHERE menu_name LIKE '%综测%' OR menu_name LIKE '%评分%';

-- 5. 创建数据权限过滤规则（确保学生只能看到自己的数据，教师只能看到本班级数据）
-- 这部分需要在具体的Service实现中通过@DataScope注解和自定义数据权限过滤器实现

COMMIT;