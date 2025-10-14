<div align="center">

# 🎨 综合测评管理系统 - 前端

[![Vue](https://img.shields.io/badge/Vue-3.5.18-4FC08D.svg)](https://vuejs.org/)
[![Vite](https://img.shields.io/badge/Vite-7.1.2-646CFF.svg)](https://vitejs.dev/)
[![Element Plus](https://img.shields.io/badge/Element%20Plus-2.11.2-409EFF.svg)](https://element-plus.org/)
[![Pinia](https://img.shields.io/badge/Pinia-3.0.3-FFD859.svg)](https://pinia.vuejs.org/)
[![ECharts](https://img.shields.io/badge/ECharts-5.6.0-AA344D.svg)](https://echarts.apache.org/)

_现代化、响应式的大学生综合测评管理前端应用_

[功能特性](#-功能特性) • [快速开始](#-快速开始) • [技术架构](#-技术架构) • [项目结构](#-项目结构)

</div>

---

## 📋 目录

- [项目概述](#-项目概述)
- [功能特性](#-功能特性)
- [技术架构](#-技术架构)
- [项目结构](#-项目结构)
- [快速开始](#-快速开始)
- [开发指南](#-开发指南)
- [部署说明](#-部署说明)
- [常见问题](#-常见问题)

## 🎯 项目概述

综合测评管理系统前端是基于 **Vue 3 + Vite + Element Plus** 技术栈构建的现代化 Web 应用，为不同角色用户提供直观、高效的综合测评管理界面。

### 🌟 核心特色

- **🎨 现代化 UI**：基于 Element Plus 的精美界面设计
- **📱 响应式布局**：完美适配桌面端和移动端
- **⚡ 极速体验**：Vite 构建工具带来的闪电般开发体验
- **📊 数据可视化**：ECharts 图表库提供丰富的数据展示
- **🔄 状态管理**：Pinia 提供的现代化状态管理方案

## ✨ 功能特性

### 👨‍🎓 学生端功能

- **📊 个人仪表板**：直观展示个人测评数据和进度
- **📝 测评填报**：便捷的在线测评数据录入界面
- **📈 成绩查询**：实时查看个人成绩和排名情况
- **📢 申诉管理**：在线提交和跟踪申诉处理进度
- **📰 通知中心**：及时接收系统通知和重要公告

### 👨‍💼 管理员端功能

- **📊 数据仪表板**：全局数据概览和关键指标监控
- **👥 学生管理**：学生信息的增删改查和批量操作
- **⚙️ 系统配置**：测评体系、项目和规则的灵活配置
- **📥 数据管理**：支持批量导入导出和数据审核
- **📈 统计分析**：丰富的图表展示和多维度数据分析

### 👨‍💻 领导端功能

- **📊 决策驾驶舱**：高层数据概览和趋势分析
- **🔍 深度分析**：多维度数据挖掘和对比分析
- **📄 报表中心**：各类统计报表的生成和导出

## 🏗️ 技术架构

### 🎨 前端技术栈

```
Vue 3.5.18           # 渐进式JavaScript框架
├── Composition API  # Vue 3组合式API
├── <script setup>   # 语法糖简化开发
└── Reactivity API   # 响应式系统

Vite 7.1.2          # 下一代前端构建工具
├── HMR             # 热模块替换
├── ESBuild         # 极速构建
└── Rollup          # 生产环境打包

Element Plus 2.11.2  # Vue 3组件库
├── 60+ 组件        # 丰富的UI组件
├── 主题定制        # 灵活的主题系统
└── TypeScript      # 完整类型支持

状态管理 & 路由
├── Pinia 3.0.3     # 新一代状态管理
├── Vue Router 4.5.1 # 官方路由管理器
└── Axios 1.11.0    # HTTP客户端

数据可视化
├── ECharts 5.6.0   # 强大的图表库
└── Vue-ECharts 7.0.3 # Vue集成组件
```

## 📁 项目结构

```
frontend/
├── 📁 src/
│   ├── 📁 api/              # API接口定义
│   │   ├── 📄 index.js      # API统一导出
│   │   ├── 📄 user.js       # 用户相关接口
│   │   ├── 📄 admin.js      # 管理员接口
│   │   ├── 📄 evaluation.js # 测评相关接口
│   │   └── 📄 leader.js     # 领导端接口
│   ├── 📁 assets/           # 静态资源文件
│   │   ├── 📁 images/       # 图片资源
│   │   ├── 📁 icons/        # 图标资源
│   │   └── 📄 vue.svg       # Vue logo
│   ├── 📁 components/       # 公共组件
│   │   ├── 📁 charts/       # 图表组件
│   │   └── 📄 HelloWorld.vue # 示例组件
│   ├── 📁 router/           # 路由配置
│   │   └── 📄 index.js      # 路由定义
│   ├── 📁 store/            # 状态管理
│   │   └── 📄 index.js      # Pinia store
│   ├── 📁 utils/            # 工具函数
│   │   └── 📄 axios.js      # HTTP请求配置
│   ├── 📁 views/            # 页面组件
│   │   ├── 📁 admin/        # 管理员页面
│   │   ├── 📁 student/      # 学生页面
│   │   ├── 📁 leader/       # 领导页面
│   │   ├── 📁 shared/       # 共享页面
│   │   ├── 📄 Login.vue     # 登录页面
│   │   └── 📄 Home.vue      # 首页
│   ├── 📄 App.vue           # 应用根组件
│   ├── 📄 main.js           # 应用入口文件
│   └── 📄 style.css         # 全局样式文件
├── 📁 public/               # 静态资源目录
├── 📄 .env.development      # 开发环境配置
├── 📄 index.html            # HTML入口文件
├── 📄 package.json          # 项目依赖配置
├── 📄 vite.config.js        # Vite配置文件
└── 📄 README.md             # 项目说明文档
```

## 🚀 快速开始

### 📋 环境要求

| 工具         | 版本要求                 | 说明                    |
| ------------ | ------------------------ | ----------------------- |
| **Node.js**  | 16.0+                    | 推荐使用 18.0+ LTS 版本 |
| **包管理器** | npm 7.0+ / yarn 1.22+    | 推荐使用 npm            |
| **浏览器**   | Chrome 90+ / Firefox 88+ | 现代浏览器支持          |

### 🛠️ 安装步骤

#### 1️⃣ 克隆项目

```bash
git clone https://github.com/your-username/comprehensive_evaluation.git
cd comprehensive_evaluation/frontend
```

#### 2️⃣ 安装依赖

```bash
# 推荐使用 npm
npm install

# 或使用 yarn
yarn install

# 或使用 pnpm (更快的包管理器)
pnpm install
```

#### 3️⃣ 启动开发服务器

```bash
# 启动开发服务器
npm run dev

# 或使用 yarn
yarn dev
```

🎉 **成功启动！** 浏览器访问：http://localhost:5173

#### 4️⃣ 构建生产版本

```bash
# 构建生产版本
npm run build

# 预览构建结果
npm run preview
```

### 🔧 开发环境配置

#### 环境变量配置

创建 `.env.development` 文件：

```bash
# API 基础地址
VITE_API_BASE_URL=http://localhost:8080

# 应用标题
VITE_APP_TITLE=综合测评管理系统

# 是否启用 Mock 数据
VITE_USE_MOCK=false
```

#### 代理配置

`vite.config.js` 中的代理设置：

```javascript
export default defineConfig({
  server: {
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
    },
  },
});
```

## 📚 开发指南

### 🧩 组件开发规范

#### 📁 目录结构

- **公共组件**：`src/components/` - 可复用的业务组件
- **页面组件**：`src/views/` - 路由对应的页面组件
- **图表组件**：`src/components/charts/` - 数据可视化组件

#### 🎨 组件命名

```javascript
// 组件文件命名：PascalCase
UserProfile.vue
StudentDashboard.vue

// 组件注册：kebab-case 或 PascalCase
<user-profile />
<UserProfile />
```

#### 📝 组件模板

```vue
<template>
  <div class="component-name">
    <!-- 组件内容 -->
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";

// 组件逻辑
</script>

<style scoped>
.component-name {
  /* 组件样式 */
}
</style>
```

### 🔌 API 接口管理

#### 接口定义规范

```javascript
// src/api/user.js
import request from "@/utils/axios";

export const userAPI = {
  // 用户登录
  login: (data) => request.post("/auth/login", data),

  // 获取用户信息
  getUserInfo: () => request.get("/user/info"),

  // 更新用户信息
  updateUser: (data) => request.put("/user/update", data),
};
```

### 🛣️ 路由管理

#### 路由配置示例

```javascript
// src/router/index.js
const routes = [
  {
    path: "/student",
    component: () => import("@/layouts/StudentLayout.vue"),
    meta: { requiresAuth: true, role: "student" },
    children: [
      {
        path: "dashboard",
        component: () => import("@/views/student/Dashboard.vue"),
      },
    ],
  },
];
```

### 🗃️ 状态管理

#### Pinia Store 示例

```javascript
// src/store/user.js
import { defineStore } from "pinia";

export const useUserStore = defineStore("user", {
  state: () => ({
    userInfo: null,
    token: null,
  }),

  getters: {
    isLoggedIn: (state) => !!state.token,
  },

  actions: {
    login(userData) {
      this.userInfo = userData.user;
      this.token = userData.token;
    },
  },
});
```

## 📝 代码规范

### 🎯 Vue 3 最佳实践

- **优先使用 Composition API**：`<script setup>` 语法
- **响应式数据**：使用 `ref()` 和 `reactive()`
- **计算属性**：使用 `computed()` 处理派生状态
- **生命周期**：使用 `onMounted()` 等组合式生命周期

### 📏 命名规范

| 类型      | 规范             | 示例                        |
| --------- | ---------------- | --------------------------- |
| 组件文件  | PascalCase       | `UserProfile.vue`           |
| 变量/函数 | camelCase        | `userName`, `getUserInfo()` |
| 常量      | UPPER_SNAKE_CASE | `API_BASE_URL`              |
| CSS 类名  | kebab-case       | `.user-profile`             |

### 🎨 样式规范

```vue
<style scoped>
/* 使用 BEM 命名规范 */
.user-profile {
  /* 块 */
}

.user-profile__avatar {
  /* 元素 */
}

.user-profile--active {
  /* 修饰符 */
}
</style>
```

## 🚀 部署说明

### 📦 构建优化

```bash
# 分析构建包大小
npm run build -- --report

# 预渲染优化
npm run build:prerender
```

### 🌐 部署到 Nginx

```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost:8080;
    }
}
```

## ❓ 常见问题

<details>
<summary><strong>Q: 依赖安装失败怎么办？</strong></summary>

**A:** 尝试以下解决方案：

```bash
# 清除缓存
npm cache clean --force
rm -rf node_modules package-lock.json

# 重新安装
npm install

# 或使用 cnpm
npm install -g cnpm --registry=https://registry.npmmirror.com
cnpm install
```

</details>

<details>
<summary><strong>Q: 开发服务器启动失败？</strong></summary>

**A:** 检查以下几点：

1. Node.js 版本是否符合要求（16.0+）
2. 端口 5173 是否被占用
3. 检查 `vite.config.js` 配置是否正确

</details>

<details>
<summary><strong>Q: API 请求跨域问题？</strong></summary>

**A:** 解决方案：

1. 检查 `vite.config.js` 代理配置
2. 确保后端已配置 CORS
3. 开发环境使用代理，生产环境配置 Nginx

</details>

## 🤝 贡献指南

1. Fork 本仓库
2. 创建特性分支：`git checkout -b feature/amazing-feature`
3. 提交更改：`git commit -m 'Add amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 提交 Pull Request

---

<div align="center">

**⭐ 如果这个项目对您有帮助，请给我们一个 Star！⭐**

Made with ❤️ by Frontend Team

</div>
