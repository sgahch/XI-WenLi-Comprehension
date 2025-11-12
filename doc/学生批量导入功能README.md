# 学生批量导入功能 - 完整文档

## 📋 目录

- [功能概述](#功能概述)
- [快速开始](#快速开始)
- [文档索引](#文档索引)
- [核心功能](#核心功能)
- [技术实现](#技术实现)
- [测试指南](#测试指南)
- [常见问题](#常见问题)

---

## 功能概述

学生批量导入功能允许管理员通过导入Excel文件快速创建学生账户，适用于新学期开学时批量导入学生花名册的场景。

### 主要特性

✅ **智能部门匹配** - 根据"专业名称"+"班级"自动查找部门ID  
✅ **灵活角色分配** - 支持学生、班委（双角色）、辅导员  
✅ **自动档案创建** - 为学生和班委自动创建学生档案  
✅ **年级智能推断** - 从学号自动推断年级（如：2507240101 → 2025级）  
✅ **数据验证** - 必填字段检查、身份合法性验证、部门存在性验证  
✅ **更新模式** - 支持更新已存在的学生数据  
✅ **详细反馈** - 提供每条记录的导入结果详情  

### Excel模板字段（10列）

| 列 | 字段名 | 必填 | 说明 |
|----|--------|------|------|
| A | 专业名称 | ✓ | 如：软件工程、计算机科学与技术 |
| B | 班级 | ✓ | 如：2401、2402 |
| C | 姓名 | ✓ | 学生姓名 |
| D | 学号（或教职工号） | ✓ | 作为登录账号 |
| E | 手机号码 | - | 联系电话 |
| F | 用户性别 | - | 男/女/未知 |
| G | 身份 | ✓ | 学生/班委/辅导员 |
| H | 邮箱 | - | 电子邮箱 |
| I | 政治面貌 | - | 群众/团员/党员 |
| J | 入学日期 | - | YYYY-MM-DD格式 |

---

## 快速开始

### 1️⃣ 准备测试环境

执行SQL脚本创建必要的部门结构和角色配置：

```bash
mysql -u root -p your_database < doc/prepare_test_environment.sql
```

**脚本功能**:
- 创建部门结构（信息学院 → 专业 → 班级）
- 创建角色（学生、班委、辅导员）
- 配置初始密码（默认123456）
- 验证环境配置

### 2️⃣ 生成测试Excel文件

```bash
cd doc
python generate_test_excel.py
```

**生成文件**:
- ✅ `学生批量导入测试数据_正常.xlsx` - 10条正常数据
- ❌ `学生批量导入测试数据_验证失败.xlsx` - 6条错误数据
- ⚠️ `学生批量导入测试数据_部门不存在.xlsx` - 部门不存在测试
- 🔀 `学生批量导入测试数据_混合.xlsx` - 混合场景测试

### 3️⃣ 测试导入功能

**方式1: 使用Postman**

导入测试集合：`doc/学生批量导入API测试.postman_collection.json`

**方式2: 使用curl**

```bash
# 下载模板
curl -X POST "http://localhost:8080/evaluation/t_user_profile/importTemplate" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -o "学生批量导入模板.xlsx"

# 批量导入（新增模式）
curl -X POST "http://localhost:8080/evaluation/t_user_profile/importStudents" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "file=@学生批量导入测试数据_正常.xlsx" \
  -F "updateSupport=false"

# 批量导入（更新模式）
curl -X POST "http://localhost:8080/evaluation/t_user_profile/importStudents?updateSupport=true" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "file=@学生批量导入测试数据_正常.xlsx"
```

**方式3: 前端页面**

参考 `doc/前端集成指南.md` 集成到Vue前端。

---

## 文档索引

### 📚 完整文档列表

| 文档名称 | 说明 | 适用人员 |
|---------|------|---------|
| [学生批量导入测试数据.md](./学生批量导入测试数据.md) | 测试数据说明和测试步骤 | 测试人员 |
| [前端集成指南.md](./前端集成指南.md) | Vue前端集成完整指南 | 前端开发 |
| [学生批量导入测试报告模板.md](./学生批量导入测试报告模板.md) | 测试报告模板 | 测试人员 |
| [prepare_test_environment.sql](./prepare_test_environment.sql) | 测试环境准备SQL脚本 | 后端开发/测试 |
| [generate_test_excel.py](./generate_test_excel.py) | 测试Excel文件生成脚本 | 测试人员 |
| [学生批量导入API测试.postman_collection.json](./学生批量导入API测试.postman_collection.json) | Postman测试集合 | 测试人员/后端开发 |

### 🔧 代码文件列表

| 文件路径 | 说明 |
|---------|------|
| `ruoyi-system/src/main/java/com/ruoyi/system/domain/vo/StudentImportVO.java` | Excel导入VO实体类 |
| `ruoyi-admin/src/main/java/com/ruoyi/web/controller/evaluation/TUserProfileController.java` | 控制器（新增导入接口） |
| `ruoyi-system/src/main/java/com/ruoyi/system/service/ITUserProfileService.java` | 服务接口 |
| `ruoyi-system/src/main/java/com/ruoyi/system/service/impl/TUserProfileServiceImpl.java` | 服务实现（核心业务逻辑） |
| `ruoyi-system/src/main/java/com/ruoyi/system/mapper/TUserProfileMapper.java` | Mapper接口 |
| `ruoyi-system/src/main/resources/mapper/evaluation/TUserProfileMapper.xml` | Mapper XML |

---

## 核心功能

### 1. 智能部门匹配

**逻辑**:
```
专业名称 + 班级 → 查找部门树 → 返回班级部门ID
```

**示例**:
```
"软件工程" + "2401" → 查找部门树 → dept_id=500
```

**实现方法**: `findDeptIdByMajorAndClass()`

### 2. 身份角色映射

| 身份 | 角色ID | 说明 |
|------|--------|------|
| 学生 | 100 | 单角色 |
| 班委 | 100, 101 | 双角色（学生+班委） |
| 辅导员 | 102 | 单角色 |

**实现方法**: `mapIdentityToRoles()`

### 3. 学生档案创建

**规则**:
- ✅ 学生（role_id=100）→ 创建档案
- ✅ 班委（role_id=100,101）→ 创建档案
- ❌ 辅导员（role_id=102）→ 不创建档案

**档案信息**:
- `student_id`: 学号
- `college`, `major`, `class_name`: 从部门树解析
- `grade`: 从学号推断（如：2507240101 → 2025）
- `political_status`, `enrollment_date`: 从Excel读取

**实现方法**: `convertToUserProfile()`

### 4. 数据验证

**必填字段**:
- 学号
- 姓名
- 专业名称
- 班级
- 身份

**合法性验证**:
- 身份必须是：学生、班委、辅导员
- 部门必须存在

**实现方法**: `validateStudentData()`

### 5. 更新模式

**新增模式** (`updateSupport=false`):
- 学号已存在 → 跳过，提示"已存在"
- 学号不存在 → 创建新用户

**更新模式** (`updateSupport=true`):
- 学号已存在 → 更新用户信息和学生档案
- 学号不存在 → 创建新用户

---

## 技术实现

### 数据流程

```
Excel文件上传
    ↓
ExcelUtil解析 → StudentImportVO列表
    ↓
数据验证（validateStudentData）
    ↓
部门匹配（findDeptIdByMajorAndClass）
    ↓
角色分配（mapIdentityToRoles）
    ↓
转换实体（convertToSysUser + convertToUserProfile）
    ↓
创建/更新用户（userService.insertUser / updateUser）
    ↓
创建/更新学生档案（insert / update TUserProfile）
    ↓
返回导入结果
```

### 核心方法

#### 1. `importStudents()` - 主流程

```java
@Transactional(rollbackFor = Exception.class)
public String importStudents(List<StudentImportVO> studentList, Boolean updateSupport, String operName)
```

**功能**: 批量导入学生的主流程，包含事务管理。

#### 2. `validateStudentData()` - 数据验证

```java
private String validateStudentData(StudentImportVO student)
```

**功能**: 验证必填字段和数据合法性。

#### 3. `findDeptIdByMajorAndClass()` - 部门匹配

```java
private Long findDeptIdByMajorAndClass(String majorName, String className)
```

**功能**: 根据专业名称和班级查找部门ID。

#### 4. `mapIdentityToRoles()` - 角色映射

```java
private Long[] mapIdentityToRoles(String identity)
```

**功能**: 将身份字符串映射为角色ID数组。

#### 5. `convertToSysUser()` - 用户转换

```java
private SysUser convertToSysUser(StudentImportVO student, Long deptId, String operName)
```

**功能**: 将StudentImportVO转换为SysUser实体。

#### 6. `convertToUserProfile()` - 档案转换

```java
private TUserProfile convertToUserProfile(StudentImportVO student, Long userId, Long deptId)
```

**功能**: 将StudentImportVO转换为TUserProfile实体。

---

## 测试指南

### 测试环境准备

1. **执行SQL脚本**:
   ```bash
   mysql -u root -p your_database < doc/prepare_test_environment.sql
   ```

2. **验证部门结构**:
   ```sql
   SELECT d1.dept_name AS '学院', d2.dept_name AS '专业', d3.dept_name AS '班级'
   FROM sys_dept d1
   LEFT JOIN sys_dept d2 ON d2.parent_id = d1.dept_id
   LEFT JOIN sys_dept d3 ON d3.parent_id = d2.dept_id
   WHERE d1.dept_name = '信息学院';
   ```

3. **验证角色配置**:
   ```sql
   SELECT role_id, role_name, role_key FROM sys_role WHERE role_id IN (100, 101, 102);
   ```

### 测试用例

参考 `doc/学生批量导入测试报告模板.md` 执行以下测试：

- ✅ 测试用例1: 下载导入模板
- ✅ 测试用例2: 正常导入（新增模式）
- ✅ 测试用例3: 数据验证测试
- ✅ 测试用例4: 部门不存在测试
- ✅ 测试用例5: 更新模式测试
- ✅ 测试用例6: 混合场景测试
- ✅ 测试用例7: 角色分配验证
- ✅ 测试用例8: 学生档案创建验证
- ✅ 测试用例9: 权限控制测试
- ✅ 测试用例10: 性能测试

### 验证SQL

```sql
-- 验证用户创建
SELECT user_id, user_name, nick_name, dept_id FROM sys_user 
WHERE user_name LIKE '2507%' OR user_name LIKE 'T2024%';

-- 验证角色分配
SELECT u.user_name, GROUP_CONCAT(r.role_name) AS roles
FROM sys_user u
JOIN sys_user_role ur ON u.user_id = ur.user_id
JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_name LIKE '2507%' OR u.user_name LIKE 'T2024%'
GROUP BY u.user_name;

-- 验证学生档案
SELECT p.student_id, p.college, p.major, p.grade, p.class_name
FROM t_user_profile p
WHERE p.student_id LIKE '2507%';
```

---

## 常见问题

### Q1: 导入失败 - 未找到部门

**原因**: 数据库中不存在对应的专业或班级部门。

**解决**:
1. 执行 `prepare_test_environment.sql` 创建测试部门
2. 或在系统中手动创建对应的部门结构
3. 确保部门状态为正常（status=0）

### Q2: 导入失败 - 身份不合法

**原因**: 身份列填写了非法值。

**解决**: 确保身份列只填写：学生、班委、辅导员（区分大小写）。

### Q3: 导入成功但无法登录

**原因**: 密码未正确设置。

**解决**:
1. 检查 `sys_config` 表中的 `sys.user.initPassword` 配置
2. 默认密码为 `123456`
3. 使用"学号+密码"登录

### Q4: 辅导员没有创建学生档案

**说明**: 这是正常的，辅导员不需要学生档案。

**规则**: 只有身份为"学生"或"班委"的用户才会创建 `t_user_profile` 记录。

### Q5: 部分数据导入失败，其他数据是否会导入？

**答案**: 不会。使用了 `@Transactional` 事务管理，任何一条数据失败都会回滚所有操作。

**建议**: 修复错误数据后重新导入。

---

## 性能指标

| 数据量 | 预期耗时 | 说明 |
|--------|---------|------|
| 1-100条 | < 5秒 | 小批量导入 |
| 100-500条 | < 30秒 | 中批量导入 |
| 500-1000条 | < 60秒 | 大批量导入 |

**注意**: 实际性能取决于服务器配置和数据库性能。

---

## 联系支持

如有问题，请联系：
- 📧 Email: [your-email@example.com]
- 📱 Phone: [your-phone]
- 💬 Issue: [GitHub Issues链接]

---

## 更新日志

### v1.0 (2024-XX-XX)
- ✅ 初始版本发布
- ✅ 支持学生批量导入
- ✅ 智能部门匹配
- ✅ 灵活角色分配
- ✅ 完整的测试文档和工具

