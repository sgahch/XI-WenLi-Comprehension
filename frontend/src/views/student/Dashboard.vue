<template>
  <div class="student-dashboard">
    <!-- 欢迎区域 -->
    <div class="welcome-header enhanced-card animate-fadeIn">
      <div class="header-content">
        <div class="student-info">
          <div class="avatar-section">
            <el-avatar 
              :size="80" 
              class="student-avatar"
              :src="userAvatar"
              @error="handleAvatarError"
            >
              <el-icon v-if="!userAvatar"><User /></el-icon>
            </el-avatar>
            <div class="avatar-upload" @click="showAvatarUpload">
              <el-icon><Camera /></el-icon>
            </div>
            <div class="info-text">
              <h1 class="welcome-title">欢迎回来，{{ userName }}同学！</h1>
              <p class="welcome-subtitle">{{ welcomeMessage }}</p>
              <div class="student-details">
                <div class="detail-item">
                  <el-icon><CreditCard /></el-icon>
                  <span>学号：{{ studentInfo.studentId || '加载中...' }}</span>
                </div>
                <div class="detail-item">
                  <el-icon><School /></el-icon>
                  <span>班级：{{ studentInfo.className || '加载中...' }}</span>
                </div>
                <div class="detail-item">
                  <el-icon><Calendar /></el-icon>
                  <span>{{ formatCurrentDate() }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="header-actions">
          <el-button
            type="primary"
            class="btn-gradient"
            size="large"
            @click="goToEvaluation"
          >
            <el-icon><DocumentAdd /></el-icon>
            开始测评填报
          </el-button>
          <el-button type="default" size="large" @click="goToScoreQuery">
            <el-icon><DataAnalysis /></el-icon>
            查看我的成绩
          </el-button>
        </div>
      </div>
    </div>

    <!-- 数据概览 -->
    <div class="stats-section" v-loading="loading.stats">
      <div class="stats-container">
        <div
          class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-success hover-lift"
        >
          <div class="stat-icon">
            <el-icon><DocumentChecked /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number" :data-target="dashboardStats.completedEvaluations || 0">
              {{ animatedNumbers.completed }}
            </div>
            <div class="stat-label">已完成测评</div>
            <div class="stat-trend">
              <el-icon class="trend-up"><TrendCharts /></el-icon>
              <span>完成率 {{ dashboardStats.completionRate || 0 }}%</span>
            </div>
          </div>
          <div class="stat-decoration"></div>
        </div>

        <div
          class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-warning hover-lift"
        >
          <div class="stat-icon">
            <el-icon><Clock /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number" :data-target="dashboardStats.pendingEvaluations || 0">
              {{ animatedNumbers.pending }}
            </div>
            <div class="stat-label">待完成测评</div>
            <div class="stat-trend urgent">
              <el-icon class="trend-urgent"><Warning /></el-icon>
              <span>{{ dashboardStats.urgentCount || 0 }} 项紧急</span>
            </div>
          </div>
          <div class="stat-decoration"></div>
        </div>

        <div
          class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-primary hover-lift"
        >
          <div class="stat-icon">
            <el-icon><Star /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number" :data-target="dashboardStats.currentScore || 0">
              {{ animatedNumbers.score }}
            </div>
            <div class="stat-label">当前综测分数</div>
            <div class="stat-trend">
              <el-icon class="trend-up"><Trophy /></el-icon>
              <span>较上月 +{{ dashboardStats.scoreIncrease || 0 }}</span>
            </div>
          </div>
          <div class="stat-decoration"></div>
        </div>

        <div
          class="stat-card enhanced-card card-interactive animate-slideInLeft gradient-info hover-lift"
        >
          <div class="stat-icon">
            <el-icon><Bell /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number" :data-target="dashboardStats.unreadNotifications || 0">
              {{ animatedNumbers.notifications }}
            </div>
            <div class="stat-label">未读通知</div>
            <div class="stat-trend">
              <el-icon class="trend-stable"><Message /></el-icon>
              <span>系统消息</span>
            </div>
          </div>
          <div class="stat-decoration"></div>
        </div>
      </div>
    </div>

    <!-- 主要内容区 -->
    <div class="main-content">
      <!-- 待办事项 -->
      <el-card class="todo-card">
        <template #header>
          <div class="card-header">
            <span>待办事项</span>
            <el-button type="text" size="small" @click="viewAllTodos"
              >查看全部</el-button
            >
          </div>
        </template>
        <div v-if="todos.length > 0" class="todo-list" v-loading="loading.todos">
          <div
            v-for="todo in todos.slice(0, 3)"
            :key="todo.id"
            class="todo-item"
          >
            <div class="todo-content">
              <div class="todo-title">{{ todo.title }}</div>
              <div class="todo-meta">
                <span class="todo-status" :class="todo.status">{{
                  getStatusText(todo.status)
                }}</span>
                <span class="todo-deadline">{{
                  formatDate(todo.deadline)
                }}</span>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="no-data">暂无待办事项</div>
      </el-card>

      <!-- 成绩趋势 -->
      <el-card class="score-trend-card">
        <template #header>
          <div class="card-header">
            <span>成绩趋势</span>
            <el-select
              v-model="selectedSemester"
              placeholder="选择学期"
              size="small"
              style="width: 120px"
            >
              <el-option label="全部学期" value="all"></el-option>
              <el-option label="2023-2024春季" value="2024-spring"></el-option>
              <el-option label="2023-2024秋季" value="2023-autumn"></el-option>
              <el-option label="2022-2023春季" value="2023-spring"></el-option>
            </el-select>
          </div>
        </template>
        <div class="chart-container">
          <div ref="scoreTrendChart" class="score-trend-chart"></div>
        </div>
      </el-card>
    </div>

    <!-- 最新通知 -->
    <el-card class="notifications-card">
      <template #header>
        <div class="card-header">
          <span>最新通知</span>
          <el-button type="text" size="small" @click="viewAllNotifications"
            >查看全部</el-button
          >
        </div>
      </template>
      <div v-if="notifications.length > 0" class="notification-list" v-loading="loading.notifications">
        <div
          v-for="notification in notifications.slice(0, 5)"
          :key="notification.id"
          class="notification-item"
        >
          <div class="notification-content">
            <div class="notification-title">{{ notification.title }}</div>
            <div class="notification-time">
              {{ formatTime(notification.timestamp) }}
            </div>
          </div>
          <el-button
            v-if="!notification.read"
            type="text"
            size="small"
            class="read-btn"
            >标记已读</el-button
          >
        </div>
      </div>
      <div v-else class="no-data">暂无通知</div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, nextTick } from "vue";
import { useRouter } from "vue-router";
import { useUserStore } from "../../store";
import { ElMessage, ElMessageBox } from "element-plus";
import { studentAPI } from "@/api/student.js";
import { userAPI } from "@/api/user.js";
// 图标已全局注册，无需单独导入
import * as echarts from "echarts";
import {
  Bell,
  Calendar,
  Camera,
  Clock,
  CreditCard, DataAnalysis, DocumentAdd,
  DocumentChecked, Message,
  School, Star,
  TrendCharts, Trophy,
  User,
  Warning
} from "@element-plus/icons-vue";

const router = useRouter();
const userStore = useUserStore();

// 用户信息
const userName = computed(() => {
  const userInfo = userStore.getUserInfo;
  return userInfo ? userInfo.name || userInfo.realName || userInfo.username : "加载中...";
});

// 学生信息
const studentInfo = ref({
  studentId: '',
  className: '',
  college: '',
  major: ''
});

// 统计数据
const dashboardStats = ref({
  completedEvaluations: 0,
  pendingEvaluations: 0,
  currentScore: 0,
  unreadNotifications: 0,
  completionRate: 0,
  urgentCount: 0,
  scoreIncrease: 0
});

// 用户头像
const userAvatar = ref('');

// 加载状态
const loading = ref({
  studentInfo: false,
  stats: false,
  todos: false,
  notifications: false
});

// 动画数字
const animatedNumbers = ref({
  completed: 0,
  pending: 0,
  score: 0,
  notifications: 0,
});

// 欢迎消息
const welcomeMessage = computed(() => {
  const hour = new Date().getHours();
  if (hour < 12) return "祝您上午学习愉快！";
  if (hour < 18) return "祝您下午学习愉快！";
  return "祝您晚上学习愉快！";
});

// 待办事项
const todos = ref([]);

// 通知列表
const notifications = ref([]);

// 工具函数
const formatCurrentDate = () => {
  return new Date().toLocaleDateString("zh-CN", {
    year: "numeric",
    month: "long",
    day: "numeric",
    weekday: "long",
  });
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
    animatedNumbers.value[key] = Math.floor(current);
  }, 16);
};

// 加载学生信息（使用用户接口）
const loadStudentInfo = async () => {
  try {
    loading.value.studentInfo = true;
    const response = await userAPI.getUserInfo();
    studentInfo.value = {
      studentId: response.studentId || '未设置',
      className: response.className || '未设置',
      college: response.college || '未设置',
      major: response.major || '未设置'
    };

    userAvatar.value = response.avatar || ''; // 使用用户头像
  } catch (error) {
    console.error('加载学生信息失败:', error);
    ElMessage.error('加载学生信息失败');
  } finally {
    loading.value.studentInfo = false;
  }
};

// 加载统计数据（使用用户接口）
const loadDashboardStats = async () => {
  try {
    loading.value.stats = true;
    const response = await userAPI.getDashboardStats();
    dashboardStats.value = {
      completedEvaluations: response.completedEvaluations || 0,
      pendingEvaluations: response.pendingEvaluations || 0,
      currentScore: response.currentScore || 0,
      unreadNotifications: response.unreadNotifications || 0,
      completionRate: response.completionRate || 0,
      urgentCount: response.urgentCount || 0,
      scoreIncrease: response.scoreIncrease || 0
    };
    
    // 启动数字动画
    setTimeout(() => animateNumber(dashboardStats.value.completedEvaluations, "completed"), 200);
    setTimeout(() => animateNumber(dashboardStats.value.pendingEvaluations, "pending"), 400);
    setTimeout(() => animateNumber(dashboardStats.value.currentScore, "score"), 600);
    setTimeout(() => animateNumber(dashboardStats.value.unreadNotifications, "notifications"), 800);
  } catch (error) {
    console.error('加载统计数据失败:', error);
    ElMessage.error('加载统计数据失败');
  } finally {
    loading.value.stats = false;
  }
};

// 加载待办事项（使用用户接口）
const loadTodos = async () => {
  try {
    loading.value.todos = true;
    const response = await userAPI.getTodos();
    todos.value = response || [];
  } catch (error) {
    console.error('加载待办事项失败:', error);
    // 使用默认数据
    todos.value = [
      {
        id: 1,
        title: "2024年春季学期综合测评填报",
        status: "pending",
        deadline: new Date("2024-06-30").toISOString(),
      },
      {
        id: 2,
        title: "上传社会实践证明材料",
        status: "pending",
        deadline: new Date("2024-06-15").toISOString(),
      }
    ];
  } finally {
    loading.value.todos = false;
  }
};

// 加载通知列表（使用用户接口）
const loadNotifications = async () => {
  try {
    loading.value.notifications = true;
    const response = await userAPI.getNotifications({ limit: 5 });
    notifications.value = response || [];
  } catch (error) {
    console.error('加载通知列表失败:', error);
    // 使用默认数据
    notifications.value = [
      {
        id: 1,
        title: "2024年春季学期综合测评开始啦，请及时完成填报",
        timestamp: new Date().toISOString(),
        read: false,
      },
      {
        id: 2,
        title: "系统将于本周六进行维护升级，请提前安排工作",
        timestamp: new Date(Date.now() - 86400000).toISOString(),
        read: false,
      }
    ];
  } finally {
    loading.value.notifications = false;
  }
};

// 处理头像错误
const handleAvatarError = () => {
  userAvatar.value = '';
};

// 显示头像上传对话框
const showAvatarUpload = () => {
  ElMessageBox.alert('头像上传功能即将上线，请稍后再试！', '提示', {
    confirmButtonText: '知道了'
  });
};

// 选中的学期
const selectedSemester = ref("all");

// 成绩趋势图表
const scoreTrendChart = ref(null);
let chartInstance = null;

// 跳转到测评填报页面
const goToEvaluation = () => {
  router.push("/student/evaluation-application");
};

// 跳转到成绩查询页面
const goToScoreQuery = () => {
  router.push("/student/score-query");
};

// 查看全部待办事项
const viewAllTodos = () => {
  // 这里可以跳转到待办事项列表页面
  ElMessage.info("查看全部待办事项");
};

// 查看全部通知
const viewAllNotifications = () => {
  router.push("/notifications");
};

// 获取状态文本
const getStatusText = (status) => {
  const statusMap = {
    pending: "待处理",
    inProgress: "进行中",
    completed: "已完成",
  };
  return statusMap[status] || status;
};

// 格式化日期
const formatDate = (dateString) => {
  const date = new Date(dateString);
  return date.toLocaleDateString("zh-CN");
};

// 格式化时间
const formatTime = (timestamp) => {
  const now = new Date();
  const time = new Date(timestamp);
  const diff = now - time;

  if (diff < 60000) {
    return "刚刚";
  } else if (diff < 3600000) {
    return Math.floor(diff / 60000) + "分钟前";
  } else if (diff < 86400000) {
    return Math.floor(diff / 3600000) + "小时前";
  } else if (diff < 604800000) {
    return Math.floor(diff / 86400000) + "天前";
  } else {
    return time.toLocaleDateString("zh-CN");
  }
};

// 初始化成绩趋势图表
const initScoreTrendChart = async () => {
  await nextTick();

  if (!scoreTrendChart.value) return;

  // 销毁已存在的图表实例
  if (chartInstance) {
    chartInstance.dispose();
  }

  // 创建新的图表实例
  chartInstance = echarts.init(scoreTrendChart.value);

  // 图表配置
  const option = {
    tooltip: {
      trigger: "axis",
      axisPointer: {
        type: "cross",
        label: {
          backgroundColor: "#6a7985",
        },
      },
    },
    grid: {
      left: "3%",
      right: "4%",
      bottom: "3%",
      containLabel: true,
    },
    xAxis: [
      {
        type: "category",
        boundaryGap: false,
        data: [
          "2022-2023春季",
          "2022-2023秋季",
          "2023-2024春季",
          "2023-2024秋季",
        ],
        axisLabel: {
          rotate: 30,
        },
      },
    ],
    yAxis: [
      {
        type: "value",
        min: 60,
        max: 100,
      },
    ],
    series: [
      {
        name: "综测分数",
        type: "line",
        stack: "Total",
        areaStyle: {
          opacity: 0.3,
        },
        emphasis: {
          focus: "series",
        },
        data: [82, 85, 87, 89.5],
        lineStyle: {
          width: 3,
          color: "#409EFF",
        },
        itemStyle: {
          color: "#409EFF",
        },
      },
    ],
  };

  // 设置图表配置
  chartInstance.setOption(option);

  // 监听窗口大小变化，重新调整图表大小
  const handleResize = () => {
    if (chartInstance) {
      chartInstance.resize();
    }
  };

  window.addEventListener("resize", handleResize);

  // 组件卸载时清理事件监听
  onUnmounted(() => {
    window.removeEventListener("resize", handleResize);
    if (chartInstance) {
      chartInstance.dispose();
    }
  });
};

// 页面挂载时初始化图表和数据
onMounted(async () => {
  // 并行加载数据
  await Promise.all([
    loadStudentInfo(),
    loadDashboardStats(),
    loadTodos(),
    loadNotifications()
  ]);
  
  // 初始化图表
  initScoreTrendChart();
});
</script>

<style scoped>
/* ===== 学生Dashboard样式 ===== */

.student-dashboard {
  padding: 16px; /* 进一步减少内边距 */
  background: var(--bg-color);
  min-height: 100vh;
}

/* 欢迎区域 */
.welcome-header {
  margin-bottom: 20px; /* 减少下边距 */
  border-radius: 20px;
  overflow: hidden;
  background: var(--primary-gradient);
  color: white;
  position: relative;
}

.welcome-header::before {
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
  padding: 24px; /* 减少内边距 */
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  z-index: 2;
}

.student-info {
  flex: 1;
}

.avatar-section {
  display: flex;
  align-items: center;
  gap: 20px;
  position: relative;
}

.student-avatar {
  background: rgba(255, 255, 255, 0.2);
  border: 3px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  cursor: pointer;
  transition: all 0.3s ease;
}

.student-avatar:hover {
  transform: scale(1.05);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.3);
}

.avatar-upload {
  position: absolute;
  bottom: 0;
  right: 80px;
  width: 28px;
  height: 28px;
  background: linear-gradient(135deg, #409eff 0%, #66b1ff 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  cursor: pointer;
  border: 2px solid white;
  font-size: 14px;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.avatar-upload:hover {
  transform: scale(1.1);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.3);
}

.info-text {
  flex: 1;
}

.welcome-title {
  margin: 0 0 8px 0;
  font-size: 28px;
  font-weight: 700;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.welcome-subtitle {
  margin: 0 0 16px 0;
  font-size: 16px;
  opacity: 0.9;
}

.student-details {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  margin-bottom: 16px;
}

.detail-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  opacity: 0.9;
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
  margin-bottom: 20px; /* 减少下边距 */
}

.stats-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 16px; /* 减少间距 */
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

.gradient-primary .stat-icon {
  background: linear-gradient(135deg, #409eff 0%, #66b1ff 100%);
}

.gradient-success .stat-icon {
  background: linear-gradient(135deg, #67c23a 0%, #85ce61 100%);
}

.gradient-warning .stat-icon {
  background: linear-gradient(135deg, #e6a23c 0%, #ebb563 100%);
}

.gradient-info .stat-icon {
  background: linear-gradient(135deg, #909399 0%, #b1b3b8 100%);
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

/* 主要内容区 */
.main-content {
  display: flex;
  gap: 16px; /* 减少间距 */
  margin-bottom: 16px; /* 减少下边距 */
}

.todo-card,
.score-trend-card {
  flex: 1;
}

/* 卡片头部 */
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 待办事项 */
.todo-list .todo-item {
  padding: 12px 0;
}

.todo-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.todo-title {
  font-size: 14px;
  color: #303133;
  margin-bottom: 4px;
}

.todo-meta {
  display: flex;
  gap: 12px;
  font-size: 12px;
}

.todo-status {
  padding: 2px 8px;
  border-radius: 10px;
  font-size: 12px;
}

.todo-status.pending {
  background-color: #fef0f0;
  color: #f56c6c;
}

.todo-status.inProgress {
  background-color: #f0f9ff;
  color: #409eff;
}

.todo-status.completed {
  background-color: #f0f9ff;
  color: #67c23a;
}

.todo-deadline {
  color: #909399;
}

/* 成绩趋势 */
.chart-container {
  height: 300px;
}

.score-trend-chart {
  width: 100%;
  height: 100%;
}

/* 通知列表 */
.notifications-card {
  margin-bottom: 16px; /* 减少下边距 */
}

.notification-list .notification-item {
  padding: 12px 0;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.notification-content {
  flex: 1;
  margin-right: 12px;
}

.notification-title {
  font-size: 14px;
  color: #303133;
  margin-bottom: 4px;
}

.notification-time {
  font-size: 12px;
  color: #909399;
}

.read-btn {
  color: #409eff;
  font-size: 12px;
}

/* 暂无数据 */
.no-data {
  text-align: center;
  color: #909399;
  padding: 40px 0;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .stats-container {
    flex-wrap: wrap;
  }

  .stat-card {
    min-width: calc(50% - 10px);
  }

  .main-content {
    flex-direction: column;
  }
}

@media (max-width: 768px) {
  .student-dashboard {
    padding: 12px; /* 移动端进一步减少内边距 */
  }
  
  .welcome-content {
    flex-direction: column;
    align-items: flex-start;
    gap: 20px;
  }

  .welcome-actions .el-button {
    margin-left: 0;
    margin-right: 12px;
  }

  .stat-card {
    min-width: 100%;
  }
}
</style>
