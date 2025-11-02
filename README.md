<p align="center">
	<img alt="logo" src="https://oscimg.oschina.net/oscnet/up-d3d0a9303e11d522a06cd263f3079027715.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">西安文理学院学生综合素质测评管理系统</h1>
<h4 align="center">基于 RuoYi v3.9.0 + LangChain4j 的智能化测评管理平台</h4>
<p align="center">
	<img src="https://img.shields.io/badge/RuoYi-v3.9.0-brightgreen.svg" alt="RuoYi Version">
	<img src="https://img.shields.io/badge/Spring%20Boot-2.5.15-blue.svg" alt="Spring Boot">
	<img src="https://img.shields.io/badge/Vue-2.6.12-green.svg" alt="Vue">
	<img src="https://img.shields.io/badge/LangChain4j-1.0.0--beta3-orange.svg" alt="LangChain4j">
	<img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</p>

---

## 📋 项目简介

本系统是专为**西安文理学院**定制开发的学生综合素质测评管理平台，基于若依（RuoYi）框架深度定制，集成了 **LangChain4j AI 能力**，实现了传统教育管理与现代人工智能技术的完美融合。

### 🎯 核心特色

- 🏫 **专业定制**：针对高校综合测评业务深度优化
- 🤖 **AI 赋能**：集成阿里云通义千问大模型，提供智能对话辅助
- 📊 **双轨评分**：支持结构化评分 + 灵活加分的双轨制评分体系
- 🔐 **安全可靠**：基于 Spring Security + JWT 的企业级安全架构
- 📱 **响应式设计**：完美适配 PC、平板、手机等多种设备
- ⚡ **高性能**：Redis 缓存 + 数据库连接池优化，支持高并发访问

---

## 🏗️ 技术架构

### 后端技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| Spring Boot | 2.5.15 | 核心框架 |
| Spring Security | 5.7.14 | 安全框架 |
| MyBatis-Plus | 3.5.14 | ORM 框架 |
| **LangChain4j** | **1.0.0-beta3** | **AI 应用开发框架** |
| Redis | Latest | 缓存中间件 |
| JWT | 0.9.1 | 身份认证 |
| Druid | 1.2.23 | 数据库连接池 |
| Swagger | 3.0.0 | API 文档 |
| Quartz | Latest | 定时任务 |
| MySQL | 8.0+ | 数据库 |

### 前端技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| Vue | 2.6.12 | 前端框架 |
| Element UI | 2.15.14 | UI 组件库 |
| Axios | 0.28.1 | HTTP 客户端 |
| Vuex | 3.6.0 | 状态管理 |
| Vue Router | 3.4.9 | 路由管理 |
| ECharts | 5.4.0 | 数据可视化 |

### AI 能力集成

- **LangChain4j**：Java 版本的 LLM 应用开发框架
- **通义千问模型**：qwen-plus-2025-07-28
- **支持 15+ 种 LLM 提供商**：OpenAI、Anthropic、Google、Azure 等
- **前端 AI 组件**：可拖拽、可调整大小的智能聊天窗口

---

## ✨ 核心功能

### 👨‍🎓 学生端功能

- **个人仪表板**：实时展示个人测评数据和进度
- **测评填报**：在线提交测评材料和申请
- **加分申请**：提交竞赛获奖、论文发表等加分材料
- **成绩查询**：查看个人成绩、排名和详细分析
- **申诉管理**：在线提交申诉和跟踪处理进度
- **通知中心**：接收系统通知和重要公告
- **AI 助手**：智能问答、写作辅助、政策咨询

### 👨‍💼 管理员端功能

- **数据仪表板**：全局数据概览和关键指标监控
- **学生管理**：学生信息的增删改查和批量操作
- **测评配置**：
  - 测评体系配置（学期、学年设置）
  - 评分项目配置（思想品德、学习成绩等）
  - 加分规则配置（科技创新、社会实践等）
- **数据管理**：
  - 批量导入导出（Excel）
  - 成绩数据审核
  - 加分申请审核
- **统计分析**：
  - 多维度数据分析
  - 图表可视化展示
  - 报表生成导出
- **系统监控**：
  - 性能监控
  - 日志管理
  - 在线用户监控

### 👨‍💻 领导端功能

- **决策驾驶舱**：高层数据概览和趋势分析
- **深度分析**：多维度数据挖掘和对比分析
- **报表中心**：各类统计报表的生成和导出
- **政策制定支持**：基于数据的决策支持

### 🔧 系统管理功能（继承自若依框架）

1. **用户管理**：系统用户配置和权限分配
2. **部门管理**：组织机构树形结构管理
3. **岗位管理**：用户职务配置
4. **菜单管理**：系统菜单和按钮权限配置
5. **角色管理**：角色权限分配和数据权限控制
6. **字典管理**：系统字典数据维护
7. **参数管理**：系统参数动态配置
8. **通知公告**：系统公告发布和管理
9. **操作日志**：系统操作日志记录和查询
10. **登录日志**：登录日志和异常记录
11. **在线用户**：在线用户状态监控
12. **定时任务**：任务调度和执行日志
13. **代码生成**：前后端代码一键生成
14. **系统接口**：Swagger API 文档
15. **服务监控**：系统资源监控
16. **缓存监控**：Redis 缓存监控
17. **连接池监控**：数据库连接池监控

---

## 🤖 AI 智能助手

### 功能特性

- ✅ **智能对话**：基于通义千问大模型的自然语言交互
- ✅ **上下文记忆**：支持多轮对话，理解上下文语境
- ✅ **写作辅助**：帮助学生撰写总结、报告等文档
- ✅ **政策咨询**：解答测评相关政策和规则
- ✅ **可拖拽界面**：支持窗口拖拽和大小调整
- ✅ **打字机效果**：流畅的打字动画展示

### 技术实现

```java
// 后端：LangChain4j 配置
@Bean
public ChatLanguageModel chatLanguageModel() {
    return DashscopeOpenAiCompatibleChatModel.builder()
        .apiKey("your-api-key")
        .baseUrl("https://dashscope.aliyuncs.com/compatible-mode/v1")
        .modelName("qwen-plus-2025-07-28")
        .build();
}
```

```vue
<!-- 前端：AI 聊天组件 -->
<ai-chat />
```

---

## 📊 数据库设计亮点

### 双轨制评分体系

系统采用创新的**双轨制评分体系**，满足不同类型的测评需求：

#### 📌 体系 A：结构化评分（基于 `t_evaluation_item`）

**流程**：
```
t_evaluation_system (测评学期)
    ↓
t_evaluation_item (评分项目：思想品德、学习成绩等)
    ↓
t_student_score_detail (学生具体项目得分)
```

**特点**：
- 结构化、层级化
- 适合固定的、可量化的评分
- 由教务系统导入或管理员统一录入
- 所有学生都必须参与的基础分数

**应用场景**：各科成绩、学分绩点、出勤率等

#### 📌 体系 B：灵活加分（基于 `t_evaluation_rule`）

**流程**：
```
t_evaluation_rule (加分规则：科技创新、社会实践等)
    ↓
t_score_record (学生加分申请)
    ↓
t_audit_flow (审核流程)
```

**特点**：
- 灵活、非结构化
- 适合事件驱动的、非固定的加分项
- 由学生主动申请
- 需要经过审核流程

**应用场景**：竞赛获奖、论文发表、志愿服务、社会实践等

#### 🎯 最终汇总

在计算学期总分时（写入 `t_student_total_score`），系统会自动从两个体系汇总：
- 体系 A 的基础分数（`t_student_score_detail`）
- 体系 B 的加分项（`t_score_record`）

### 数据库规范

- ✅ **统一用户模型**：全面采用若依框架的 `sys_user` 表
- ✅ **主键规范**：所有表主键统一使用 `BIGINT AUTO_INCREMENT`
- ✅ **外键规范**：业务表外键统一指向 `sys_user.user_id`
- ✅ **命名规范**：业务表使用 `t_` 前缀，与系统表逻辑隔离

---

## 🚀 快速开始

### 环境要求

- **JDK**：1.8+
- **Maven**：3.6+
- **MySQL**：8.0+
- **Redis**：Latest
- **Node.js**：8.9+
- **npm**：3.0+

### 后端启动

```bash
# 1. 克隆项目
git clone <repository-url>

# 2. 导入数据库
# 执行 sql/ry-vue.sql 创建基础表
# 执行 sql/evaluation_schema.sql 创建业务表

# 3. 修改配置
# 编辑 ruoyi-admin/src/main/resources/application.yml
# 配置数据库连接、Redis 连接、通义千问 API Key

# 4. 编译打包
mvn clean install

# 5. 启动后端
cd ruoyi-admin
mvn spring-boot:run

# 后端服务运行在 http://localhost:8080
```

### 前端启动

```bash
# 1. 进入前端目录
cd ruoyi-ui

# 2. 安装依赖
npm install

# 3. 启动开发服务器
npm run dev

# 前端服务运行在 http://localhost:80
```

### 配置说明

#### 数据库配置（`application-druid.yml`）

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/ry-vue?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8
    username: root
    password: your_password
```

#### Redis 配置（`application.yml`）

```yaml
spring:
  redis:
    host: localhost
    port: 6379
    password: your_password
    database: 0
```

#### LangChain4j 配置（`application.yml`）

```yaml
langchain4j:
  community:
    dashscope:
      chat-model:
        api-key: your-dashscope-api-key
        model-name: qwen-plus-2025-07-28
        log-request: true
        log-responses: true
```

> 💡 **提示**：通义千问 API Key 可在 [阿里云百炼平台](https://bailian.console.aliyun.com/) 获取

---

## 📁 项目结构

```
RuoYi-Vue/
├── ruoyi-admin/          # 主启动模块（包含 AI 控制器）
├── ruoyi-framework/      # 框架核心（包含 LangChain4j 配置）
├── ruoyi-system/         # 系统模块（用户、角色、权限等）
├── ruoyi-common/         # 通用工具（包含 AI 配置类）
├── ruoyi-generator/      # 代码生成器
├── ruoyi-quartz/         # 定时任务
├── ruoyi-ui/             # 前端项目
│   ├── src/
│   │   ├── api/          # API 接口定义
│   │   ├── components/   # 公共组件
│   │   │   └── AiChat/   # AI 聊天组件 ⭐
│   │   ├── views/        # 页面组件
│   │   ├── router/       # 路由配置
│   │   ├── store/        # 状态管理
│   │   └── utils/        # 工具函数
├── langchain4j/          # LangChain4j 框架源码（集成）
├── sql/                  # 数据库脚本
│   ├── ry-vue.sql        # 基础表结构
│   └── evaluation_schema.sql  # 业务表结构
└── doc/                  # 项目文档
```

---

## 🔧 开发指南

### 代码生成器使用

1. 访问 `系统工具 -> 代码生成`
2. 选择要生成的数据表
3. 点击"生成代码"下载代码包
4. 将代码解压到对应模块目录

### API 文档

启动项目后访问：`http://localhost:8080/swagger-ui/index.html`

### 默认账号

- **管理员**：admin / admin123
- **学生**：student / student123
- **教师**：teacher / teacher123

---

## 📝 许可证

本项目基于 [MIT License](LICENSE) 开源协议。

---

## 🙏 致谢

- 感谢 [若依（RuoYi）](https://gitee.com/y_project/RuoYi-Vue) 提供的优秀开源框架
- 感谢 [LangChain4j](https://github.com/langchain4j/langchain4j) 提供的 AI 开发框架
- 感谢阿里云通义千问团队提供的大模型服务

---

## 📞 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 📧 Email: your-email@example.com
- 🐛 Issues: [GitHub Issues](your-github-repo/issues)

---

<p align="center">
  <b>⭐ 如果这个项目对您有帮助，请给我们一个 Star！⭐</b>
</p>

