<template>
  <div class="app-container">
    <!-- 筛选条件 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
      <el-form-item label="学年" prop="academicYear">
        <el-select v-model="queryParams.academicYear" placeholder="请选择学年" clearable style="width: 150px">
          <el-option label="2024-2025" value="2024-2025" />
          <el-option label="2023-2024" value="2023-2024" />
          <el-option label="2022-2023" value="2022-2023" />
        </el-select>
      </el-form-item>
      <el-form-item label="学期" prop="semester">
        <el-select v-model="queryParams.semester" placeholder="请选择学期" clearable style="width: 120px">
          <el-option label="第一学期" :value="1" />
          <el-option label="第二学期" :value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 成绩趋势图（所有角色都显示） -->
    <el-card shadow="never">
      <div slot="header">
        <span v-if="isTeacher || isAdmin">班级成绩趋势分析</span>
        <span v-else>我的成绩趋势</span>
      </div>
      <score-analysis-chart
        :student-id="currentStudentId"
        :class-id="currentClassId"
        :major-id="currentMajorId"
      />
    </el-card>

    <!-- 教师/辅导员角色：额外显示班级统计和排行榜 -->
    <template v-if="showTeacherView">
      <el-card shadow="never">
        <div slot="header"><span>班级统计数据</span></div>
        <el-table :data="statisticsList" border v-loading="loading">
          <el-table-column prop="majorName" label="专业" min-width="160" />
          <el-table-column prop="className" label="班级" min-width="120" />
          <el-table-column prop="totalCount" label="总人数" width="100" />
          <el-table-column prop="approvedCount" label="通过人数" width="120" />
          <el-table-column prop="avgScore" label="平均分" width="120">
            <template slot-scope="scope">
              {{ scope.row.avgScore ? scope.row.avgScore.toFixed(2) : '-' }}
            </template>
          </el-table-column>
          <el-table-column prop="maxScore" label="最高分" width="120">
            <template slot-scope="scope">
              {{ scope.row.maxScore ? scope.row.maxScore.toFixed(2) : '-' }}
            </template>
          </el-table-column>
          <el-table-column prop="minScore" label="最低分" width="120">
            <template slot-scope="scope">
              {{ scope.row.minScore ? scope.row.minScore.toFixed(2) : '-' }}
            </template>
          </el-table-column>
        </el-table>
      </el-card>

      <el-card shadow="never" style="margin-top: 20px;">
        <div slot="header"><span>班级排行榜</span></div>
        <el-table :data="rankingList" border v-loading="rankingLoading" max-height="500">
          <el-table-column type="index" label="序号" width="60" align="center" />
          <el-table-column prop="classRank" label="班级排名" width="100" align="center">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.classRank <= 3" :type="getRankTagType(scope.row.classRank)">
                {{ scope.row.classRank }}
              </el-tag>
              <span v-else>{{ scope.row.classRank }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="studentName" label="姓名" width="120" />
          <el-table-column prop="studentId" label="学号" width="150" />
          <el-table-column prop="totalScore" label="综合成绩" width="120" align="center">
            <template slot-scope="scope">
              <span style="font-weight: bold; color: #409EFF;">{{ scope.row.totalScore }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="intellectualScore" label="智育" width="100" align="center" />
          <el-table-column prop="moralScore" label="德育" width="100" align="center" />
          <el-table-column prop="physicalScore" label="体育" width="100" align="center" />
          <el-table-column prop="aestheticScore" label="美育" width="100" align="center" />
          <el-table-column prop="laborScore" label="劳育" width="100" align="center" />
        </el-table>
      </el-card>
    </template>
  </div>
</template>

<script>
// 导入我们重写好的图表组件
import ScoreAnalysisChart from '@/components/evaluation/ScoreAnalysisChart.vue';
import { getClassScoreStatistics, getClassRanking } from '@/api/evaluation/semesterScore';
import { mapGetters } from 'vuex';

export default {
  name: "Statistics",
  components: {
    ScoreAnalysisChart
  },
  data() {
    return {
      // 加载状态
      loading: false,
      rankingLoading: false,
      // 查询参数
      queryParams: {
        academicYear: '2024-2025',
        semester: 1
      },
      // 班级统计数据列表
      statisticsList: [],
      // 班级排行榜数据
      rankingList: [],
      // 用户档案信息
      userProfile: null
    };
  },
  computed: {
    // 从 Vuex 的 getters 中获取当前登录用户的信息
    ...mapGetters([
      'userId',
      'name',
      'dept',
      'roles'
    ]),

    // 判断是否为学生角色
    isStudent() {
      if (!this.roles || this.roles.length === 0) return true; // 默认为学生
      // 支持多种角色标识格式
      return this.roles.some(role => {
        const roleStr = typeof role === 'string' ? role : (role.roleKey || role.roleId || '');
        return roleStr.includes('student') || roleStr.includes('学生');
      });
    },

    // 判断是否为教师角色
    isTeacher() {
      if (!this.roles || this.roles.length === 0) return false;
      return this.roles.some(role => {
        const roleStr = typeof role === 'string' ? role : (role.roleKey || role.roleId || '');
        return roleStr.includes('teacher') || roleStr.includes('教师') || roleStr.includes('辅导员');
      });
    },

    // 判断是否为管理员角色
    isAdmin() {
      if (!this.roles || this.roles.length === 0) return false;
      return this.roles.some(role => {
        const roleStr = typeof role === 'string' ? role : (role.roleKey || role.roleId || '');
        return roleStr.includes('admin') || roleStr.includes('管理员');
      });
    },

    // 是否显示教师视图（统计和排行榜）
    showTeacherView() {
      return this.isTeacher || this.isAdmin;
    },

    // 动态计算当前学生ID
    currentStudentId() {
      return String(this.userId);
    },

    // 动态计算当前班级ID（使用部门名称）
    currentClassId() {
      return this.dept ? this.dept.deptName : null;
    },

    // 动态计算当前专业ID
    currentMajorId() {
      return this.userProfile ? this.userProfile.major : null;
    }
  },
  created() {
    // 调试信息：输出角色信息
    console.log('当前用户角色信息:', this.roles);
    console.log('是否为学生:', this.isStudent);
    console.log('是否为教师:', this.isTeacher);
    console.log('是否为管理员:', this.isAdmin);
    console.log('是否显示教师视图:', this.showTeacherView);

    // 根据角色加载不同的数据
    if (this.showTeacherView) {
      this.getClassStatistics();
      this.getClassRankingData();
    }
  },
  methods: {
    /** 查询班级统计数据 */
    getClassStatistics() {
      if (!this.dept || !this.dept.deptName) {
        this.$message.warning('无法获取班级信息');
        return;
      }

      this.loading = true;
      const params = {
        className: this.dept.deptName,
        academicYear: this.queryParams.academicYear,
        semester: this.queryParams.semester
      };

      getClassScoreStatistics(params).then(response => {
        const data = response.data || response;
        // 将统计数据转换为表格格式
        this.statisticsList = [{
          majorName: this.userProfile ? this.userProfile.major : '-',
          className: this.dept.deptName,
          totalCount: data.totalCount || 0,
          approvedCount: data.approvedCount || 0,
          avgScore: data.avgScore || 0,
          maxScore: data.maxScore || 0,
          minScore: data.minScore || 0
        }];
      }).catch(error => {
        console.error('获取班级统计数据失败:', error);
        this.$message.error('获取班级统计数据失败');
      }).finally(() => {
        this.loading = false;
      });
    },

    /** 查询班级排行榜数据 */
    getClassRankingData() {
      if (!this.dept || !this.dept.deptName) {
        this.$message.warning('无法获取班级信息');
        return;
      }

      this.rankingLoading = true;
      const params = {
        className: this.dept.deptName,
        academicYear: this.queryParams.academicYear,
        semester: this.queryParams.semester
      };

      getClassRanking(params).then(response => {
        this.rankingList = response.data || response.rows || [];
      }).catch(error => {
        console.error('获取班级排行榜失败:', error);
        this.$message.error('获取班级排行榜失败');
      }).finally(() => {
        this.rankingLoading = false;
      });
    },

    /** 获取排名标签类型 */
    getRankTagType(rank) {
      if (rank === 1) return 'danger';  // 第一名：红色
      if (rank === 2) return 'warning'; // 第二名：橙色
      if (rank === 3) return 'success'; // 第三名：绿色
      return 'info';
    },

    /** 搜索按钮操作 */
    handleQuery() {
      if (this.showTeacherView) {
        this.getClassStatistics();
        this.getClassRankingData();
      }
    },

    /** 重置按钮操作 */
    resetQuery() {
      this.queryParams = {
        academicYear: '2024-2025',
        semester: 1
      };
      this.handleQuery();
    }
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}
</style>
