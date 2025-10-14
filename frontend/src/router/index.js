import { createRouter, createWebHistory } from 'vue-router'
import { ElMessage } from 'element-plus' // 导入ElMessage用于提示

// 导入组件
const Login = () => import('../views/Login.vue')
const Home = () => import('../views/Home.vue')
const StudentDashboard = () => import('../views/student/Dashboard.vue')
const AdminDashboard = () => import('../views/admin/Dashboard.vue')
const LeaderDashboard = () => import('../views/leader/Dashboard.vue')
const PersonalInfo = () => import('../views/student/PersonalInfo.vue')
const EvaluationApplication = () => import('../views/student/EvaluationApplication.vue')
const ScoreQuery = () => import('../views/student/ScoreQuery.vue')
const AppealSubmission = () => import('../views/student/AppealSubmission.vue')
const Schedule = () => import('../views/student/Schedule.vue')
const Notifications = () => import('../views/shared/Notifications.vue')

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta: { requiresAuth: false }
  },
  {
    path: '/home',
    name: 'Home',
    component: Home,
    meta: {
      requiresAuth: true,
      title: '首页'
    },
    children: [
      // 学生端路由
      { path: '/student/dashboard', name: 'StudentDashboard', component: StudentDashboard, meta: { requiresAuth: true, role: 'student', title: '学生控制台' } },
      { path: '/student/personal-info', name: 'PersonalInfo', component: PersonalInfo, meta: { requiresAuth: true, role: 'student', title: '个人信息' } },
      { path: '/student/evaluation-application', name: 'EvaluationApplication', component: EvaluationApplication, meta: { requiresAuth: true, role: 'student', title: '测评项目周报' } },
      { path: '/student/score-query', name: 'ScoreQuery', component: ScoreQuery, meta: { requiresAuth: true, role: 'student', title: '成绩查询' } },
      { path: '/student/appeal', name: 'AppealSubmission', component: AppealSubmission, meta: { requiresAuth: true, role: 'student', title: '成绩申诉' } },
      { path: '/student/schedule', name: 'Schedule', component: Schedule, meta: { requiresAuth: true, role: 'student', title: '测评日程安排' } },
      // 管理端路由
      { path: '/admin/dashboard', name: 'AdminDashboard', component: AdminDashboard, meta: { requiresAuth: true, role: 'admin', title: '管理控制台' } },
      // 领导端路由
      { path: '/leader/dashboard', name: 'LeaderDashboard', component: LeaderDashboard, meta: { requiresAuth: true, role: 'leader', title: '领导控制台' } },
      // 共享路由
      { path: '/notifications', name: 'Notifications', component: Notifications, meta: { requiresAuth: true, title: '通知公告' } }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

// 路由守卫 - 最终修复版本（彻底解决重定向问题）
router.beforeEach(async (to, from, next) => {
  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} - 大学生综合测评系统` : '大学生综合测评系统';

  try {
    // 【关键修复】：动态导入 store，确保 Pinia 已经初始化
    const { useUserStore } = await import('../store');
    const userStore = useUserStore();
    const isLoggedIn = userStore.isLoggedIn;

    // 如果访问根路径，直接重定向到登录页
    if (to.path === '/') {
      next('/login');
      return;
    }

    if (to.meta.requiresAuth) {
      // 目标路由需要认证
      if (!isLoggedIn) {
        // 用户未登录，重定向到登录页
        next({ 
          path: '/login', 
          query: to.fullPath !== '/login' ? { redirect: to.fullPath } : undefined 
        });
        return;
      } else {
        // 用户已登录，检查角色权限
        if (to.meta.role) {
          const userRoleId = userStore.getRoleId;

          // 定义前端角色字符串与后端角色ID的映射关系
          const roleMap = {
            'admin': 1,
            'student': 2,
            'leader': 3
          };

          const requiredRoleId = roleMap[to.meta.role];

          if (userRoleId === requiredRoleId) {
            // 角色匹配，允许访问
            next();
            return;
          } else {
            // 角色不匹配，提示无权限并阻止导航
            ElMessage.error('您没有权限访问此页面');
            
            // 重定向到用户对应的默认页面
            let defaultPath = '/login';
            switch(userRoleId) {
              case 1: defaultPath = '/admin/dashboard'; break;
              case 2: defaultPath = '/student/dashboard'; break;
              case 3: defaultPath = '/leader/dashboard'; break;
            }
            
            if (from.path === '/login' || from.path === '/') {
              next(defaultPath);
            } else {
              next(false); // 阻止导航
            }
            return;
          }
        } else {
          // 页面需要认证但不需要特定角色，直接放行
          next();
          return;
        }
      }
    } else {
      // 目标页面不需要认证（例如登录页本身）
      if (isLoggedIn && to.name === 'Login') {
        // 如果用户已登录，但试图访问登录页，则重定向到对应的控制台
        const userRoleId = userStore.getRoleId;
        let dashboardPath = '/';
        
        switch(userRoleId) {
          case 1: dashboardPath = '/admin/dashboard'; break;
          case 2: dashboardPath = '/student/dashboard'; break;
          case 3: dashboardPath = '/leader/dashboard'; break;
          default: dashboardPath = '/'; break;
        }
        
        next(dashboardPath);
        return;
      } else {
        next();
        return;
      }
    }
  } catch (error) {
    console.error('💥 路由守卫执行出错:', error);
    console.error('错误详情:', error.stack);
    
    // 出错时强制重定向到登录页，避免白屏
    ElMessage.error('系统初始化失败，请刷新页面重试');
    next('/login');
  }
});

export default router;
