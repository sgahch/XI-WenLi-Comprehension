<template>
  <div class="detail-container">
    <el-descriptions title="填报详情" :column="2" border>
      <el-descriptions-item label="学年">{{ record.academicYear }}</el-descriptions-item>
      <el-descriptions-item label="学期">{{ record.semester }}</el-descriptions-item>
      <el-descriptions-item label="状态">{{ record.submissionStatus }}</el-descriptions-item>
      <el-descriptions-item label="总分">{{ record.totalScore }}</el-descriptions-item>
      <el-descriptions-item label="提交时间">{{ record.submitTime }}</el-descriptions-item>
      <el-descriptions-item label="自我评价" :span="2">{{ record.selfEvaluation || '—' }}</el-descriptions-item>
    </el-descriptions>

    <div class="detail-toolbar">
      <el-button type="primary" v-hasPermi="['evaluation:submission:query']">刷新</el-button>
      <el-button v-hasPermi="['evaluation:attachment:download']">下载附件</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: "SubmissionDetail",
  props: {
    record: {
      type: Object,
      default: () => ({})
    }
  }
}
</script>

<style scoped>
.detail-container { padding: 8px; }
.detail-toolbar { margin-top: 12px; display: flex; gap: 8px; }
</style>