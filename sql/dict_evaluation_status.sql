-- =============================================
-- 综测状态字典配置
-- =============================================
-- 说明：为综合测评系统添加状态字典，用于显示填报状态
-- 创建时间：2025-11-03
-- =============================================

-- 1. 添加综测状态字典类型
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark) 
VALUES ('综测状态', 'evaluation_status', '0', 'admin', sysdate(), '综合测评填报状态');

-- 2. 添加综测状态字典数据
INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark) VALUES
(1, '草稿', '0', 'evaluation_status', '', 'info', 'N', '0', 'admin', sysdate(), '草稿状态'),
(2, '待班委审核', '1', 'evaluation_status', '', 'warning', 'N', '0', 'admin', sysdate(), '待班委审核'),
(3, '待辅导员审核', '2', 'evaluation_status', '', 'warning', 'N', '0', 'admin', sysdate(), '待辅导员审核'),
(4, '已通过', '3', 'evaluation_status', '', 'success', 'N', '0', 'admin', sysdate(), '审核通过'),
(5, '已驳回', '4', 'evaluation_status', '', 'danger', 'N', '0', 'admin', sysdate(), '审核驳回');

-- =============================================
-- 状态说明
-- =============================================
-- 0: 草稿 - 学生保存但未提交的填报记录
-- 1: 待班委审核 - 学生提交后，等待班委审核
-- 2: 待辅导员审核 - 班委审核通过后，等待辅导员审核
-- 3: 已通过 - 辅导员审核通过，填报完成
-- 4: 已驳回 - 班委或辅导员驳回，需要学生修改后重新提交
-- =============================================

