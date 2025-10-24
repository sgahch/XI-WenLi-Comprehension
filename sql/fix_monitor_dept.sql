-- 修复班委角色用户的部门分配问题
-- 将有班委角色的用户部门更新为班委部门

-- 查询当前有班委角色但不在班委部门的用户
SELECT 
    u.user_id,
    u.user_name,
    u.nick_name,
    u.dept_id as current_dept_id,
    d.dept_name as current_dept_name,
    r.role_name
FROM sys_user u
LEFT JOIN sys_dept d ON u.dept_id = d.dept_id
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE ur.role_id = 101  -- 班委角色ID
  AND u.dept_id != 202; -- 不在班委部门

-- 更新有班委角色的用户部门为班委部门
UPDATE sys_user 
SET dept_id = 202,  -- 班委部门ID
    update_by = 'admin',
    update_time = NOW()
WHERE user_id IN (
    SELECT DISTINCT ur.user_id 
    FROM sys_user_role ur 
    WHERE ur.role_id = 101  -- 班委角色ID
);

-- 验证更新结果
SELECT 
    u.user_id,
    u.user_name,
    u.nick_name,
    u.dept_id,
    d.dept_name,
    r.role_name
FROM sys_user u
LEFT JOIN sys_dept d ON u.dept_id = d.dept_id
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE ur.role_id = 101;  -- 班委角色ID