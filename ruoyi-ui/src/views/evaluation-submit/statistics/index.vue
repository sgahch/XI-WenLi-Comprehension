<template>
  <div class="app-container">
    <el-card shadow="never">
      <!-- 在这个页面里使用我们刚刚重写好的图表组件 -->
      <!-- 通过 props 将需要的 ID 传递给图表组件 -->
      <score-analysis-chart
        :student-id="currentStudentId"
        :class-id="currentClassId"
        :major-id="currentMajorId"
      />
    </el-card>

    <el-card shadow="never" style="margin-top: 20px;">
      <div slot="header"><span>班级统计数据示例</span></div>
      <el-table :data="list" border>
        <el-table-column prop="major" label="专业" min-width="160" />
        <el-table-column prop="className" label="班级" min-width="120" />
        <el-table-column prop="approvedCount" label="通过人数" width="120" />
        <el-table-column prop="avgScore" label="平均分" width="120" />
        <el-table-column prop="maxScore" label="最高分" width="120" />
        <el-table-column prop="minScore" label="最低分" width="120" />
      </el-table>
    </el-card>
  </div>
</template>

<script>
// 导入我们重写好的图表组件
import ScoreAnalysisChart from '@/components/evaluation/ScoreAnalysisChart.vue';
import { mapGetters } from 'vuex';

export default {
  name: "Statistics",
  components: {
    ScoreAnalysisChart
  },
  data() {
    return {
      // 这里的ID应该是动态获取的，我们用计算属性从Vuex获取
      // 如果您只想看某个特定学生/班级，可以写死ID
      list: [
        // TODO 示例数据，您可以从API获取
        { major: '软件工程', className: '软工 2201', approvedCount: 30, avgScore: 86.5, maxScore: 98.0, minScore: 70.0 }
      ]
    };
  },
  computed: {
    // 从 Vuex 的 getters 中获取当前登录用户的信息
    ...mapGetters([
      'userId', // 假设Vuex中存储了用户ID
      'userInfo' // 假设Vuex中存储了包含 classId 和 majorId 的用户信息
    ]),

    // 动态计算当前学生ID
    currentStudentId() {
      // 在若依中，通常可以直接用 this.userId
      return String(this.userId); // 确保是字符串类型
    },

    // 动态计算当前班级ID
    currentClassId() {
      // 假设用户信息对象中有 classId 字段
      return this.userInfo ? this.userInfo.classId : null;
    },

    // 动态计算当前专业ID
    currentMajorId() {
      // 假设用户信息对象中有 majorId 字段
      return this.userInfo ? this.userInfo.majorId : null;
    }
  },
  created() {
    // 您可以在这里调用API加载下面的表格数据
  }
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}
</style>
