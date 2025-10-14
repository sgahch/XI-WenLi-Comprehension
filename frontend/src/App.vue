<template>
  <router-view />
</template>

<script setup>
import { onMounted } from 'vue'
import { useThemeStore } from './store' // 导入 theme store

const themeStore = useThemeStore()

// 当 App 组件被挂载到浏览器 DOM 上时，执行主题加载
onMounted(() => {
  themeStore.loadTheme()
})
</script>

<style scoped>
/* 可添加全局样式 */
</style>
