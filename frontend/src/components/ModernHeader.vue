<template>
  <div class="modern-header">
    <!-- 左侧区域 -->
    <div class="header-left">
      <el-button 
        type="text" 
        class="menu-toggle-btn" 
        @click="$emit('toggle-menu')"
      >
        <el-icon><Menu /></el-icon>
      </el-button>
      
      <!-- 面包屑导航 -->
      <el-breadcrumb class="breadcrumb" separator="/">
        <el-breadcrumb-item v-for="item in breadcrumbItems" :key="item.path">
          <router-link v-if="item.path" :to="item.path">
            {{ item.name }}
          </router-link>
          <span v-else>{{ item.name }}</span>
        </el-breadcrumb-item>
      </el-breadcrumb>
    </div>
    
    <!-- 右侧区域 -->
    <div class="header-right">
      <!-- 搜索框 -->
      <div class="search-container">
        <el-input
          v-model="searchQuery"
          placeholder="搜索功能..."
          class="search-input"
          clearable
          @input="handleSearch"
        >
          <template #prefix>
            <el-icon><Search /></el-icon>
          </template>
        </el-input>
      </div>
      
      <!-- 主题切换 -->
      <el-tooltip :content="isDarkMode ? '切换到浅色模式' : '切换到深色模式'" placement="bottom">
        <el-button 
          type="text" 
          class="theme-toggle-btn" 
          @click="$emit('toggle-theme')"
        >
          <el-icon><component :is="themeIcon" /></el-icon>
        </el-button>
      </el-tooltip>
      
      <!-- 全屏切换 -->
      <el-tooltip content="全屏切换" placement="bottom">
        <el-button 
          type="text" 
          class="fullscreen-btn" 
          @click="toggleFullscreen"
        >
          <el-icon><FullScreen /></el-icon>
        </el-button>
      </el-tooltip>
      
      <!-- 通知中心 -->
      <el-dropdown class="notification-dropdown" @command="handleNotificationCommand">
        <el-button type="text" class="notification-btn">
          <el-badge :value="unreadCount" :hidden="unreadCount === 0">
            <el-icon><Bell /></el-icon>
          </el-badge>
        </el-button>
        <template #dropdown>
          <el-dropdown-menu class="notification-menu">
            <div class="notification-header">
              <span class="notification-title">通知中心</span>
              <el-button type="text" size="small" @click="markAllAsRead">
                全部已读
              </el-button>
            </div>
            <el-scrollbar max-height="300px">
              <div v-if="notifications.length === 0" class="no-notifications">
                <el-icon><InfoFilled /></el-icon>
                <span>暂无通知</span>
              </div>
              <div
                v-for="notification in notifications.slice(0, 5)"
                :key="notification.id"
                class="notification-item"
                :class="{ unread: !notification.read }"
                @click="handleNotificationClick(notification)"
              >
                <div class="notification-content">
                  <div class="notification-text">{{ notification.content }}</div>
                  <div class="notification-time">{{ formatTime(notification.time) }}</div>
                </div>
                <el-button
                  v-if="!notification.read"
                  type="text"
                  size="small"
                  class="mark-read-btn"
                  @click.stop="markAsRead(notification.id)"
                >
                  <el-icon><Check /></el-icon>
                </el-button>
              </div>
            </el-scrollbar>
            <div class="notification-footer">
              <el-button type="text" @click="goToNotifications">
                查看全部通知
              </el-button>
            </div>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
      
      <!-- 用户信息 -->
      <el-dropdown class="user-dropdown" @command="handleUserCommand">
        <div class="user-info">
          <el-avatar 
            :src="userAvatar" 
            class="user-avatar"
            :size="36"
          >
            {{ userName.charAt(0) }}
          </el-avatar>
          <div class="user-details">
            <span class="user-name">{{ userName }}</span>
            <span class="user-role">{{ userRoleName }}</span>
          </div>
          <el-icon class="dropdown-icon"><ArrowDown /></el-icon>
        </div>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item command="profile">
              <el-icon><User /></el-icon>
              个人信息
            </el-dropdown-item>
            <el-dropdown-item command="settings">
              <el-icon><Setting /></el-icon>
              系统设置
            </el-dropdown-item>
            <el-dropdown-item divided command="logout">
              <el-icon><SwitchButton /></el-icon>
              退出登录
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useUserStore, useThemeStore } from '../store'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  Menu, Search, Bell, User, Setting, SwitchButton, ArrowDown,
  Sunny, Moon, FullScreen, InfoFilled, Check
} from '@element-plus/icons-vue'

// Emits
defineEmits(['toggle-menu', 'toggle-theme'])

// Router
const router = useRouter()
const route = useRoute()

// Store
const userStore = useUserStore()
const themeStore = useThemeStore()

// 响应式数据
const searchQuery = ref('')
const notifications = ref([
  {
    id: 1,
    content: '您有新的测评任务需要完成',
    time: '2025-09-14 10:30',
    read: false,
    type: 'info'
  },
  {
    id: 2,
    content: '成绩申诉已处理完成',
    time: '2025-09-14 09:15',
    read: false,
    type: 'success'
  },
  {
    id: 3,
    content: '系统将于今晚22:00进行维护',
    time: '2025-09-13 18:00',
    read: true,
    type: 'warning'
  }
])

// 计算属性
const userName = computed(() => {
  const userInfo = userStore.getUserInfo
  return userInfo ? userInfo.realName || userInfo.username || '用户' : '用户'
})

const userAvatar = computed(() => userStore.getUserInfo?.avatar)

const userRoleName = computed(() => {
  const roleId = userStore.getRoleId
  const roleMap = {
    1: '管理员',
    2: '学生',
    3: '领导'
  }
  return roleMap[roleId] || '用户'
})

const isDarkMode = computed(() => themeStore.isDark)
const themeIcon = computed(() => themeStore.themeIcon)

const unreadCount = computed(() => {
  return notifications.value.filter(n => !n.read).length
})

const breadcrumbItems = computed(() => {
  const path = route.path
  const breadcrumbs = []
  
  // 根据路径生成面包屑
  if (path.includes('/student')) {
    breadcrumbs.push({ name: '学生端', path: '/student/dashboard' })
    if (path.includes('/personal-info')) {
      breadcrumbs.push({ name: '个人信息', path: null })
    } else if (path.includes('/evaluation-application')) {
      breadcrumbs.push({ name: '测评填报', path: null })
    } else if (path.includes('/score-query')) {
      breadcrumbs.push({ name: '成绩查询', path: null })
    } else if (path.includes('/appeal')) {
      breadcrumbs.push({ name: '成绩申诉', path: null })
    } else if (path.includes('/dashboard')) {
      breadcrumbs.push({ name: '控制台', path: null })
    }
  } else if (path.includes('/admin')) {
    breadcrumbs.push({ name: '管理员', path: '/admin/dashboard' })
    if (path.includes('/users')) {
      breadcrumbs.push({ name: '用户管理', path: null })
    } else if (path.includes('/evaluation-rules')) {
      breadcrumbs.push({ name: '测评规则', path: null })
    } else if (path.includes('/materials')) {
      breadcrumbs.push({ name: '材料审核', path: null })
    } else if (path.includes('/dashboard')) {
      breadcrumbs.push({ name: '控制台', path: null })
    }
  } else if (path.includes('/leader')) {
    breadcrumbs.push({ name: '领导端', path: '/leader/dashboard' })
    if (path.includes('/reports')) {
      breadcrumbs.push({ name: '报表分析', path: null })
    } else if (path.includes('/dashboard')) {
      breadcrumbs.push({ name: '数据驾驶舱', path: null })
    }
  } else if (path.includes('/notifications')) {
    breadcrumbs.push({ name: '通知公告', path: null })
  }
  
  return breadcrumbs
})

// 方法
const handleSearch = (value) => {
  if (value.trim()) {
    // TODO: 实现搜索功能
    console.log('搜索:', value)
  }
}

const toggleFullscreen = () => {
  if (!document.fullscreenElement) {
    document.documentElement.requestFullscreen()
  } else {
    document.exitFullscreen()
  }
}

const handleNotificationCommand = (command) => {
  console.log('通知命令:', command)
}

const handleNotificationClick = (notification) => {
  markAsRead(notification.id)
  // 根据通知类型跳转到相应页面
  console.log('点击通知:', notification)
}

const markAsRead = (id) => {
  const notification = notifications.value.find(n => n.id === id)
  if (notification) {
    notification.read = true
  }
}

const markAllAsRead = () => {
  notifications.value.forEach(n => {
    n.read = true
  })
  ElMessage.success('所有通知已标记为已读')
}

const goToNotifications = () => {
  router.push('/notifications')
}

const handleUserCommand = (command) => {
  switch (command) {
    case 'profile':
      goToProfile()
      break
    case 'settings':
      goToSettings()
      break
    case 'logout':
      handleLogout()
      break
  }
}

const goToProfile = () => {
  const roleId = userStore.getRoleId
  if (roleId === 2) {
    router.push('/student/personal-info')
  } else {
    router.push('/profile')
  }
}

const goToSettings = () => {
  router.push('/settings')
}

const handleLogout = () => {
  ElMessageBox.confirm('确定要退出登录吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    userStore.logout()
    ElMessage.success('已成功退出登录')
  }).catch(() => {})
}

const formatTime = (timeString) => {
  const time = new Date(timeString)
  const now = new Date()
  const diff = now - time
  const days = Math.floor(diff / (1000 * 60 * 60 * 24))
  const hours = Math.floor(diff / (1000 * 60 * 60))
  const minutes = Math.floor(diff / (1000 * 60))
  
  if (days > 0) {
    return `${days}天前`
  } else if (hours > 0) {
    return `${hours}小时前`
  } else if (minutes > 0) {
    return `${minutes}分钟前`
  } else {
    return '刚刚'
  }
}
</script>

<style scoped>
.modern-header {
  height: 64px;
  background: var(--bg-primary);
  border-bottom: 1px solid var(--border-light);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  position: relative;
  z-index: 99;
  box-shadow: var(--shadow-light);
  backdrop-filter: blur(10px);
}

/* 左侧区域 */
.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.menu-toggle-btn {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  background: var(--bg-tertiary);
  border: 1px solid var(--border-light);
  color: var(--text-regular);
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.menu-toggle-btn:hover {
  background: var(--primary-color);
  color: white;
  transform: translateY(-1px);
  box-shadow: var(--shadow-base);
}

.breadcrumb {
  font-size: 14px;
}

:deep(.el-breadcrumb__inner a) {
  color: var(--primary-color);
  font-weight: 500;
  text-decoration: none;
  transition: color 0.3s ease;
}

:deep(.el-breadcrumb__inner a:hover) {
  color: var(--primary-dark);
}

:deep(.el-breadcrumb__inner:not(a)) {
  color: var(--text-regular);
  font-weight: 500;
}

/* 右侧区域 */
.header-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

/* 搜索框 */
.search-container {
  width: 300px;
}

.search-input {
  --el-input-border-radius: 20px;
  --el-input-bg-color: var(--bg-tertiary);
  --el-input-border-color: var(--border-light);
}

:deep(.search-input .el-input__wrapper) {
  border-radius: 20px;
  background: var(--bg-tertiary);
  border: 1px solid var(--border-light);
  transition: all 0.3s ease;
}

:deep(.search-input .el-input__wrapper:hover) {
  border-color: var(--primary-color);
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.1);
}

:deep(.search-input .el-input__wrapper.is-focus) {
  border-color: var(--primary-color);
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

/* 工具按钮 */
.theme-toggle-btn,
.fullscreen-btn {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  background: var(--bg-tertiary);
  border: 1px solid var(--border-light);
  color: var(--text-regular);
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.theme-toggle-btn:hover,
.fullscreen-btn:hover {
  background: var(--primary-color);
  color: white;
  transform: translateY(-1px);
  box-shadow: var(--shadow-base);
}

/* 通知下拉 */
.notification-btn {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  background: var(--bg-tertiary);
  border: 1px solid var(--border-light);
  color: var(--text-regular);
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.notification-btn:hover {
  background: var(--primary-color);
  color: white;
  transform: translateY(-1px);
  box-shadow: var(--shadow-base);
}

.notification-menu {
  width: 320px;
  border-radius: 12px;
  box-shadow: var(--shadow-dark);
}

.notification-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-light);
}

.notification-title {
  font-weight: 600;
  font-size: 16px;
  color: var(--text-primary);
}

.no-notifications {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 40px 20px;
  color: var(--text-secondary);
}

.notification-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-light);
  cursor: pointer;
  transition: background 0.3s ease;
}

.notification-item:hover {
  background: var(--bg-tertiary);
}

.notification-item.unread {
  background: rgba(64, 158, 255, 0.05);
  border-left: 3px solid var(--primary-color);
}

.notification-content {
  flex: 1;
}

.notification-text {
  font-size: 14px;
  color: var(--text-primary);
  line-height: 1.4;
  margin-bottom: 4px;
}

.notification-time {
  font-size: 12px;
  color: var(--text-secondary);
}

.mark-read-btn {
  color: var(--primary-color);
}

.notification-footer {
  padding: 12px 20px;
  border-top: 1px solid var(--border-light);
  text-align: center;
}

/* 用户信息 */
.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 16px;
  border-radius: 12px;
  background: var(--bg-tertiary);
  border: 1px solid var(--border-light);
  cursor: pointer;
  transition: all 0.3s ease;
}

.user-info:hover {
  background: var(--primary-color);
  color: white;
  transform: translateY(-1px);
  box-shadow: var(--shadow-base);
}

.user-info:hover .user-details {
  color: white;
}

.user-avatar {
  border: 2px solid var(--border-light);
  transition: border-color 0.3s ease;
}

.user-info:hover .user-avatar {
  border-color: rgba(255, 255, 255, 0.5);
}

.user-details {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.user-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
  transition: color 0.3s ease;
}

.user-role {
  font-size: 12px;
  color: var(--text-secondary);
  transition: color 0.3s ease;
}

.dropdown-icon {
  color: var(--text-secondary);
  transition: all 0.3s ease;
}

.user-info:hover .dropdown-icon {
  color: white;
  transform: rotate(180deg);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .modern-header {
    padding: 0 16px;
  }
  
  .search-container {
    display: none;
  }
  
  .user-details {
    display: none;
  }
  
  .header-right {
    gap: 8px;
  }
}

/* 深色模式适配 */
.dark .modern-header {
  background: var(--bg-primary);
  border-bottom-color: var(--border-dark);
}

.dark .menu-toggle-btn,
.dark .theme-toggle-btn,
.dark .fullscreen-btn,
.dark .notification-btn {
  background: var(--bg-tertiary);
  border-color: var(--border-dark);
}

.dark .user-info {
  background: var(--bg-tertiary);
  border-color: var(--border-dark);
}
</style>