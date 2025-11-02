/*
  变更说明：为详情表 evaluation_submission_detail 增加 rule_snapshot 列（JSON，非空）
  背景：服务层会在保存详情时写入规则快照，防止规则变更影响历史记录；若现网库缺失该列，会导致入库失败。
  安全性：使用 IF NOT EXISTS 防止重复添加；并为历史空值填充空JSON再收紧为 NOT NULL。
*/

START TRANSACTION;

-- 1) 添加列（若不存在），暂时允许为 NULL，便于初始化历史数据
ALTER TABLE `evaluation_submission_detail`
  ADD COLUMN IF NOT EXISTS `rule_snapshot` JSON NULL COMMENT '规则快照，JSON格式，冗余保存规则信息防止规则变更影响历史';

-- 2) 将历史记录中的 NULL 值初始化为空JSON对象
UPDATE `evaluation_submission_detail`
  SET `rule_snapshot` = JSON_OBJECT()
  WHERE `rule_snapshot` IS NULL;

-- 3) 收紧为非空约束
ALTER TABLE `evaluation_submission_detail`
  MODIFY COLUMN `rule_snapshot` JSON NOT NULL COMMENT '规则快照，JSON格式，冗余保存规则信息防止规则变更影响历史';

COMMIT;

/*
执行顺序建议：
1. 先在测试环境执行本脚本，确认现有数据初始化无误；
2. 再在生产环境执行，并做好备份；
*/