import axios from "axios";
import { useUserStore } from "../store";
import { ElMessage } from "element-plus"; // 确保您已安装并配置了Element Plus

// 创建axios实例
const service = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API || "/api", // 接口基础路径
  timeout: 10000, // 请求超时时间
  headers: {
    "Content-Type": "application/json;charset=utf-8",
  },
  withCredentials: true, // 允许携带cookie，兼容CORS
});

// 请求拦截器
service.interceptors.request.use(
  (config) => {
    // 添加请求日志
    console.log('发送请求:', config);
    
    // 获取用户store
    const userStore = useUserStore();
    // getToken是getter，不是函数，直接访问
    const token = userStore.getToken;
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    // 处理请求错误
    console.error('请求错误:', error);
    return Promise.reject(error);
  }
);

// [MODIFIED] 响应拦截器 (已重构)
service.interceptors.response.use(
  /**
   * HTTP 状态码为 2xx 的情况，会进入这里
   * 我们在这里对后端返回的 ResponseResult 进行处理
   */
  (response) => {
    // 添加响应日志
    console.log('收到响应:', response);
    
    const res = response.data;

    // 关键判断：检查 res.code 是否为业务成功状态码 200
    // 如果后端没有返回 code，则视为非标准响应，直接透传
    if (res && res.code !== undefined) {
      if (res.code === 200) {
        // 业务成功，直接返回 res.data，让 .then() 中可以直接使用核心数据
        return res.data;
      } else {
        // 业务失败 (res.code 不是 200)，例如用户名已存在、密码错误等
        // 统一弹出后端返回的错误消息
        ElMessage.error(res.msg || "操作失败");
        // 将业务失败作为一个 rejected Promise，这样代码会进入 .catch()
        return Promise.reject(new Error(res.msg || "Error"));
      }
    } else {
      // 对于非 ResponseResult 结构的响应（如下载文件等），直接返回 response
      return response;
    }
  },
  /**
   * HTTP 状态码不为 2xx 的情况，例如 401, 404, 500 等，会进入这里
   */
  (error) => {
    console.error('响应错误:', error);
    
    let errorMessage = "网络错误";

    if (error.response) {
      // 服务器返回了错误状态码
      switch (error.response.status) {
        case 401:
          errorMessage = "未授权，请重新登录";
          // 执行登出操作，并跳转到登录页
          const userStore = useUserStore();
          userStore.logout();
          // 延迟跳转，给提示留出显示时间
          setTimeout(() => {
            window.location.href = "/login";
          }, 1500);
          break;
        case 403:
          errorMessage = "您没有权限执行此操作";
          break;
        case 404:
          errorMessage = "请求的资源不存在";
          break;
        case 500:
          errorMessage = "服务器内部错误";
          break;
        default:
          // 后端如果直接抛出异常，错误信息可能在 error.response.data.message
          errorMessage =
            error.response.data?.msg ||
            error.response.data?.message ||
            "请求失败";
      }
    } else if (error.request) {
      errorMessage = "网络连接超时，请检查您的网络";
    } else {
      errorMessage = error.message;
    }

    // 统一弹出网络层面的错误提示
    ElMessage.error(errorMessage);

    return Promise.reject(error);
  }
);

// 导出常见的HTTP请求方法
export const http = {
  // GET请求
  get(url, params = {}) {
    return service({
      url,
      method: "get",
      params,
    });
  },

  // POST请求
  post(url, data = {}, params = {}) {
    return service({
      url,
      method: "post",
      data,
      params,
    });
  },

  // PUT请求
  put(url, data = {}, params = {}) {
    return service({
      url,
      method: "put",
      data,
      params,
    });
  },

  // DELETE请求
  delete(url, params = {}) {
    return service({
      url,
      method: "delete",
      params,
    });
  },

  // 上传文件
  upload(url, file, onUploadProgress) {
    const formData = new FormData();
    formData.append("file", file);

    return service({
      url,
      method: "post",
      data: formData,
      headers: {
        "Content-Type": "multipart/form-data",
      },
      onUploadProgress,
    });
  },

  // 下载文件
  download(url, params = {}) {
    return service({
      url,
      method: "get",
      params,
      responseType: "blob",
    });
  },
};

export default service;