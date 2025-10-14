import { defineStore } from 'pinia'

// [FIX] 创建一个安全的函数来初始化用户信息，避免 JSON.parse(null) 错误
function getInitialUserInfo() {
  try {
    const userInfoString = localStorage.getItem('userInfo');
    // 只有当本地存储中有值时，才进行解析
    if (userInfoString) {
      return JSON.parse(userInfoString);
    }
    // 否则返回 null
    return null;
  } catch (error) {
    console.error("从localStorage解析userInfo失败，数据可能已损坏:", error);
    // 如果解析出错，清理掉损坏的数据并返回null
    localStorage.removeItem('userInfo');
    return null;
  }
}

// 用户相关状态管理
export const useUserStore = defineStore('user', {
  state: () => ({
    // 优先从 localStorage 初始化状态，防止刷新页面后状态丢失
    token: localStorage.getItem('token') || '',
    // [FIXED] 使用上面创建的安全函数进行初始化
    userInfo: getInitialUserInfo(),
  }),
  getters: {
    isLoggedIn: (state) => !!state.token,
    getUserInfo: (state) => state.userInfo,
    getToken: (state) => state.token,
    getRoleId: (state) => {
      // 使用可选链操作符 ?. 来安全地访问 roleId，防止 userInfo 为 null 时报错
      return state.userInfo?.roleId || null;
    },
    isStudent: (state) => state.userInfo?.roleId === 2,
    isAdmin: (state) => state.userInfo?.roleId === 1,
    isLeader: (state) => state.userInfo?.roleId === 3
  },
  actions: {
    login(loginResponse) {
      console.log('在userStore.login中接收到的数据:', loginResponse);
      const { user, token, roleId } = loginResponse;
      console.log('解构后的数据:', { user, token, roleId });

      const fullUserInfo = { ...user, roleId };
      console.log('合并后的用户信息:', fullUserInfo);

      this.userInfo = fullUserInfo;
      this.token = token;

      localStorage.setItem('userInfo', JSON.stringify(fullUserInfo));
      localStorage.setItem('token', token);

      console.log('登录状态更新完成:', {
        token: this.token,
        userInfo: this.userInfo,
        roleId: this.getRoleId
      });
    },
    logout() {
      this.userInfo = null;
      this.token = '';
      localStorage.removeItem('userInfo');
      localStorage.removeItem('token');
      window.location.href = '/login';
    },
    updateUserInfo(newUserInfo) {
      this.userInfo = { ...this.userInfo, ...newUserInfo };
      localStorage.setItem('userInfo', JSON.stringify(this.userInfo));
    },
    refreshToken(newToken) {
      this.token = newToken;
      localStorage.setItem('token', newToken);
    }
  }
})