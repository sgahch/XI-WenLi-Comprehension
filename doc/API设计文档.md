# 高校综合测评系统 - API设计文档

## 概述

本文档定义了高校综合测评系统重构后的核心API接口，基于"人、事、规"分离原则设计，支持学生填报、审核流程和规则管理等核心功能。

## 接口列表

### 1. 获取树状结构的计分规则

**接口描述：** 获取树状结构的计分规则，用于前端级联选择器

**URL：** `GET /evaluation/rule/tree`

**请求参数：**
```json
{
  "dimension": "intellectual",  // 可选，维度筛选：moral/intellectual/physical/aesthetic/labor
  "enabled": true              // 可选，是否只返回启用的规则，默认true
}
```

**成功响应示例：**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "dimension": "intellectual",
      "dimensionName": "智育",
      "categories": [
        {
          "category": "学科竞赛",
          "items": [
            {
              "itemName": "全国大学生数学建模竞赛",
              "levels": [
                {
                  "id": 1,
                  "level": "国家级一等奖",
                  "score": 15.00,
                  "requireAttachment": true,
                  "attachmentTypes": ["PDF", "JPG", "PNG"],
                  "description": "全国大学生数学建模竞赛国家级一等奖"
                },
                {
                  "id": 2,
                  "level": "国家级二等奖",
                  "score": 12.00,
                  "requireAttachment": true,
                  "attachmentTypes": ["PDF", "JPG", "PNG"],
                  "description": "全国大学生数学建模竞赛国家级二等奖"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

---

### 2. 创建或更新填报

**接口描述：** 创建或更新一次完整的填报，支持事务处理

**URL：** `POST /evaluation/submission`

**请求体：**
```json
{
  "id": null,                    // 可选，更新时传入ID
  "academicYear": "2024-2025",   // 必填，学年
  "semester": 1,                 // 必填，学期：1-第一学期，2-第二学期
  "classId": 200,                // 必填，班级ID
  "status": 0,                   // 必填，状态：0-草稿，1-待班委审核
  "remark": "本学期综合测评填报",  // 可选，备注
  "details": [                   // 必填，成果详情数组
    {
      "ruleId": 1,               // 必填，规则ID
      "finalScore": 15.00,       // 必填，得分
      "remark": "参加2024年全国大学生数学建模竞赛获得国家级一等奖", // 可选，学生备注
      "attachments": [           // 可选，附件数组
        {
          "fileName": "math_modeling_certificate.pdf",
          "originalName": "数学建模竞赛获奖证书.pdf",
          "filePath": "/uploads/evaluation/2024/09/math_modeling_certificate.pdf",
          "fileSize": 1024000,
          "fileType": "PDF",
          "url": "/api/file/download/math_modeling_certificate.pdf"
        }
      ]
    }
  ]
}
```

**成功响应示例：**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "id": 1,
    "studentId": 100,
    "academicYear": "2024-2025",
    "semester": 1,
    "classId": 200,
    "status": 0,
    "totalScore": 15.00,
    "moralScore": 0.00,
    "intellectualScore": 15.00,
    "physicalScore": 0.00,
    "aestheticScore": 0.00,
    "laborScore": 0.00,
    "submitTime": null,
    "auditTime": null,
    "createTime": "2025-01-27 10:30:00",
    "updateTime": "2025-01-27 10:30:00",
    "remark": "本学期综合测评填报"
  }
}
```

---

### 3. 获取审核列表

**接口描述：** 获取审核列表，供班委/辅导员使用，支持分页和条件查询

**URL：** `GET /evaluation/submission/list`

**请求参数：**
```json
{
  "pageNum": 1,                  // 页码，默认1
  "pageSize": 10,                // 每页大小，默认10
  "classId": 200,                // 可选，班级ID筛选
  "status": 1,                   // 可选，状态筛选：1-待班委审核，2-待辅导员审核
  "academicYear": "2024-2025",   // 可选，学年筛选
  "semester": 1,                 // 可选，学期筛选
  "studentName": "张三",          // 可选，学生姓名模糊查询
  "startTime": "2024-09-01",     // 可选，提交时间范围开始
  "endTime": "2024-12-31"        // 可选，提交时间范围结束
}
```

**成功响应示例：**
```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [
    {
      "id": 1,
      "studentId": 100,
      "studentName": "张三",
      "studentCode": "2021001001",
      "academicYear": "2024-2025",
      "semester": 1,
      "classId": 200,
      "className": "计算机科学与技术2021级1班",
      "status": 1,
      "statusName": "待班委审核",
      "totalScore": 15.00,
      "moralScore": 0.00,
      "intellectualScore": 15.00,
      "physicalScore": 0.00,
      "aestheticScore": 0.00,
      "laborScore": 0.00,
      "detailCount": 1,
      "approvedCount": 0,
      "rejectedCount": 0,
      "submitTime": "2025-01-27 10:30:00",
      "auditTime": null,
      "createTime": "2025-01-27 10:00:00",
      "updateTime": "2025-01-27 10:30:00"
    }
  ],
  "total": 1
}
```

---

### 4. 获取单个填报详情

**接口描述：** 获取单个填报的完整详情，包含所有成果和附件

**URL：** `GET /evaluation/submission/{id}`

**路径参数：**
- `id`: 填报ID

**成功响应示例：**
```json
{
  "code": 200,
  "msg": "查询成功",
  "data": {
    "id": 1,
    "studentId": 100,
    "studentName": "张三",
    "studentCode": "2021001001",
    "academicYear": "2024-2025",
    "semester": 1,
    "classId": 200,
    "className": "计算机科学与技术2021级1班",
    "status": 1,
    "statusName": "待班委审核",
    "totalScore": 15.00,
    "moralScore": 0.00,
    "intellectualScore": 15.00,
    "physicalScore": 0.00,
    "aestheticScore": 0.00,
    "laborScore": 0.00,
    "submitTime": "2025-01-27 10:30:00",
    "auditTime": null,
    "createTime": "2025-01-27 10:00:00",
    "updateTime": "2025-01-27 10:30:00",
    "remark": "本学期综合测评填报",
    "details": [
      {
        "id": 1,
        "submissionId": 1,
        "ruleId": 1,
        "ruleSnapshot": {
          "id": 1,
          "dimension": "intellectual",
          "category": "学科竞赛",
          "itemName": "全国大学生数学建模竞赛",
          "level": "国家级一等奖",
          "score": 15.00,
          "requireAttachment": true
        },
        "finalScore": 15.00,
        "remark": "参加2024年全国大学生数学建模竞赛获得国家级一等奖",
        "status": 0,
        "statusName": "待审核",
        "auditComment": null,
        "auditorId": null,
        "auditorName": null,
        "auditTime": null,
        "createTime": "2025-01-27 10:00:00",
        "updateTime": "2025-01-27 10:00:00",
        "attachments": [
          {
            "id": 1,
            "detailId": 1,
            "fileName": "math_modeling_certificate_20240901.pdf",
            "originalName": "数学建模竞赛获奖证书.pdf",
            "filePath": "/uploads/evaluation/2024/09/math_modeling_certificate_20240901.pdf",
            "fileSize": 1024000,
            "fileType": "PDF",
            "url": "/api/file/download/math_modeling_certificate_20240901.pdf",
            "uploadBy": "张三",
            "uploadTime": "2025-01-27 10:00:00"
          }
        ]
      }
    ],
    "auditLogs": [
      {
        "id": 1,
        "submissionId": 1,
        "detailId": null,
        "auditorId": 100,
        "auditorName": "张三",
        "operation": "SUBMIT",
        "operationName": "提交",
        "oldStatus": 0,
        "newStatus": 1,
        "remark": "学生提交填报申请",
        "auditTime": "2025-01-27 10:30:00",
        "ipAddress": "192.168.1.100"
      }
    ]
  }
}
```

---

### 5. 执行审核操作

**接口描述：** 执行审核操作（通过/驳回），记录审核日志

**URL：** `POST /evaluation/audit`

**请求体：**
```json
{
  "submissionId": 1,             // 可选，填报ID（整体审核时使用）
  "detailId": 1,                 // 可选，详情ID（单项审核时使用）
  "operation": "APPROVE",        // 必填，操作类型：APPROVE-通过，REJECT-驳回
  "remark": "材料齐全，符合要求，审核通过", // 可选，审核意见
  "batchDetailIds": [1, 2, 3]    // 可选，批量审核详情ID数组
}
```

**成功响应示例：**
```json
{
  "code": 200,
  "msg": "审核成功",
  "data": {
    "submissionId": 1,
    "detailId": 1,
    "operation": "APPROVE",
    "oldStatus": 0,
    "newStatus": 1,
    "auditTime": "2025-01-27 11:00:00",
    "auditorId": 102,
    "auditorName": "李老师",
    "remark": "材料齐全，符合要求，审核通过"
  }
}
```

## 错误响应格式

所有接口在发生错误时，统一返回以下格式：

```json
{
  "code": 400,
  "msg": "参数错误：学年不能为空",
  "data": null
}
```

## 状态码说明

### 填报状态 (evaluation_submission.status)
- `0`: 草稿
- `1`: 待班委审核
- `2`: 待辅导员审核
- `3`: 已通过
- `4`: 已驳回

### 详情审核状态 (evaluation_submission_detail.status)
- `0`: 待审核
- `1`: 已通过
- `2`: 已驳回

### 审核操作类型 (evaluation_audit_log.operation)
- `SUBMIT`: 提交
- `APPROVE`: 通过
- `REJECT`: 驳回

## 权限说明

### 学生权限
- 可以创建和更新自己的填报（草稿状态）
- 可以查看自己的填报详情
- 可以提交填报进入审核流程

### 班委权限
- 可以查看本班所有学生的填报列表
- 可以审核本班学生的填报（一级审核）
- 可以查看填报详情和审核日志

### 辅导员权限
- 可以查看所管理班级的所有填报
- 可以进行二级审核（班委审核通过后）
- 可以查看完整的审核流程和日志

### 管理员权限
- 可以管理计分规则
- 可以查看所有填报数据
- 可以进行系统配置和维护

## 接口调用示例

### 前端级联选择器数据加载
```javascript
// 获取智育维度的规则树
const response = await axios.get('/evaluation/rule/tree', {
  params: { dimension: 'intellectual' }
});

// 构建级联选择器数据
const cascaderOptions = response.data.data.map(dimension => ({
  value: dimension.dimension,
  label: dimension.dimensionName,
  children: dimension.categories.map(category => ({
    value: category.category,
    label: category.category,
    children: category.items.map(item => ({
      value: item.itemName,
      label: item.itemName,
      children: item.levels.map(level => ({
        value: level.id,
        label: `${level.level} (${level.score}分)`,
        score: level.score,
        requireAttachment: level.requireAttachment
      }))
    }))
  }))
}));
```

### 提交填报数据
```javascript
// 构建提交数据
const submissionData = {
  academicYear: '2024-2025',
  semester: 1,
  classId: 200,
  status: 1, // 提交审核
  details: this.achievements.map(achievement => ({
    ruleId: achievement.selectedRule.id,
    finalScore: achievement.selectedRule.score,
    remark: achievement.remark,
    attachments: achievement.attachments
  }))
};

// 提交数据
const response = await axios.post('/evaluation/submission', submissionData);
```

## 注意事项

1. **事务处理**: 创建/更新填报接口需要保证数据一致性，使用数据库事务
2. **文件上传**: 附件上传需要先调用文件上传接口，获得文件URL后再关联到成果
3. **规则快照**: 提交时需要保存规则快照，防止规则变更影响历史数据
4. **权限控制**: 所有接口都需要进行权限验证，确保数据安全
5. **数据校验**: 前端和后端都需要进行数据校验，确保数据完整性
6. **审核流程**: 审核操作需要记录完整的日志，支持审核轨迹追溯