<template>
  <div class="admin-dashboard">
    <!-- 顶部欢迎区 -->
    <div class="dashboard-header enhanced-card animate-fadeIn">
      <div class="header-content">
        <div class="welcome-info">
          <div class="avatar-section">
            <el-avatar :size="60" class="admin-avatar">
              <el-icon><UserFilled /></el-icon>
            </el-avatar>
            <div class="welcome-text">
              <h1 class="welcome-title">欢迎回来，管理员</h1>
              <p class="welcome-subtitle">
                今天是 {{ formatDate(new Date()) }}，{{ getGreeting() }}
              </p>
              <div class="status-info">
                <span class="status-dot online"></span>
                <span class="status-text">在线</span>
                <span class="last-login">上次登录：{{ lastLoginTime }}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="header-actions">
          <el-button
            type="primary"
            class="btn-gradient"
            size="large"
            @click="publishNotification"
          >
            <el-icon><Bell /></el-icon>
            发布通知
          </el-button>
          <el-button type="default" size="large" @click="exportData">
            <el-icon><Download /></el-icon>
            导出数据
          </el-button>
        </div>
      </div>
    </div>

    <!-- 统计卡片区域 -->
    <div class="stats-section">
      <el-row :gutter="24" class="stats-row">
        <el-col :xs="12" :sm="6" :md="6" :lg="6">
          <div
            class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-blue hover-lift"
          >
            <div class="stat-icon">
              <el-icon><User /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-number" :data-target="120">
                {{ animatedNumbers.students }}
              </div>
              <div class="stat-label">学生用户</div>
              <div class="stat-trend">
                <el-icon class="trend-up"><TrendCharts /></el-icon>
                <span>+12% 本月</span>
              </div>
            </div>
            <div class="stat-decoration"></div>
          </div>
        </el-col>

        <el-col :xs="12" :sm="6" :md="6" :lg="6">
          <div
            class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-success hover-lift"
          >
            <div class="stat-icon">
              <el-icon><CheckCircle /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-number" :data-target="45">
                {{ animatedNumbers.completed }}
              </div>
              <div class="stat-label">已完成测评</div>
              <div class="stat-trend">
                <el-icon class="trend-up"><TrendCharts /></el-icon>
                <span>+8% 本周</span>
              </div>
            </div>
            <div class="stat-decoration"></div>
          </div>
        </el-col>

        <el-col :xs="12" :sm="6" :md="6" :lg="6">
          <div
            class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-warning hover-lift"
          >
            <div class="stat-icon">
              <el-icon><Warning /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-number" :data-target="8">
                {{ animatedNumbers.appeals }}
              </div>
              <div class="stat-label">待处理申诉</div>
              <div class="stat-trend urgent">
                <el-icon class="trend-urgent"><Clock /></el-icon>
                <span>需要关注</span>
              </div>
            </div>
            <div class="stat-decoration"></div>
          </div>
        </el-col>

        <el-col :xs="12" :sm="6" :md="6" :lg="6">
          <div
            class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-purple hover-lift"
          >
            <div class="stat-icon">
              <el-icon><ChatDotSquare /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-number" :data-target="15">
                {{ animatedNumbers.notifications }}
              </div>
              <div class="stat-label">系统通知</div>
              <div class="stat-trend">
                <el-icon class="trend-stable"><Minus /></el-icon>
                <span>保持稳定</span>
              </div>
            </div>
            <div class="stat-decoration"></div>
          </div>
        </el-col>
      </el-row>
    </div>

    <!-- 主要内容区域 -->
    <div class="main-content">
      <el-row :gutter="24" class="content-row">
        <!-- 图表区域 -->
        <el-col :xs="24" :sm="24" :md="16" :lg="16">
          <el-card class="enhanced-card chart-card" shadow="hover">
            <template #header>
              <div class="card-header">
                <div class="header-left">
                  <h3 class="card-title">
                    <el-icon><TrendCharts /></el-icon>
                    学生人数趋势
                  </h3>
                  <p class="card-subtitle">过去6个月的数据统计</p>
                </div>
                <div class="header-actions">
                  <el-select
                    v-model="chartPeriod"
                    size="small"
                    style="width: 120px"
                  >
                    <el-option label="近7天" value="week" />
                    <el-option label="近30天" value="month" />
                    <el-option label="近6个月" value="halfYear" />
                  </el-select>
                </div>
              </div>
            </template>
            <div class="chart-container">
              <LineChart />
            </div>
          </el-card>
        </el-col>

        <!-- 通知和活动区域 -->
        <el-col :xs="24" :sm="24" :md="8" :lg="8">
          <div class="right-panel">
            <!-- 最新通知 -->
            <el-card class="enhanced-card notification-card" shadow="hover">
              <template #header>
                <div class="card-header">
                  <h3 class="card-title">
                    <el-icon><Bell /></el-icon>
                    最新通知
                  </h3>
                  <el-button
                    type="text"
                    size="small"
                    @click="viewAllNotifications"
                  >
                    查看全部
                  </el-button>
                </div>
              </template>
              <div class="notification-list">
                <div
                  v-for="(item, index) in notifications"
                  :key="index"
                  class="notification-item"
                  :class="{ unread: !item.read }"
                >
                  <div class="notification-icon">
                    <el-icon><Bell /></el-icon>
                  </div>
                  <div class="notification-content">
                    <div class="notification-title">{{ item.content }}</div>
                    <div class="notification-time">{{ item.time }}</div>
                  </div>
                  <div class="notification-actions">
                    <el-button type="text" size="small">标记已读</el-button>
                  </div>
                </div>
              </div>
            </el-card>

            <!-- 快速操作 -->
            <el-card class="enhanced-card quick-actions-card" shadow="hover">
              <template #header>
                <h3 class="card-title">
                  <el-icon><Operation /></el-icon>
                  快速操作
                </h3>
              </template>
              <div class="quick-actions">
                <div class="action-item" @click="addStudent">
                  <div class="action-icon gradient-blue">
                    <el-icon><UserFilled /></el-icon>
                  </div>
                  <span class="action-text">添加学生</span>
                </div>
                <div class="action-item" @click="createEvaluation">
                  <div class="action-icon gradient-success">
                    <el-icon><DocumentAdd /></el-icon>
                  </div>
                  <span class="action-text">创建测评</span>
                </div>
                <div class="action-item" @click="viewReports">
                  <div class="action-icon gradient-warning">
                    <el-icon><DataAnalysis /></el-icon>
                  </div>
                  <span class="action-text">查看报表</span>
                </div>
                <div class="action-item" @click="systemSettings">
                  <div class="action-icon gradient-purple">
                    <el-icon><Setting /></el-icon>
                  </div>
                  <span class="action-text">系统设置</span>
                </div>
              </div>
            </el-card>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
// 图标已全局注册，无需单独导入
import { ref, reactive, onMounted } from "vue";
import { ElMessage } from "element-plus";
import LineChart from "@/components/charts/LineChart.vue";

// 响应式数据
const chartPeriod = ref("month");
const lastLoginTime = ref("2024-03-15 08:30");

// 动画数字
const animatedNumbers = reactive({
  students: 0,
  completed: 0,
  appeals: 0,
  notifications: 0,
});

// 通知数据
const notifications = ref([
  {
    content: "新学期测评系统已开放，请通知学生及时填报",
    time: "2024-03-15 10:30",
    read: false,
  },
  {
    content: "请及时处理待审核的申诉，共8条待处理",
    time: "2024-03-15 09:15",
    read: false,
  },
  {
    content: "系统将于今晚22:00-24:00进行维护升级",
    time: "2024-03-14 18:00",
    read: true,
  },
  {
    content: "新增批量导入学生信息功能已上线",
    time: "2024-03-14 14:20",
    read: true,
  },
]);

// 工具函数
const formatDate = (date) => {
  return date.toLocaleDateString("zh-CN", {
    year: "numeric",
    month: "long",
    day: "numeric",
    weekday: "long",
  });
};

const getGreeting = () => {
  const hour = new Date().getHours();
  if (hour < 12) return "早上好！";
  if (hour < 18) return "下午好！";
  return "晚上好！";
};

// 数字动画函数
const animateNumber = (target, key, duration = 2000) => {
  const start = 0;
  const increment = target / (duration / 16);
  let current = start;

  const timer = setInterval(() => {
    current += increment;
    if (current >= target) {
      current = target;
      clearInterval(timer);
    }
    animatedNumbers[key] = Math.floor(current);
  }, 16);
};

// 事件处理方法
const publishNotification = () => {
  ElMessage.success("发布通知功能开发中...");
};

const exportData = () => {
  ElMessage.success("数据导出功能开发中...");
};

const viewAllNotifications = () => {
  ElMessage.info("查看全部通知功能开发中...");
};

const addStudent = () => {
  ElMessage.success("添加学生功能开发中...");
};

const createEvaluation = () => {
  ElMessage.success("创建测评功能开发中...");
};

const viewReports = () => {
  ElMessage.success("查看报表功能开发中...");
};

const systemSettings = () => {
  ElMessage.success("系统设置功能开发中...");
};

// 生命周期
onMounted(() => {
  // 启动数字动画
  setTimeout(() => animateNumber(120, "students"), 200);
  setTimeout(() => animateNumber(45, "completed"), 400);
  setTimeout(() => animateNumber(8, "appeals"), 600);
  setTimeout(() => animateNumber(15, "notifications"), 800);
});
</script>

<style scoped>
/* ===== 管理员Dashboard样式 ===== */

.admin-dashboard {
  padding: 24px;
  background: var(--bg-color);
  min-height: 100vh;
}

/* 顶部欢迎区域 */
.dashboard-header {
  margin-bottom: 32px;
  border-radius: 20px;
  overflow: hidden;
  background: var(--primary-gradient);
  color: white;
  position: relative;
}

.dashboard-header::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 20'%3E%3Cpath d='M0,10 Q25,0 50,10 T100,10 V20 H0 Z' fill='rgba(255,255,255,0.1)'/%3E%3C/svg%3E")
    repeat-x bottom;
  pointer-events: none;
}

.header-content {
  padding: 32px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  z-index: 2;
}

.welcome-info {
  flex: 1;
}

.avatar-section {
  display: flex;
  align-items: center;
  gap: 20px;
}

.admin-avatar {
  background: rgba(255, 255, 255, 0.2);
  border: 3px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
}

.welcome-text {
  flex: 1;
}

.welcome-title {
  margin: 0 0 8px 0;
  font-size: 32px;
  font-weight: 700;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.welcome-subtitle {
  margin: 0 0 12px 0;
  font-size: 16px;
  opacity: 0.9;
}

.status-info {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #67c23a;
  animation: pulse 2s infinite;
}

.status-dot.online {
  background: #67c23a;
}

@keyframes pulse {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
  100% {
    opacity: 1;
  }
}

.status-text {
  font-weight: 500;
}

.last-login {
  opacity: 0.8;
}

.header-actions {
  display: flex;
  gap: 16px;
}

.header-actions .el-button {
  border: 2px solid rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
}

.header-actions .el-button:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.5);
}

/* 统计卡片区域 */
.stats-section {
  margin-bottom: 32px;
}

.stats-row {
  margin: 0;
}

.stat-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  position: relative;
  overflow: hidden;
  border: 1px solid var(--border-light);
  transition: all var(--transition-base);
  cursor: pointer;
  display: flex;
  flex-direction: column;
}

.stat-card::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: var(--primary-gradient);
  transform: scaleX(0);
  transition: transform var(--transition-base);
}

.stat-card:hover::before {
  transform: scaleX(1);
}

.stat-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-hover);
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  color: white;
  margin-bottom: 16px;
  position: relative;
  overflow: hidden;
}

.stat-icon::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.2);
  transform: translateX(-100%);
  transition: transform 0.6s;
}

.stat-card:hover .stat-icon::before {
  transform: translateX(100%);
}

.gradient-blue .stat-icon {
  background: linear-gradient(135deg, #409eff 0%, #66b1ff 100%);
}

.gradient-success .stat-icon {
  background: linear-gradient(135deg, #67c23a 0%, #85ce61 100%);
}

.gradient-warning .stat-icon {
  background: linear-gradient(135deg, #e6a23c 0%, #ebb563 100%);
}

.gradient-purple .stat-icon {
  background: linear-gradient(135deg, #9c27b0 0%, #ba68c8 100%);
}

.stat-content {
  flex: 1;
}

.stat-number {
  font-size: 36px;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 8px;
  line-height: 1;
}

.stat-label {
  font-size: 14px;
  color: var(--text-regular);
  margin-bottom: 12px;
  font-weight: 500;
}

.stat-trend {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  font-weight: 500;
}

.trend-up {
  color: #67c23a;
}

.trend-stable {
  color: #909399;
}

.trend-urgent {
  color: #f56c6c;
}

.stat-trend.urgent {
  color: #f56c6c;
}

.stat-decoration {
  position: absolute;
  top: -20px;
  right: -20px;
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: rgba(64, 158, 255, 0.1);
  transform: scale(0);
  transition: transform var(--transition-base);
}

.stat-card:hover .stat-decoration {
  transform: scale(1);
}

/* 主要内容区域 */
.main-content {
  margin-top: 32px;
}

.content-row {
  margin: 0;
}

.chart-card {
  margin-bottom: 24px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 0;
}

.header-left {
  flex: 1;
}

.card-title {
  display: flex;
  align-items: center;
  gap: 8px;
  margin: 0 0 8px 0;
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
}

.card-subtitle {
  margin: 0;
  font-size: 14px;
  color: var(--text-regular);
}

.header-actions {
  display: flex;
  gap: 12px;
}

.chart-container {
  height: 300px;
  padding: 16px 0;
}

/* 右侧面板 */
.right-panel {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.notification-card {
  flex: 1;
}

.notification-list {
  max-height: 300px;
  overflow-y: auto;
}

.notification-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 16px 0;
  border-bottom: 1px solid var(--border-lighter);
  transition: all var(--transition-base);
}

.notification-item:last-child {
  border-bottom: none;
}

.notification-item:hover {
  background: var(--bg-color-light);
  margin: 0 -16px;
  padding: 16px;
  border-radius: 8px;
}

.notification-item.unread {
  background: rgba(64, 158, 255, 0.05);
}

.notification-icon {
  width: 32px;
  height: 32px;
  border-radius: 8px;
  background: var(--primary-color);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  flex-shrink: 0;
}

.notification-content {
  flex: 1;
  min-width: 0;
}

.notification-title {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
  margin-bottom: 4px;
  line-height: 1.4;
}

.notification-time {
  font-size: 12px;
  color: var(--text-placeholder);
}

.notification-actions {
  opacity: 0;
  transition: opacity var(--transition-base);
}

.notification-item:hover .notification-actions {
  opacity: 1;
}

/* 快速操作 */
.quick-actions-card {
  flex-shrink: 0;
}

.quick-actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  padding: 20px 16px;
  border-radius: 12px;
  background: var(--bg-color-light);
  border: 1px solid var(--border-lighter);
  cursor: pointer;
  transition: all var(--transition-base);
}

.action-item:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-light);
  border-color: var(--primary-color);
}

.action-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 20px;
}

.action-text {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
  text-align: center;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .header-content {
    flex-direction: column;
    gap: 24px;
    text-align: center;
  }

  .avatar-section {
    justify-content: center;
  }

  .header-actions {
    justify-content: center;
  }
}

@media (max-width: 768px) {
  .admin-dashboard {
    padding: 16px;
  }

  .header-content {
    padding: 24px 20px;
  }

  .welcome-title {
    font-size: 24px;
  }

  .stats-section .el-col {
    margin-bottom: 16px;
  }

  .quick-actions {
    grid-template-columns: 1fr;
  }

  .chart-container {
    height: 250px;
  }
}

@media (max-width: 480px) {
  .admin-dashboard {
    padding: 12px;
  }

  .stat-card {
    padding: 16px;
  }

  .stat-number {
    font-size: 28px;
  }

  .notification-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }
}
</style>
