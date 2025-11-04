-- =============================================
-- 班委审核功能菜单配置 SQL
-- 版本: v1.2.0
-- 创建时间: 2025-11-02
-- 说明: 为班委角色添加专用的审核菜单和权限
-- =============================================

-- 1. 添加班委审核主菜单 (menu_id=2122)
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`,
    `update_by`,
    `remark`
) VALUES (
    2122,
    '班委审核',
    2100,
    3,
    'classCommitteeAudit',
    'evaluation-submit/classCommittee/audit',
    NULL,
    'ClassCommitteeAudit',
    1,
    0,
    'C',
    '0',
    '0',
    'evaluation:classCommittee:audit',
    'check',
    'admin',
    NOW(),
    '',
    '班委审核学生综测材料'
);

-- 2. 添加班委审核按钮权限 (menu_id=2140-2146)
-- 2.1 查询权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2140,
    '班委审核查询',
    2122,
    1,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:query',
    '#',
    'admin',
    NOW()
);

-- 2.2 审核通过权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2141,
    '班委审核通过',
    2122,
    2,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:approve',
    '#',
    'admin',
    NOW()
);

-- 2.3 审核驳回权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2142,
    '班委审核驳回',
    2122,
    3,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:reject',
    '#',
    'admin',
    NOW()
);

-- 2.4 批量审核权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2143,
    '班委批量审核',
    2122,
    4,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:batch',
    '#',
    'admin',
    NOW()
);

-- 2.5 查看详情权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2144,
    '班委查看详情',
    2122,
    5,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:detail',
    '#',
    'admin',
    NOW()
);

-- 2.6 查看成绩截图权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2145,
    '查看成绩截图',
    2122,
    6,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:viewScreenshot',
    '#',
    'admin',
    NOW()
);

-- 2.7 导出权限
INSERT INTO `sys_menu` (
    `menu_id`,
    `menu_name`,
    `parent_id`,
    `order_num`,
    `path`,
    `component`,
    `query`,
    `route_name`,
    `is_frame`,
    `is_cache`,
    `menu_type`,
    `visible`,
    `status`,
    `perms`,
    `icon`,
    `create_by`,
    `create_time`
) VALUES (
    2146,
    '班委审核导出',
    2122,
    7,
    '#',
    '',
    NULL,
    '',
    1,
    0,
    'F',
    '0',
    '0',
    'evaluation:classCommittee:export',
    '#',
    'admin',
    NOW()
);

-- 3. 为班委角色(role_id=101)分配菜单权限
-- 3.1 分配主菜单权限
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (101, 2122);

-- 3.2 分配按钮权限
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES 
(101, 2140), -- 查询
(101, 2141), -- 通过
(101, 2142), -- 驳回
(101, 2143), -- 批量审核
(101, 2144), -- 查看详情
(101, 2145), -- 查看成绩截图
(101, 2146); -- 导出

-- 4. 验证SQL (可选，用于检查)
-- SELECT menu_id, menu_name, parent_id, path, component, perms, menu_type 
-- FROM sys_menu 
-- WHERE menu_id BETWEEN 2122 AND 2146
-- ORDER BY menu_id;

-- 5. 验证角色菜单关联 (可选，用于检查)
-- SELECT rm.role_id, r.role_name, rm.menu_id, m.menu_name, m.perms
-- FROM sys_role_menu rm
-- LEFT JOIN sys_role r ON rm.role_id = r.role_id
-- LEFT JOIN sys_menu m ON rm.menu_id = m.menu_id
-- WHERE rm.role_id = 101 AND rm.menu_id BETWEEN 2122 AND 2146
-- ORDER BY rm.menu_id;

COMMIT;

