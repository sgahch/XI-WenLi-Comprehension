<template>
  <div class="app-container home">
    <!-- Hero Banner Section -->
    <div class="hero-banner">
      <div class="hero-content">
        <h2>西安文理学院综合测评管理系统</h2>
        <p class="subtitle">Comprehensive Assessment Management System</p>
      </div>
    </div>

    <el-row :gutter="20">
      <!-- Main Content Area (2/3 width) -->
      <el-col :lg="16" :md="24">
        <!-- Quick Access Modules -->
        <el-card shadow="never" class="info-card">
          <div class="section-title">
            <i class="el-icon-menu"></i>
            <h3>核心功能模块</h3>
            <span class="en-title">CORE MODULES</span>
          </div>
          <ul class="quick-access-list">
            <li v-for="item in coreModules" :key="item.title" @click="handleModuleClick(item)">
              <div class="module-info">
                <i :class="item.icon"></i>
                <div class="module-text">
                  <h4>{{ item.title }}</h4>
                  <p>{{ item.desc }}</p>
                </div>
              </div>
              <i class="el-icon-arrow-right"></i>
            </li>
          </ul>
        </el-card>

        <!-- Technical Stack -->
        <el-card shadow="never" class="info-card">
          <div class="section-title">
            <i class="el-icon-cpu"></i>
            <h3>技术架构</h3>
            <span class="en-title">TECHNICAL ARCHITECTURE</span>
          </div>
          <el-row :gutter="20">
            <el-col :span="12">
              <h4>前端技术</h4>
              <ul class="tech-list">
                <li>Vue</li>
                <li>Element UI</li>
                <li>SCSS</li>
                <li>Axios</li>
              </ul>
            </el-col>
            <el-col :span="12">
              <h4>后端技术</h4>
              <ul class="tech-list">
                <li>SpringBoot</li>
                <li>MyBatis-Plus</li>
                <li>MySQL</li>
                <li>Shiro</li>
              </ul>
            </el-col>
          </el-row>
        </el-card>

      </el-col>

      <!-- Sidebar Area (1/3 width) -->
      <el-col :lg="8" :md="24">
        <!-- System Updates -->
        <el-card shadow="never" class="info-card">
          <div class="section-title">
            <i class="el-icon-bell"></i>
            <h3>系统公告</h3>
            <span class="en-title">SYSTEM NOTICE</span>
          </div>
          <ul class="update-list">
            <li v-for="update in systemUpdates" :key="update.id" @click="goNotice">
              <span>{{ update.title }}</span>
              <span class="date">{{ update.date }}</span>
            </li>
          </ul>
          <div class="more-link" @click="goNotice">MORE →</div>
        </el-card>

        <!-- Contact Info -->
        <el-card shadow="never" class="info-card">
          <div class="section-title">
            <i class="el-icon-phone-outline"></i>
            <h3>联系我们</h3>
            <span class="en-title">CONTACT US</span>
          </div>
          <div class="contact-info">
            <p><i class="el-icon-office-building"></i> 负责部门：教务处</p>
            <p><i class="el-icon-phone"></i> 联系电话：029-8888XXXX</p>
            <p><i class="el-icon-message"></i> 办公地址：行政楼XXX室</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Footer -->
    <div class="footer">
      <p>© 2025 西安文理学院 教务处 版权所有 | 系统版本: v{{ version }}</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      version: "1.0.0",
      coreModules: [
        { title: '学生管理', desc: '管理学生基本信息、班级、专业等', icon: 'el-icon-user-solid', path: '/system/user' },
        { title: '测评指标', desc: '灵活配置各维度测评指标及权重', icon: 'el-icon-s-order', path: '/evaluation/t_evaluation' },
        { title: '成绩计算', desc: '自动汇总数据，计算综合成绩与排名', icon: 'el-icon-s-data', path: '/evaluation/t_student_total_score' },
        { title: '结果公示', desc: '支持多轮公示与异议处理', icon: 'el-icon-s-claim', name: 'ResultPublicity' },
      ],
      systemUpdates: [
        { id: 1, title: '关于2025学年第一学期综测工作通知', date: '2025-09-28' },
        { id: 2, title: '系统V1.1版本功能更新预告', date: '2025-09-25' },
        { id: 3, title: '国庆节假期系统维护公告', date: '2025-09-22' },
        { id: 4, title: '如何正确提交申诉材料的说明', date: '2025-09-19' },
      ]
    };
  },
  methods: {
    handleModuleClick(item) {
      this.$message.info(`正在跳转到 [${item.title}] 模块...`);
      // In a real application, you would use Vue Router:
      this.$router.push({ path: item.path });
    },
    goNotice() {
      this.$message.info('跳转到系统公告页面');
    }
  },
};
</script>

<style scoped lang="scss">
// 这是一些基础变量，可以根据需要调整
:root {
  --xawl-blue: #1e88e5; // A modern, friendly blue
  --xawl-text-primary: #303133;
  --xawl-text-secondary: #606266;
  --xawl-text-light: #909399;
  --xawl-border-color: #e4e7ed;
  --xawl-bg-light: #f5f7fa;
}

.home {
  padding: 15px;
  background-color: var(--xawl-bg-light);
}

// 横幅样式
.hero-banner {
  height: 490px; // 调整横幅高度
  border-radius: 8px;
  margin-bottom: 20px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  overflow: hidden; // Ensures pseudo-element doesn't overflow

  // 这是横幅背景图片,可以设置大小和位置
  background-image: url('https://www.xawl.edu.cn/image/subbanner.png');
  background-size: cover;
  background-position: center;

  // 这是一个半透明的黑色覆盖层，增加文字可读性
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4); // Semi-transparent black
    z-index: 1;
  }
}

// 横幅内容
.hero-content {
  position: relative;
  z-index: 2; // Above the overlay
  text-align: center;
  h2 {
    font-size: 32px;
    font-weight: 600;
    margin: 0;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
  }
  .subtitle {
    font-size: 16px;
    margin: 10px 0 0;
    opacity: 0.9;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
  }
}


// General Card Style
.info-card {
  margin-bottom: 20px;
  border: none;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

// Section Title Style (like "校园动态 / CAMPUS DYNAMICS")
.section-title {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--xawl-border-color);

  i {
    font-size: 24px;
    color: var(--xawl-blue);
    margin-right: 12px;
  }

  h3 {
    font-size: 20px;
    color: var(--xawl-text-primary);
    margin: 0;
    font-weight: 600;
  }

  .en-title {
    font-size: 12px;
    color: var(--xawl-text-light);
    margin-left: 10px;
    font-weight: 500;
    letter-spacing: 0.5px;
  }
}

// Quick Access List Style
.quick-access-list {
  list-style-type: none;
  padding: 0;
  margin: 0;
  li {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 15px 10px;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;

    &:hover {
      background-color: var(--xawl-bg-light);
      transform: scale(1.02);
    }

    .module-info {
      display: flex;
      align-items: center;
    }

    i:first-child { // icon for module
      font-size: 28px;
      color: var(--xawl-blue);
      margin-right: 15px;
      width: 40px;
      text-align: center;
    }

    .module-text {
      h4 {
        margin: 0 0 5px;
        font-size: 16px;
        color: var(--xawl-text-primary);
        font-weight: 500;
      }
      p {
        margin: 0;
        font-size: 13px;
        color: var(--xawl-text-secondary);
      }
    }

    i.el-icon-arrow-right {
      color: var(--xawl-text-light);
      font-size: 16px;
    }
  }
}

// System Updates List (News-like)
.update-list {
  list-style: none;
  padding: 0;
  margin: 0;
  li {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 5px;
    border-bottom: 1px dashed var(--xawl-border-color);
    cursor: pointer;
    font-size: 14px;
    transition: color 0.3s ease;

    &:last-child {
      border-bottom: none;
    }

    &:hover {
      color: var(--xawl-blue);
    }

    span {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      margin-right: 10px;
    }

    .date {
      color: var(--xawl-text-light);
      font-size: 13px;
      flex-shrink: 0;
    }
  }
}

.more-link {
  text-align: right;
  margin-top: 15px;
  font-size: 14px;
  color: var(--xawl-text-secondary);
  cursor: pointer;
  &:hover {
    color: var(--xawl-blue);
  }
}

// Technical Stack List Style
.tech-list {
  list-style: none;
  padding-left: 0;
  h4 {
    font-size: 16px;
    color: var(--xawl-text-primary);
    margin-bottom: 10px;
    font-weight: 500;
  }
  li {
    font-size: 14px;
    color: var(--xawl-text-secondary);
    padding: 8px 0 8px 18px;
    position: relative;
    &:before {
      content: "•";
      position: absolute;
      left: 0;
      top: 8px;
      color: var(--xawl-blue);
      font-size: 16px;
      line-height: 1;
    }
  }
}

// Contact Info Style
.contact-info {
  p {
    font-size: 14px;
    color: var(--xawl-text-secondary);
    margin: 0 0 12px;
    display: flex;
    align-items: center;
    i {
      margin-right: 10px;
      color: var(--xawl-blue);
      font-size: 16px;
    }
  }
}


// Footer Style
.footer {
  text-align: center;
  padding: 20px 0;
  color: var(--xawl-text-light);
  font-size: 13px;
  margin-top: 10px;
}

// Responsive adjustments
@media (max-width: 992px) {
  .info-card {
    // Add margin for stacked cards on smaller screens
    margin-left: 10px;
    margin-right: 10px;
  }
  .hero-content h2 {
    font-size: 24px;
  }
}
</style>
