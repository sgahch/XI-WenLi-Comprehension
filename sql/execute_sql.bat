@echo off
chcp 65001 >nul
echo ========================================
echo 执行课程成绩规则SQL脚本
echo ========================================
echo.
echo 请输入MySQL root密码：
mysql -u root -p ry-vue < add_college_id_to_rule_fixed.sql
echo.
echo ========================================
echo 执行完成！
echo ========================================
pause

