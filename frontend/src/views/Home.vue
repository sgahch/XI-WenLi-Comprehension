<template>
  <div class="modern-layout" :class="{ 'dark-mode': isDarkMode }">
    <!-- 背景装饰 -->
    <div class="layout-background">
      <div class="bg-decoration"></div>
      <div class="bg-particles"></div>
    </div>
    
    <!-- 侧边栏 -->
    <ModernSidebar 
      :is-collapsed="menuCollapsed" 
      @toggle-theme="toggleTheme"
    />
    
    <!-- 主内容区域 -->
    <div class="main-container" :class="{ collapsed: menuCollapsed }">
      <!-- 顶部导航栏 -->
      <ModernHeader 
        @toggle-menu="toggleMenu"
        @toggle-theme="toggleTheme"
      />
      
      <!-- 页面内容 -->
      <main class="page-content">
        <div class="content-wrapper">
          <router-view v-slot="{ Component }">
            <transition name="page-transition" mode="out-in">
              <component :is="Component" />
            </transition>
          </router-view>
        </div>
      </main>
    </div>
    
    <!-- 移动端遮罩 -->
    <div 
      v-if="!menuCollapsed" 
      class="mobile-overlay"
      @click="closeMobileMenu"
    ></div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useUserStore, useSystemStore, useThemeStore } from '../store'
import { ElMessage } from 'element-plus'
import ModernSidebar from '../components/ModernSidebar.vue'
import ModernHeader from '../components/ModernHeader.vue'

// Router
const router = useRouter()
const route = useRoute()

// Store
const userStore = useUserStore()
const systemStore = useSystemStore()
const themeStore = useThemeStore()

// 计算属性
const menuCollapsed = computed(() => systemStore.menuCollapsed)
const userRoleId = computed(() => userStore.getRoleId)
const isDarkMode = computed(() => themeStore.isDark)

// 方法
const toggleMenu = () => {
  systemStore.toggleMenu()
}

const toggleTheme = () => {
  themeStore.toggleTheme()
}

const closeMobileMenu = () => {
  if (window.innerWidth <= 768) {
    systemStore.menuCollapsed = true
  }
}

// 生命周期
onMounted(() => {
  // 加载保存的主题设置
  themeStore.loadTheme()
  
  // 检查登录状态
  if (!userStore.isLoggedIn) {
    router.push('/login')
  }
  
  // 监听窗口大小变化
  const handleResize = () => {
    if (window.innerWidth <= 768) {
      systemStore.menuCollapsed = true
    }
  }
  
  window.addEventListener('resize', handleResize)
  handleResize()
})
</script>

<style scoped>
/* 现代化布局样式 */
.modern-layout {
  display: flex;
  min-height: 100vh;
  background: var(--bg-secondary);
  position: relative;
  overflow: hidden;
}

/* 背景装饰 */
.layout-background {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: -1;
  pointer-events: none;
}

.bg-decoration {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 20% 80%, rgba(64, 158, 255, 0.1) 0%, transparent 50%),
              radial-gradient(circle at 80% 20%, rgba(103, 194, 58, 0.1) 0%, transparent 50%),
              radial-gradient(circle at 40% 40%, rgba(230, 162, 60, 0.1) 0%, transparent 50%);
  animation: float 20s ease-in-out infinite;
}

.bg-particles {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: 
    radial-gradient(circle at 25% 25%, rgba(64, 158, 255, 0.1) 1px, transparent 1px),
    radial-gradient(circle at 75% 75%, rgba(103, 194, 58, 0.1) 1px, transparent 1px);
  background-size: 100px 100px, 150px 150px;
  animation: particle-float 30s linear infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

@keyframes particle-float {
  0% { transform: translateX(0px) translateY(0px); }
  33% { transform: translateX(30px) translateY(-30px); }
  66% { transform: translateX(-20px) translateY(20px); }
  100% { transform: translateX(0px) translateY(0px); }
}

/* 主内容区域 */
.main-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  margin-left: 260px; /* 匹配侧边栏宽度 */
  transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  min-height: 100vh;
}

.main-container.collapsed {
  margin-left: 70px; /* 匹配折叠后的侧边栏宽度 */
}

/* 页面内容 */
.page-content {
  flex: 1;
  padding: 16px; /* 进一步减少内边距 */
  background: var(--bg-secondary);
  min-height: calc(100vh - 64px);
  position: relative;
}

.content-wrapper {
  max-width: 1400px;
  margin: 0 auto;
  position: relative;
  z-index: 1;
}

/* 页面过渡动画 */
.page-transition-enter-active,
.page-transition-leave-active {
  transition: all 0.3s ease;
}

.page-transition-enter-from {
  opacity: 0;
  transform: translateY(20px);
}

.page-transition-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

/* 移动端遮罩 */
.mobile-overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 999;
  backdrop-filter: blur(4px);
}

/* 深色模式适配 */
.dark-mode .layout-background {
  background: radial-gradient(circle at 20% 80%, rgba(64, 158, 255, 0.05) 0%, transparent 50%),
              radial-gradient(circle at 80% 20%, rgba(103, 194, 58, 0.05) 0%, transparent 50%);
}

.dark-mode .bg-particles {
  opacity: 0.3;
}

.dark-mode .page-content {
  background: var(--bg-secondary);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .main-container {
    margin-left: 0;
  }
  
  .main-container.collapsed {
    margin-left: 0;
  }
  
  .page-content {
    padding: 16px;
  }
  
  .mobile-overlay {
    display: block;
  }
}

@media (max-width: 480px) {
  .page-content {
    padding: 12px;
  }
}

/* 滚动优化 */
.page-content {
  scroll-behavior: smooth;
}

/* 高级动效 */
@media (prefers-reduced-motion: no-preference) {
  .main-container {
    transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  
  .page-transition-enter-active {
    transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  }
  
  .page-transition-leave-active {
    transition: all 0.3s cubic-bezier(0.55, 0.055, 0.675, 0.19);
  }
}

/* 无障碍支持 */
@media (prefers-reduced-motion: reduce) {
  .bg-decoration,
  .bg-particles {
    animation: none;
  }
  
  .page-transition-enter-active,
  .page-transition-leave-active {
    transition: none;
  }
}

/* 高对比度模式 */
@media (prefers-contrast: high) {
  .modern-layout {
    border: 2px solid var(--border-dark);
  }
  
  .bg-decoration,
  .bg-particles {
    opacity: 0.1;
  }
}
</style>