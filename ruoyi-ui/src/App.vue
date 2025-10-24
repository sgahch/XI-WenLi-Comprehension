<template>
    <div id="app">
      <router-view />
      <theme-picker />
      <ai-chat /> 
    </div>
    
</template>

<script>
import ThemePicker from "@/components/ThemePicker"
import AiChat from "@/components/AiChat"

export default {
  name: "App",
  components: { ThemePicker, AiChat }
}
</script>

<style scoped>
#app .theme-picker {
  display: none;
}
</style>
