-- =============================================
-- 为辅导员角色添加班委审核菜单权限
-- 执行时间: 2025-11-11
-- 说明: 让辅导员和班委共用同一个审核页面
-- =============================================

-- 1. 检查辅导员角色是否存在
SELECT role_id, role_name FROM sys_role WHERE role_id = 102;

-- 2. 为辅导员角色(role_id=102)添加班委审核菜单的访问权限
-- 如果已存在则忽略（使用 INSERT IGNORE 或先检查）

-- 检查是否已存在
SELECT * FROM sys_role_menu
WHERE role_id = 102
AND menu_id IN (2006, 2100, 2122, 2140, 2141, 2142, 2143, 2144, 2145, 2146);

-- 插入权限（如果不存在）
-- 首先添加顶级菜单和父菜单权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 102, 2006 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2006);

INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 102, 2100 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2100);

-- 然后添加班委审核菜单权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 102, 2122 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2122);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2140 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2140);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2141 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2141);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2142 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2142);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2143 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2143);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2144 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2144);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2145 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2145);

INSERT INTO sys_role_menu (role_id, menu_id) 
SELECT 102, 2146 FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2146);

-- 3. 验证插入结果
SELECT rm.role_id, r.role_name, rm.menu_id, m.menu_name, m.perms
FROM sys_role_menu rm
LEFT JOIN sys_role r ON rm.role_id = r.role_id
LEFT JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE rm.role_id = 102
AND rm.menu_id IN (2006, 2100, 2122, 2140, 2141, 2142, 2143, 2144, 2145, 2146)
ORDER BY rm.menu_id;

-- =============================================
-- 权限说明
-- =============================================
-- menu_id=2006: 综测管理（顶级菜单）
-- menu_id=2100: 综测填报（父菜单）
-- menu_id=2122: 班委审核主菜单 (evaluation:classCommittee:audit)
-- menu_id=2140: 班委审核查询 (evaluation:classCommittee:query)
-- menu_id=2141: 班委审核通过 (evaluation:classCommittee:approve)
-- menu_id=2142: 班委审核驳回 (evaluation:classCommittee:reject)
-- menu_id=2143: 班委批量审核 (evaluation:classCommittee:batch)
-- menu_id=2144: 班委查看详情 (evaluation:classCommittee:detail)
-- menu_id=2145: 查看成绩截图 (evaluation:classCommittee:viewScreenshot)
-- menu_id=2146: 班委审核导出 (evaluation:classCommittee:export)

