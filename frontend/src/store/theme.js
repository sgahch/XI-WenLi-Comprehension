import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
// theme.js
// 主题相关状态管理
export const useThemeStore = defineStore('theme', () => {
  // 主题状态
  const isDark = ref(false)
  
  // 从本地存储加载主题设置
  const loadTheme = () => {
    // 确保只在浏览器环境中执行
    if (typeof localStorage === 'undefined' || typeof window === 'undefined') return;
    
    const savedTheme = localStorage.getItem('theme')
    if (savedTheme) {
      isDark.value = savedTheme === 'dark'
    } else {
      // 检测系统主题
      isDark.value = window.matchMedia('(prefers-color-scheme: dark)').matches
    }
    applyTheme()
  }
  
  // 切换主题
  const toggleTheme = () => {
    isDark.value = !isDark.value
    applyTheme()
    
    // 确保只在浏览器环境中执行
    if (typeof localStorage !== 'undefined') {
      localStorage.setItem('theme', isDark.value ? 'dark' : 'light')
    }
  }
  
  // 应用主题
  const applyTheme = () => {
    // 确保只在浏览器环境中执行
    if (typeof document === 'undefined') return;
    
    const root = document.documentElement
    
    if (isDark.value) {
      // 夜间模式样式变量
      root.style.setProperty('--primary-color', '#409eff')
      root.style.setProperty('--primary-light', '#66b1ff')
      root.style.setProperty('--primary-dark', '#337ecc')
      
      root.style.setProperty('--success-color', '#67c23a')
      root.style.setProperty('--warning-color', '#e6a23c')
      root.style.setProperty('--danger-color', '#f56c6c')
      root.style.setProperty('--info-color', '#909399')
      
      root.style.setProperty('--text-primary', '#e4e7ed')
      root.style.setProperty('--text-regular', '#cfcfcf')
      root.style.setProperty('--text-secondary', '#a8abb2')
      root.style.setProperty('--text-placeholder', '#6c6e72')
      
      root.style.setProperty('--bg-primary', '#1d1e1f')
      root.style.setProperty('--bg-secondary', '#141414')
      root.style.setProperty('--bg-tertiary', '#262727')
      root.style.setProperty('--bg-overlay', 'rgba(0, 0, 0, 0.8)')
      
      root.style.setProperty('--border-light', '#414243')
      root.style.setProperty('--border-base', '#4c4d4f')
      root.style.setProperty('--border-dark', '#58585b')
      
      root.style.setProperty('--shadow-light', '0 2px 4px rgba(0, 0, 0, 0.24), 0 0 6px rgba(0, 0, 0, 0.08)')
      root.style.setProperty('--shadow-base', '0 2px 12px 0 rgba(0, 0, 0, 0.2)')
      root.style.setProperty('--shadow-dark', '0 4px 20px rgba(0, 0, 0, 0.3)')
      
      // Element Plus 夜间模式类
      root.classList.add('dark')
    } else {
      // 白天模式样式变量
      root.style.setProperty('--primary-color', '#409eff')
      root.style.setProperty('--primary-light', '#66b1ff')
      root.style.setProperty('--primary-dark', '#337ecc')
      
      root.style.setProperty('--success-color', '#67c23a')
      root.style.setProperty('--warning-color', '#e6a23c')
      root.style.setProperty('--danger-color', '#f56c6c')
      root.style.setProperty('--info-color', '#909399')
      
      root.style.setProperty('--text-primary', '#303133')
      root.style.setProperty('--text-regular', '#606266')
      root.style.setProperty('--text-secondary', '#909399')
      root.style.setProperty('--text-placeholder', '#c0c4cc')
      
      root.style.setProperty('--bg-primary', '#ffffff')
      root.style.setProperty('--bg-secondary', '#f5f7fa')
      root.style.setProperty('--bg-tertiary', '#fafafa')
      root.style.setProperty('--bg-overlay', 'rgba(0, 0, 0, 0.5)')
      
      root.style.setProperty('--border-light', '#ebeef5')
      root.style.setProperty('--border-base', '#dcdfe6')
      root.style.setProperty('--border-dark', '#c0c4cc')
      
      root.style.setProperty('--shadow-light', '0 2px 4px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04)')
      root.style.setProperty('--shadow-base', '0 2px 12px 0 rgba(0, 0, 0, 0.1)')
      root.style.setProperty('--shadow-dark', '0 4px 20px rgba(0, 0, 0, 0.15)')
      
      // 移除 Element Plus 夜间模式类
      root.classList.remove('dark')
    }
  }
  
  // 计算属性
  const currentTheme = computed(() => isDark.value ? 'dark' : 'light')
  const themeIcon = computed(() => isDark.value ? 'Sunny' : 'Moon')
  
  return {
    isDark,
    currentTheme,
    themeIcon,
    loadTheme,
    toggleTheme,
    applyTheme
  }
})