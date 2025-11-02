# 动态Excel导出方案说明

## 一、方案概述

### 1.1 核心特性

✅ **完全动态列生成** - 根据实际数据自动生成Excel列，无需预定义  
✅ **多维度支持** - 支持F1德育、F2智育、F3素质发展的所有动态项目  
✅ **样式还原** - 完美还原您提供的综测表样式(颜色区分、边框等)  
✅ **零配置** - 无需管理员上传模板，系统自动处理  
✅ **高性能** - 使用Apache POI直接生成，支持大数据量导出  

### 1.2 解决的问题

| 问题 | 传统方案 | 动态方案 |
|------|---------|---------|
| 不同学院课程不同 | ❌ 需要为每个学院配置模板 | ✅ 自动识别所有课程 |
| 学生参加的活动不同 | ❌ 固定列无法覆盖所有活动 | ✅ 动态添加所有活动列 |
| 新增竞赛项目 | ❌ 需要修改代码或模板 | ✅ 自动包含新项目 |
| 数据稀疏性 | ❌ 大量空列浪费空间 | ✅ 只显示有数据的列 |

---

## 二、技术架构

### 2.1 核心组件

```
┌─────────────────────────────────────────────────────────────┐
│                    DynamicExportController                   │
│                      (导出接口层)                             │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│            IDynamicEvaluationExportService                   │
│                    (业务逻辑层)                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 1. 数据查询 → 2. 动态列收集 → 3. Excel生成 → 4. 样式渲染 │   │
│  └──────────────────────────────────────────────────────┘   │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                   DynamicColumnData                          │
│                  (数据传输对象)                               │
│  • F1加分项/扣分项 (Map<String, BigDecimal>)                 │
│  • F2a课程成绩 (Map<String, BigDecimal>)                     │
│  • F2b竞赛项目 (Map<String, BigDecimal>)                     │
│  • F3体育/美育/劳育 (固定字段)                                │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 数据流程

```
数据库 evaluation_submission_detail
         ↓
解析 rule_snapshot (JSON)
         ↓
提取 itemName, dimensionType, score
         ↓
分类存储到 DynamicColumnData
         ↓
收集所有唯一的列名 (LinkedHashSet保证顺序)
         ↓
动态生成Excel表头
         ↓
按列名顺序填充数据
         ↓
应用样式(颜色、边框、字体)
         ↓
输出Excel文件
```

---

## 三、API接口说明

### 3.1 导出完整版综测数据

**接口地址**: `GET /evaluation/export/full`

**权限要求**: `evaluation:export:full`

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 | 示例 |
|--------|------|------|------|------|
| academicYear | String | 是 | 学年 | 2025-2026 |
| semester | Integer | 是 | 学期(1/2) | 1 |
| classId | Long | 是 | 班级ID | 200 |

**响应**: Excel文件流

**Excel结构**:
```
序号 | 姓名 | [F1德育区] | [F2a智育基础区] | [F2b智育奖励区] | [F3素质发展区] | [综测一览区]
```

**示例请求**:
```bash
curl -X GET "http://localhost:8080/evaluation/export/full?academicYear=2025-2026&semester=1&classId=200" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  --output 综测数据完整版.xlsx
```

---

### 3.2 导出汇总版综测数据

**接口地址**: `GET /evaluation/export/summary`

**权限要求**: `evaluation:export:summary`

**请求参数**: 同上

**响应**: Excel文件流

**Excel结构**:
```
排名 | 姓名 | 学号 | 班级 | 德育素质F1 | 智育素质F2 | 素质发展F3 | 综测合计
```

**特点**: 
- 仅包含汇总数据，不包含详细项目
- 按综测总分排名
- 适合快速查看和打印

---

### 3.3 导出学院综测数据

**接口地址**: `GET /evaluation/export/college`

**权限要求**: `evaluation:export:college`

**请求参数**:
| 参数名 | 类型 | 必填 | 说明 | 示例 |
|--------|------|------|------|------|
| academicYear | String | 是 | 学年 | 2025-2026 |
| semester | Integer | 是 | 学期(1/2) | 1 |
| collegeId | Long | 是 | 学院ID | 103 |

**响应**: Excel文件流(多Sheet)

**Excel结构**:
- 每个班级一个Sheet
- Sheet名称为班级名称
- 每个Sheet内容为该班级的完整版数据

---

## 四、动态列生成逻辑

### 4.1 F1德育素质测评

**动态列类型**:
1. **加分项** - 从所有学生的提交记录中收集
   - 示例: "班委学生会", "全勤", "荣誉称号"
2. **扣分项** - 从所有学生的提交记录中收集
   - 示例: "违反校规", "旷课"

**判断逻辑**:
```java
if (itemName.contains("违规") || itemName.contains("旷课") || itemName.contains("扣分")) {
    // 归类为扣分项
} else {
    // 归类为加分项
}
```

**Excel列顺序**:
```
基础分 | [动态加分项1] | [动态加分项2] | ... | 加分项总和 | [动态扣分项1] | [动态扣分项2] | ... | 扣分项总和 | F1总分
```

---

### 4.2 F2a智育基础分

**动态列类型**: 课程成绩

**识别逻辑**:
```java
if (dimensionType == 2 && !itemCode.contains("COMPETITION")) {
    // 归类为课程成绩
}
```

**示例课程**:
- 数据结构
- C语言课程设计
- 数字逻辑
- 大学英语
- 高等数学
- 概率论
- ...

**Excel列顺序**:
```
[课程1] | [课程2] | [课程3] | ... | 智育成绩 | F2a总分 | 班级排名
```

---

### 4.3 F2b智育奖励分

**动态列类型**: 竞赛项目

**识别逻辑**:
```java
if (dimensionType == 2 && itemCode.contains("COMPETITION")) {
    // 归类为竞赛项目
}
```

**示例竞赛**:
- 计算机设计大赛
- 天梯赛
- 普通话
- 蓝桥杯
- 数学建模
- 三创
- 软件创新大赛
- ...

**Excel列顺序**:
```
[竞赛1] | [竞赛2] | [竞赛3] | ... | F2b总分
```

---

### 4.4 F3素质发展测评

**列结构**: 固定列(非动态)

**Excel列顺序**:
```
体育成绩 | 体测 | 正向加分 | 反向减分 | 体育总分 | 
艺术教育 | 艺术实践 | 美育总分 | 
劳动教育 | 正向加分 | 反向减分 | 劳育总分 | 
F3总分
```

---

## 五、样式说明

### 5.1 颜色方案

| 区域 | 背景色 | 说明 |
|------|--------|------|
| 基本信息 | 灰色(GREY_25_PERCENT) | 序号、姓名 |
| F1德育 | 橙色(LIGHT_ORANGE) | 德育相关列 |
| F2a智育基础 | 绿色(LIGHT_GREEN) | 课程成绩列 |
| F2b智育奖励 | 橙色(LIGHT_ORANGE) | 竞赛项目列 |
| F3素质发展 | 蓝色(LIGHT_BLUE) | 体育/美育/劳育列 |
| 综测一览 | 灰色(GREY_25_PERCENT) | 汇总数据列 |

### 5.2 字体和边框

- **表头字体**: 11号加粗
- **数据字体**: 默认
- **边框**: 所有单元格四周细边框
- **对齐**: 居中对齐
- **数字格式**: 保留两位小数(0.00)

---

## 六、使用示例

### 6.1 前端调用示例(Vue)

```javascript
// 导出完整版
export function exportFullData(params) {
  return request({
    url: '/evaluation/export/full',
    method: 'get',
    params: params,
    responseType: 'blob'
  })
}

// 使用
exportFullData({
  academicYear: '2025-2026',
  semester: 1,
  classId: 200
}).then(response => {
  const blob = new Blob([response], { 
    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' 
  })
  const url = window.URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = '综测数据完整版.xlsx'
  a.click()
  window.URL.revokeObjectURL(url)
})
```

### 6.2 权限配置

在 `sys_menu` 表中添加菜单权限:

```sql
-- 导出完整版权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('导出完整版', 2100, 5, '', '', 1, 0, 'F', '0', '0', 'evaluation:export:full', '#', 'admin', NOW(), '', NULL, '');

-- 导出汇总版权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('导出汇总版', 2100, 6, '', '', 1, 0, 'F', '0', '0', 'evaluation:export:summary', '#', 'admin', NOW(), '', NULL, '');

-- 导出学院数据权限
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES ('导出学院数据', 2100, 7, '', '', 1, 0, 'F', '0', '0', 'evaluation:export:college', '#', 'admin', NOW(), '', NULL, '');
```

---

## 七、性能优化

### 7.1 数据量限制

- **单班级导出**: 建议 ≤ 200人
- **学院导出**: 建议 ≤ 10个班级
- **超大数据**: 考虑分批导出或异步导出

### 7.2 优化建议

1. **使用SXSSFWorkbook** - 对于超大数据量(>1000行)
2. **添加缓存** - 缓存动态列收集结果
3. **异步导出** - 使用消息队列处理导出任务
4. **分页导出** - 将大文件拆分为多个小文件

---

## 八、常见问题

### Q1: 如果某个学生没有参加某个活动,Excel中会显示什么?

**A**: 显示 `0.00`,使用 `getOrDefault(itemName, BigDecimal.ZERO)` 处理。

### Q2: 动态列的顺序是如何确定的?

**A**: 使用 `LinkedHashSet` 保证按首次出现的顺序排列。如果需要自定义顺序,可以在收集阶段进行排序。

### Q3: 如何处理不同学院的课程名称冲突?

**A**: 当前方案会合并同名课程。如需区分,可以在列名中加入学院前缀,例如 "计算机学院-数据结构"。

### Q4: 导出的Excel能否直接导入回系统?

**A**: 当前方案主要用于导出查看。如需导入功能,需要额外开发导入解析逻辑。

---

## 九、后续扩展

### 9.1 可扩展功能

- [ ] 支持自定义列顺序
- [ ] 支持列分组和合并单元格
- [ ] 支持图表嵌入
- [ ] 支持PDF格式导出
- [ ] 支持导出模板下载
- [ ] 支持批量导出(多个班级打包)

### 9.2 与模板方案对比

| 特性 | 动态生成方案 | 模板上传方案 |
|------|-------------|-------------|
| 灵活性 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 维护成本 | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| 实现难度 | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 性能 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 用户体验 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |

---

## 十、总结

✅ **完全满足您的需求** - 可以达到您综测表的动态效果  
✅ **零配置** - 无需管理员上传模板  
✅ **自动适应** - 自动识别所有课程和活动  
✅ **样式还原** - 完美还原您的表格样式  
✅ **易于维护** - 新增项目无需修改代码  

**推荐使用此方案!** 🎉

