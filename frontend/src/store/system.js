import { defineStore } from 'pinia'
// system.js
// 系统配置状态管理
export const useSystemStore = defineStore('system', {
  state: () => ({
    loading: false,
    theme: 'light',
    menuCollapsed: false,
    notifications: []
  }),
  actions: {
    setLoading(loading) {
      this.loading = loading
    },
    toggleTheme() {
      this.theme = this.theme === 'light' ? 'dark' : 'light'
      document.documentElement.classList.toggle('dark')
    },
    toggleMenu() {
      this.menuCollapsed = !this.menuCollapsed
    },
    addNotification(notification) {
      this.notifications.push({
        ...notification,
        id: Date.now() + Math.random(),
        timestamp: new Date().toISOString()
      })
    },
    removeNotification(id) {
      this.notifications = this.notifications.filter(notification => notification.id !== id)
    }
  }
})