<template>
  <div class="modern-sidebar" :class="{ collapsed: isCollapsed }">
    <!-- Logo区域 -->
    <div class="sidebar-logo">
      <div class="logo-icon">
        <el-icon><School /></el-icon>
      </div>
      <transition name="fade">
        <span v-show="!isCollapsed" class="logo-text">
          综合测评系统
        </span>
      </transition>
    </div>
    
    <!-- 菜单区域 -->
    <el-scrollbar class="sidebar-scrollbar">
      <el-menu
        :default-active="activeMenu"
        class="sidebar-menu"
        :collapse="isCollapsed"
        :collapse-transition="false"
        router
        unique-opened
      >
        <!-- 学生菜单 -->
        <template v-if="userRoleId === 2">
          <el-menu-item index="/student/dashboard" class="menu-item">
            <el-icon><Grid /></el-icon>
            <template #title>
              <span class="menu-title">控制台</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/student/personal-info" class="menu-item">
            <el-icon><User /></el-icon>
            <template #title>
              <span class="menu-title">个人信息</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/student/evaluation-application" class="menu-item">
            <el-icon><EditPen /></el-icon>
            <template #title>
              <span class="menu-title">测评填报</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/student/score-query" class="menu-item">
            <el-icon><DocumentChecked /></el-icon>
            <template #title>
              <span class="menu-title">成绩查询</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/student/appeal" class="menu-item">
            <el-icon><Warning /></el-icon>
            <template #title>
              <span class="menu-title">成绩申诉</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/notifications" class="menu-item">
            <el-icon><Bell /></el-icon>
            <template #title>
              <span class="menu-title">通知公告</span>
            </template>
          </el-menu-item>
        </template>

        <!-- 管理员菜单 -->
        <template v-if="userRoleId === 1">
          <el-menu-item index="/admin/dashboard" class="menu-item">
            <el-icon><Grid /></el-icon>
            <template #title>
              <span class="menu-title">控制台</span>
            </template>
          </el-menu-item>
          
          <el-sub-menu index="user-management" class="sub-menu">
            <template #title>
              <el-icon><UserFilled /></el-icon>
              <span class="menu-title">用户管理</span>
            </template>
            <el-menu-item index="/admin/users" class="menu-item">
              <span class="menu-title">用户列表</span>
            </el-menu-item>
            <el-menu-item index="/admin/roles" class="menu-item">
              <span class="menu-title">角色权限</span>
            </el-menu-item>
          </el-sub-menu>
          
          <el-sub-menu index="evaluation-management" class="sub-menu">
            <template #title>
              <el-icon><DocumentCopy /></el-icon>
              <span class="menu-title">测评管理</span>
            </template>
            <el-menu-item index="/admin/evaluation-rules" class="menu-item">
              <span class="menu-title">测评规则</span>
            </el-menu-item>
            <el-menu-item index="/admin/evaluation-items" class="menu-item">
              <span class="menu-title">测评项目</span>
            </el-menu-item>
          </el-sub-menu>
          
          <el-menu-item index="/admin/materials" class="menu-item">
            <el-icon><Files /></el-icon>
            <template #title>
              <span class="menu-title">材料审核</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/notifications" class="menu-item">
            <el-icon><Bell /></el-icon>
            <template #title>
              <span class="menu-title">通知公告</span>
            </template>
          </el-menu-item>
        </template>

        <!-- 领导菜单 -->
        <template v-if="userRoleId === 3">
          <el-menu-item index="/leader/dashboard" class="menu-item">
            <el-icon><DataAnalysis /></el-icon>
            <template #title>
              <span class="menu-title">数据驾驶舱</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/leader/reports" class="menu-item">
            <el-icon><Document /></el-icon>
            <template #title>
              <span class="menu-title">报表分析</span>
            </template>
          </el-menu-item>
          
          <el-menu-item index="/notifications" class="menu-item">
            <el-icon><Bell /></el-icon>
            <template #title>
              <span class="menu-title">通知公告</span>
            </template>
          </el-menu-item>
        </template>
      </el-menu>
    </el-scrollbar>
    
    <!-- 底部设置区域 -->
    <div class="sidebar-footer">
      <div class="footer-item" @click="$emit('toggle-theme')">
        <el-icon><component :is="themeIcon" /></el-icon>
        <transition name="fade">
          <span v-show="!isCollapsed" class="footer-text">
            {{ isDarkMode ? '浅色模式' : '深色模式' }}
          </span>
        </transition>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { useUserStore, useThemeStore } from '../store'
import {
  Grid, User, EditPen, DocumentChecked, Warning, Bell,
  UserFilled, DocumentCopy, Files, DataAnalysis, Document,
  School, Sunny, Moon
} from '@element-plus/icons-vue'

// Props
defineProps({
  isCollapsed: {
    type: Boolean,
    default: false
  }
})

// Emits
defineEmits(['toggle-theme'])

// Store
const userStore = useUserStore()
const themeStore = useThemeStore()
const route = useRoute()

// Computed
const userRoleId = computed(() => userStore.getRoleId)
const activeMenu = computed(() => route.path)
const isDarkMode = computed(() => themeStore.isDark)
const themeIcon = computed(() => themeStore.themeIcon)
</script>

<style scoped>
.modern-sidebar {
  width: 260px; /* 减小宽度 */
  height: 100vh;
  background: linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
  border-right: 1px solid rgba(226, 232, 240, 0.8);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: fixed; /* 添加固定定位 */
  left: 0;
  top: 0;
  display: flex;
  flex-direction: column;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  backdrop-filter: blur(10px);
  z-index: 100;
}

.modern-sidebar.collapsed {
  width: 70px; /* 减小折叠宽度 */
}

/* Logo区域 */
.sidebar-logo {
  display: flex;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid rgba(226, 232, 240, 0.6);
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  position: relative;
  overflow: hidden;
  min-height: 80px;
}

.sidebar-logo::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(45deg, transparent 0%, rgba(255, 255, 255, 0.1) 50%, transparent 100%);
  transform: translateX(-100%);
  transition: transform 0.6s ease;
}

.sidebar-logo:hover::before {
  transform: translateX(100%);
}

.logo-icon {
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 12px;
  font-size: 20px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.logo-text {
  font-size: 18px;
  font-weight: 600;
  white-space: nowrap;
  letter-spacing: 0.5px;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

/* 菜单区域 */
.sidebar-scrollbar {
  flex: 1;
  margin: 8px 0;
}

.sidebar-menu {
  border: none;
  background: transparent;
  --el-menu-item-height: 48px;
  --el-menu-base-level-padding: 20px;
  --el-menu-level-padding: 20px;
}

:deep(.el-menu-item) {
  margin: 0 12px 4px 12px;
  border-radius: 12px;
  border: none !important;
  background: transparent;
  color: var(--text-regular);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

:deep(.el-menu-item::before) {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 4px;
  background: var(--primary-color);
  opacity: 0;
  transition: opacity 0.3s ease;
}

:deep(.el-menu-item.is-active) {
  background: linear-gradient(135deg, rgba(64, 158, 255, 0.1) 0%, rgba(64, 158, 255, 0.05) 100%) !important;
  color: var(--primary-color) !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
  transform: translateX(2px);
}

:deep(.el-menu-item.is-active::before) {
  opacity: 1;
}

:deep(.el-menu-item:hover) {
  background: var(--bg-tertiary) !important;
  transform: translateX(2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

:deep(.el-menu-item .el-icon) {
  width: 20px;
  height: 20px;
  margin-right: 12px;
  font-size: 18px;
  transition: all 0.3s ease;
}

:deep(.el-menu-item.is-active .el-icon) {
  color: var(--primary-color);
  transform: scale(1.1);
}

.menu-title {
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s ease;
}

/* 子菜单样式 */
:deep(.el-sub-menu) {
  margin: 0 12px 4px 12px;
  border-radius: 12px;
}

:deep(.el-sub-menu__title) {
  height: 48px;
  line-height: 48px;
  padding: 0 20px !important;
  border-radius: 12px;
  color: var(--text-regular);
  transition: all 0.3s ease;
  background: transparent;
}

:deep(.el-sub-menu__title:hover) {
  background: var(--bg-tertiary) !important;
  transform: translateX(2px);
}

:deep(.el-sub-menu .el-menu-item) {
  margin: 2px 8px;
  padding-left: 52px !important;
  background: transparent;
}

/* 底部设置区域 */
.sidebar-footer {
  padding: 16px 12px;
  border-top: 1px solid var(--border-light);
}

.footer-item {
  display: flex;
  align-items: center;
  padding: 12px 20px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  color: var(--text-regular);
  background: transparent;
}

.footer-item:hover {
  background: var(--bg-tertiary);
  transform: translateX(2px);
  color: var(--primary-color);
}

.footer-item .el-icon {
  width: 20px;
  height: 20px;
  margin-right: 12px;
  font-size: 18px;
}

.footer-text {
  font-size: 14px;
  font-weight: 500;
}

/* 折叠状态调整 */
.modern-sidebar.collapsed .sidebar-menu {
  --el-menu-base-level-padding: 24px;
}

.modern-sidebar.collapsed :deep(.el-menu-item) {
  margin: 0 16px 4px 16px;
  justify-content: center;
  padding: 0 !important;
}

.modern-sidebar.collapsed :deep(.el-menu-item .el-icon) {
  margin-right: 0;
}

.modern-sidebar.collapsed .footer-item {
  justify-content: center;
  padding: 12px;
}

.modern-sidebar.collapsed .footer-item .el-icon {
  margin-right: 0;
}

/* 动画效果 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* 深色模式适配 */
.dark .modern-sidebar {
  background: linear-gradient(180deg, var(--bg-primary) 0%, var(--bg-tertiary) 100%);
  border-right-color: var(--border-dark);
}

.dark .sidebar-logo {
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .modern-sidebar {
    position: fixed;
    left: 0;
    top: 0;
    z-index: 1000;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
  }
  
  .modern-sidebar.mobile-open {
    transform: translateX(0);
  }
}
</style>