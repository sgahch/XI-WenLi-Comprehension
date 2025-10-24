<template>
  <div class="detail-container">
    <el-descriptions title="审核详情" :column="2" border>
      <el-descriptions-item label="学生">{{ record.userName }}</el-descriptions-item>
      <el-descriptions-item label="学年">{{ record.academicYear }}</el-descriptions-item>
      <el-descriptions-item label="学期">{{ record.semester }}</el-descriptions-item>
      <el-descriptions-item label="状态">{{ record.submissionStatus }}</el-descriptions-item>
      <el-descriptions-item label="总分">{{ record.totalScore }}</el-descriptions-item>
      <el-descriptions-item label="提交时间" :span="2">{{ record.submitTime || '—' }}</el-descriptions-item>
      <el-descriptions-item label="审核意见" :span="2">{{ record.auditComment || '—' }}</el-descriptions-item>
    </el-descriptions>

    <div class="detail-toolbar">
      <el-button type="success" v-hasPermi="['evaluation:audit:approve']">通过</el-button>
      <el-button type="danger" v-hasPermi="['evaluation:audit:reject']">驳回</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: "AuditDetail",
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