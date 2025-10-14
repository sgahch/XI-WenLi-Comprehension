import { createApp } from "vue";
import { createPinia } from "pinia";
import ElementPlus from "element-plus";
import "element-plus/dist/index.css";
import router from "./router";
import "./style.css";
import App from "./App.vue";

// 导入所有 Element Plus 图标
import * as ElementPlusIconsVue from "@element-plus/icons-vue";

// 创建应用实例
const app = createApp(App);

// 全局注册所有图标组件
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}

// 安装插件
const pinia = createPinia();
app.use(pinia);
app.use(router);
app.use(ElementPlus);

// 挂载应用
app.mount("#app");

// 主题初始化现在由 App.vue 的 onMounted 钩子负责
