<template>
  <div class="login-container" :class="{ 'dark-mode': isDarkMode }">
    <!-- 主题切换按钮 -->
    <div class="theme-toggle">
      <el-tooltip :content="isDarkMode ? '切换到浅色模式' : '切换到深色模式'" placement="left">
        <el-button
            type="text"
            class="theme-toggle-btn"
            @click="toggleTheme"
        >
          <el-icon><component :is="themeIcon" /></el-icon>
        </el-button>
      </el-tooltip>
    </div>
    <!-- 背景装饰 -->
    <div class="login-bg">
      <div class="bg-decoration">
        <div class="decoration-circle circle-1"></div>
        <div class="decoration-circle circle-2"></div>
        <div class="decoration-circle circle-3"></div>
        <div class="decoration-wave"></div>
      </div>
    </div>

    <!-- 登录面板 -->
    <div class="login-panel animate-fadeIn">
      <!-- 系统Logo和标题 -->
      <div class="login-header">
        <div class="logo-container">
          <div class="logo-icon">
            <el-icon size="48"><School /></el-icon>
          </div>
          <div class="logo-text">
            <h1 class="system-title">综合测评系统</h1>
            <p class="system-subtitle">
              University Comprehensive Evaluation System
            </p>
          </div>
        </div>
      </div>

      <!-- 欢迎信息 -->
      <div class="welcome-section">
        <h2 class="welcome-title">欢迎回来</h2>
        <p class="welcome-desc">请登录您的账户以继续使用系统</p>
      </div>

      <!-- 登录表单 -->
      <el-form
          ref="loginFormRef"
          :model="loginForm"
          :rules="loginRules"
          class="login-form"
          label-position="top"
          @keyup.enter="handleLogin"
      >
        <el-form-item prop="username" label="学号/工号" class="form-item-enhanced">
          <el-input
              v-model="loginForm.username"
              placeholder="请输入学号/工号"
              clearable
              autofocus
              size="large"
              class="input-enhanced"
          >
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item prop="password" label="密码" class="form-item-enhanced">
          <el-input
              v-model="loginForm.password"
              type="password"
              placeholder="请输入密码"
              clearable
              show-password
              size="large"
              class="input-enhanced"
          >
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <!-- [新增] 验证码输入框 -->
        <el-form-item prop="code" label="验证码" v-if="captchaEnabled" class="form-item-enhanced">
          <div style="display: flex; width: 100%; gap: 16px;">
            <el-input
                v-model="loginForm.code"
                placeholder="请输入右侧验证码"
                clearable
                size="large"
                class="input-enhanced"
                style="flex: 1;"
            >
              <template #prefix>
                <el-icon><Key /></el-icon>
              </template>
            </el-input>
            <div class="login-code">
              <img :src="codeUrl" @click="getCode" class="login-code-img" title="点击刷新"/>
            </div>
          </div>
        </el-form-item>


        <div class="form-options">
          <el-checkbox v-model="loginForm.remember" class="remember-checkbox">
            记住我
          </el-checkbox>
          <el-link
              type="primary"
              @click.prevent="handleForgotPassword"
              class="forgot-link"
          >
            忘记密码？
          </el-link>
        </div>

        <el-form-item class="login-button-item">
          <el-button
              type="primary"
              class="login-btn btn-gradient"
              :loading="loading"
              @click="handleLogin"
              :disabled="loading"
              size="large"
          >
            <span v-if="!loading">
              <el-icon><Right /></el-icon>
              立即登录
            </span>
            <span v-else>
              <el-icon class="animate-spin"><Loading /></el-icon>
              登录中...
            </span>
          </el-button>
        </el-form-item>
      </el-form>

      <!-- 页脚信息 -->
      <div class="login-footer">
        <div class="copyright">© 2025 大学生综合测评系统 版权所有</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { useUserStore, useThemeStore } from "../store/index.js";
import { ElMessage } from "element-plus";
// [修改] 导入若依的登录相关API和工具
import { login, getCodeImg } from "../api/login.js";
import { encrypt } from '../utils/jsencrypt';

const router = useRouter();
const userStore = useUserStore();
const themeStore = useThemeStore();
const loginFormRef = ref(null);

const isDarkMode = computed(() => themeStore.isDark);
const themeIcon = computed(() => themeStore.themeIcon);
const toggleTheme = () => themeStore.toggleTheme();

const loginForm = reactive({
  username: "",
  password: "",
  remember: false,
  code: "",       // 验证码
  uuid: ""        // 验证码唯一标识
});

// 验证码相关状态
const codeUrl = ref("");
const captchaEnabled = ref(true);

const loginRules = {
  username: [{ required: true, message: "请输入学号/工号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
  code: [{ required: true, message: "请输入验证码", trigger: "blur" }]
};

const loading = ref(false);

// 获取验证码的方法
const getCode = async () => {
  try {
    const res = await getCodeImg();
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled;
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img;
      loginForm.uuid = res.uuid;
    }
  } catch (error) {
    console.error("获取验证码失败:", error);
    ElMessage.error("获取验证码失败，请刷新页面重试");
  }
};

const handleLogin = () => {
  if (!loginFormRef.value) return;

  loginFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true;
      try {
        // 构造符合若依后端要求的数据
        // 注意：若依后端login API需要传递四个独立参数，而不是一个对象
        const result = await login(
          loginForm.username.trim(),
          // encrypt(loginForm.password), // 使用RSA加密密码
          loginForm.password,
          loginForm.code,
          loginForm.uuid
        );

        if (result.code === 200) {
          ElMessage.success("登录成功！");
          
          // 存储token等信息
          userStore.login(result);
          
          // 记住我功能 (使用 localStorage)
          if (loginForm.remember) {
            localStorage.setItem("loginForm", JSON.stringify({
              username: loginForm.username,
              password: loginForm.password,
              remember: true
            }));
          } else {
            localStorage.removeItem("loginForm");
          }

          // 登录成功后跳转到学生首页
          router.push("/student/dashboard");


        } else {
          ElMessage.error(result.msg || "登录失败，请检查您的输入");
          // 登录失败后刷新验证码
          if (captchaEnabled.value) {
            getCode();
          }
        }
      } catch (error) {
        console.error("登录流程失败:", error);
        ElMessage.error(error.message || "登录失败，请检查您的输入");
        // 登录失败后刷新验证码
        if (captchaEnabled.value) {
          getCode();
        }
      } finally {
        loading.value = false;
      }
    } else {
      ElMessage.error("请检查输入项是否完整且正确");
      return false;
    }
  });
};

const handleForgotPassword = () => {
  ElMessage.info("忘记密码功能即将上线，请联系管理员重置密码");
};

const initLoginForm = () => {
  try {
    const savedForm = localStorage.getItem("loginForm");
    if (savedForm) {
      const parsedForm = JSON.parse(savedForm);
      if (parsedForm.remember) {
        loginForm.username = parsedForm.username || "";
        loginForm.password = parsedForm.password || "";
        loginForm.remember = true;
      }
    }
  } catch (error) {
    console.error("读取记住的登录信息失败:", error);
  }
};

onMounted(() => {
  initLoginForm();
  // [新增] 页面加载时获取验证码
  getCode();
});
</script>

<style scoped>
/* [新增] 验证码图片样式 */
.login-code {
  width: 120px;
  height: 40px; /* 与el-input size="large" 高度一致 */
  cursor: pointer;
}
.login-code-img {
  width: 100%;
  height: 100%;
  border-radius: 12px; /* 与你的输入框样式保持一致 */
}

/* ===== 以下是你原有的全部样式，无需改动 ===== */
.login-container {
  min-height: 100vh;
  width: 100vw;
  display: flex;
  position: relative;
  overflow: hidden;
  transition: all var(--transition-base);
}
.theme-toggle {
  position: fixed;
  top: 24px;
  right: 24px;
  z-index: 1000;
}
.theme-toggle-btn {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: white;
  font-size: 20px;
  transition: all var(--transition-base);
  display: flex;
  align-items: center;
  justify-content: center;
}
.theme-toggle-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: scale(1.1);
  box-shadow: var(--shadow-base);
}
.dark-mode .theme-toggle-btn {
  background: rgba(0, 0, 0, 0.3);
  border-color: rgba(255, 255, 255, 0.2);
}
.dark-mode .theme-toggle-btn:hover {
  background: rgba(0, 0, 0, 0.5);
}
.login-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
  z-index: 1;
}
.bg-decoration {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
}
.decoration-circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  animation: float 6s ease-in-out infinite;
}
.circle-1 { width: 200px; height: 200px; top: 10%; left: 10%; animation-delay: 0s; }
.circle-2 { width: 150px; height: 150px; top: 60%; left: 80%; animation-delay: 2s; }
.circle-3 { width: 100px; height: 100px; top: 80%; left: 20%; animation-delay: 4s; }
.decoration-wave {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100px;
  background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1200 120'%3E%3Cpath d='M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z' fill='rgba(255,255,255,0.1)'%3E%3C/path%3E%3C/svg%3E") repeat-x;
  animation: wave 10s linear infinite;
}
@keyframes float { 0%, 100% { transform: translateY(0px) rotate(0deg); } 50% { transform: translateY(-20px) rotate(180deg); } }
@keyframes wave { 0% { background-position-x: 0; } 100% { background-position-x: 1200px; } }
.login-panel { position: relative; z-index: 10; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border-radius: 24px; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1); padding: 48px; width: 100%; max-width: 480px; margin: auto; border: 1px solid rgba(255, 255, 255, 0.2); }
.login-header { text-align: center; margin-bottom: 32px; }
.logo-container { display: flex; flex-direction: column; align-items: center; gap: 16px; }
.logo-icon { width: 80px; height: 80px; background: var(--primary-gradient); border-radius: 20px; display: flex; align-items: center; justify-content: center; color: white; box-shadow: 0 8px 24px rgba(64, 158, 255, 0.3); animation: logoGlow 2s ease-in-out infinite alternate; }
@keyframes logoGlow { 0% { box-shadow: 0 8px 24px rgba(64, 158, 255, 0.3); } 100% { box-shadow: 0 12px 32px rgba(64, 158, 255, 0.5); } }
.logo-text { text-align: center; }
.system-title { font-size: 28px; font-weight: 700; color: var(--text-primary); margin: 0 0 8px 0; background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
.system-subtitle { font-size: 14px; color: var(--text-secondary); margin: 0; font-weight: 400; }
.welcome-section { text-align: center; margin-bottom: 32px; }
.welcome-title { font-size: 24px; font-weight: 600; color: var(--text-primary); margin: 0 0 8px 0; }
.welcome-desc { font-size: 16px; color: var(--text-regular); margin: 0; }
.login-form { width: 100%; }
.form-item-enhanced { margin-bottom: 24px; }
.form-item-enhanced :deep(.el-form-item__label) { font-weight: 600; color: var(--text-primary); margin-bottom: 8px; }
.input-enhanced :deep(.el-input__wrapper) { border-radius: 12px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04); border: 1px solid var(--border-light); transition: all var(--transition-base); }
.input-enhanced :deep(.el-input__wrapper:hover) { border-color: var(--primary-color); box-shadow: 0 4px 12px rgba(64, 158, 255, 0.1); }
.input-enhanced :deep(.el-input__wrapper.is-focus) { border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(64, 158, 255, 0.1); }
.select-enhanced :deep(.el-select__wrapper) { border-radius: 12px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04); border: 1px solid var(--border-light); transition: all var(--transition-base); }
.form-options { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
.remember-checkbox :deep(.el-checkbox__label) { color: var(--text-regular); font-weight: 500; }
.forgot-link { font-weight: 500; text-decoration: none; }
.forgot-link:hover { text-decoration: underline; }
.login-button-item { margin-bottom: 0; }
.login-btn { width: 100%; height: 48px; border-radius: 12px; font-size: 16px; font-weight: 600; border: none; position: relative; overflow: hidden; }
.login-btn:before { content: ""; position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent); transition: left 0.5s; }
.login-btn:hover:before { left: 100%; }
.login-footer { margin-top: 32px; text-align: center; }
.copyright { font-size: 12px; color: var(--text-placeholder); }
@media (max-width: 1200px) { .login-container { justify-content: center; align-items: center; padding: 20px; } }
@media (max-width: 768px) { .login-panel { padding: 32px 24px; margin: 20px; max-width: none; } .system-title { font-size: 24px; } .welcome-title { font-size: 20px; } .logo-icon { width: 60px; height: 60px; } .logo-icon :deep(.el-icon) { font-size: 32px; } }
@media (max-width: 480px) { .login-panel { padding: 24px 16px; border-radius: 16px; } .form-options { flex-direction: column; gap: 16px; align-items: flex-start; } }
</style>