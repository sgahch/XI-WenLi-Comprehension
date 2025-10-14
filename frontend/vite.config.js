// import { defineConfig } from "vite";
// import vue from "@vitejs/plugin-vue";
// import path from "path";
//
// export default defineConfig({
//   plugins: [vue()],
//   resolve: {
//     alias: {
//       "@": path.resolve(process.cwd(), "src"),
//     },
//   },
//   server: {
//     host: "0.0.0.0",
//     port: 5173,
//     proxy: {
//       "/api": {
//         target: "http://localhost:8080",
//         changeOrigin: true,
//       },
//     },
//   },
// });
import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

// https://vitejs.dev/config/
export default ({ mode }) => {
  // 加载当前模式下的环境变量
  const env = loadEnv(mode, process.cwd());

  return defineConfig({
    plugins: [vue()],

    // 解析配置
    resolve: {
      alias: {
        '@': path.resolve(__dirname, 'src')
      }
    },

    // 开发服务器配置
    server: {
      port: 5173, // 你可以自定义前端运行的端口
      host: '0.0.0.0',
      open: true,
      proxy: {
        // ======================= 唯一的、核心的代理配置 =======================
        // 将所有以 /dev-api 开头的请求，转发到若依后端
        [env.VITE_APP_BASE_API]: {
          target: 'http://localhost:8080', // 若依后端的地址
          changeOrigin: true,
          // 路径重写：在转发时，去掉请求路径中的 /dev-api 前缀
          rewrite: (path) => path.replace(new RegExp('^' + env.VITE_APP_BASE_API), '')
        }
      }
    },
  })
}