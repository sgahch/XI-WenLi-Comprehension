<template>
  <div class="detail-container">
    <!-- 顶部基础信息 -->
    <el-descriptions title="填报详情" :column="2" border>
      <el-descriptions-item label="学年">{{ record.academicYear || '—' }}</el-descriptions-item>
      <el-descriptions-item label="学期">{{ semesterText }}</el-descriptions-item>
      <el-descriptions-item label="状态">{{ statusText }}</el-descriptions-item>
      <el-descriptions-item label="总分">{{ displayTotalScore }}</el-descriptions-item>
      <el-descriptions-item label="提交时间">{{ record.submitTime || record.createTime || '—' }}</el-descriptions-item>
      <el-descriptions-item label="审核时间">{{ record.auditTime || '—' }}</el-descriptions-item>
      <el-descriptions-item label="备注" :span="2">{{ record.remark || '—' }}</el-descriptions-item>
    </el-descriptions>

    <!-- 分维度汇总分数 -->
    <el-card shadow="never" class="section-card">
      <div slot="header" class="section-header">
        <i class="el-icon-data-analysis"></i>
        <span>分维度分数</span>
      </div>
      <el-table :data="dimensionSummary" border size="small">
        <el-table-column prop="name" label="维度" width="120" />
        <el-table-column prop="score" label="分数" width="120">
          <template slot-scope="scope">{{ scope.row.score.toFixed(2) }}</template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 自我评价 -->
    <el-card shadow="never" class="section-card">
      <div slot="header" class="section-header">
        <i class="el-icon-edit"></i>
        <span>自我评价</span>
      </div>
      <div class="self-eval">{{ (record && record.selfEvaluation) || '—' }}</div>
    </el-card>

    <!-- 明细列表（按维度折叠） -->
    <el-card shadow="never" class="section-card" v-loading="loading">
      <div slot="header" class="section-header">
        <i class="el-icon-document"></i>
        <span>条目明细</span>
      </div>
      <el-collapse v-model="activePanels">
        <el-collapse-item v-for="(items, dim) in groupedDetails" :key="dim" :name="dim">
          <template slot="title">
            <span class="collapse-title">{{ dimensionNameMap[dim] || dim }}</span>
          </template>
          <el-table :data="items" border size="small">
            <el-table-column label="类别" min-width="160">
              <template slot-scope="scope">{{ scope.row.ruleSnapshot && scope.row.ruleSnapshot.category }}</template>
            </el-table-column>
            <el-table-column label="项目" min-width="160">
              <template slot-scope="scope">{{ scope.row.ruleSnapshot && scope.row.ruleSnapshot.itemName }}</template>
            </el-table-column>
            <el-table-column prop="finalScore" label="分数" width="120">
              <template slot-scope="scope">{{ (scope.row.finalScore || 0).toFixed(2) }}</template>
            </el-table-column>
            <el-table-column prop="remark" label="备注" min-width="160">
              <template slot-scope="scope">{{ scope.row.remark || '—' }}</template>
            </el-table-column>
            <el-table-column label="附件" min-width="160">
              <template slot-scope="scope">
                <span v-if="!scope.row.attachments || scope.row.attachments.length === 0">—</span>
                <div v-else class="attachments">
                  <el-link
                    v-for="(att, idx) in scope.row.attachments"
                    :key="idx"
                    :underline="false"
                    :href="getAttachmentHref(att)"
                    target="_blank"
                  >{{ getAttachmentName(att, idx) }}</el-link>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </el-collapse-item>
      </el-collapse>
    </el-card>

    <div class="detail-toolbar">
      <el-button type="primary" @click="reload" v-hasPermi="['evaluation:submission:query']">刷新</el-button>
    </div>
  </div>
</template>

<script>
import { getSubmissionDetail } from '@/api/evaluation/submission'

export default {
  name: 'SubmissionDetail',
  props: {
    record: { type: Object, default: () => ({}) }
  },
  data() {
    return {
      loading: false,
      detail: null,
      activePanels: [],
      dimensionNameMap: {
        moral: '德育',
        intellectual: '智育',
        physical: '体育',
        aesthetic: '美育',
        labor: '劳育'
      }
    }
  },
  computed: {
    semesterText() {
      const s = this.record && this.record.semester
      if (s === 1) return '第一学期'
      if (s === 2) return '第二学期'
      return '—'
    },
    statusText() {
      const map = { 0: '草稿', 1: '待班委审核', 2: '待辅导员审核', 3: '已通过', 4: '已驳回' }
      return map[this.record && this.record.status] || '—'
    },
    displayTotalScore() {
      if (this.record && this.record.totalScore != null) return this.record.totalScore
      const sum = this.dimensionSummary.reduce((s, i) => s + i.score, 0)
      return sum.toFixed(2)
    },
    groupedDetails() {
      const details = (this.detail && this.detail.details) || []
      const groups = {}
      details.forEach(d => {
        const dim = d.ruleSnapshot && d.ruleSnapshot.dimension
        if (!dim) return
        if (!groups[dim]) groups[dim] = []
        groups[dim].push(d)
      })
      return groups
    },
    dimensionSummary() {
      const groups = this.groupedDetails
      const entries = Object.keys(groups)
      if (entries.length > 0) {
        const res = []
        entries.forEach(dim => {
          const score = groups[dim].reduce((sum, item) => sum + (item.finalScore || 0), 0)
          res.push({ name: this.dimensionNameMap[dim] || dim, score })
        })
        return res
      }
      // 详情为空时，回退到记录中的各维度分数字段
      const fieldMap = [
        { key: 'moralScore', name: '德育' },
        { key: 'intellectualScore', name: '智育' },
        { key: 'physicalScore', name: '体育' },
        { key: 'aestheticScore', name: '美育' },
        { key: 'laborScore', name: '劳育' }
      ]
      const list = []
      fieldMap.forEach(f => {
        const val = this.record && this.record[f.key]
        if (val !== undefined && val !== null) {
          list.push({ name: f.name, score: Number(val) || 0 })
        }
      })
      return list
    }
  },
  watch: {
    record: {
      handler(val) {
        if (val && val.id) {
          this.reload()
        }
      },
      immediate: true,
      deep: true
    }
  },
  methods: {
    async reload() {
      if (!this.record || !this.record.id) return
      this.loading = true
      try {
        const resp = await getSubmissionDetail(this.record.id)
        if (resp && resp.code === 200) {
          this.detail = resp.data || {}
          // 默认展开所有维度
          this.activePanels = Object.keys(this.groupedDetails)
        }
      } catch (e) {
        this.$message.error('加载详情失败')
      } finally {
        this.loading = false
      }
    },
    getAttachmentHref(att) {
      // 兼容字符串/对象
      if (!att) return undefined
      if (typeof att === 'string') return att
      return att.url || att.href || undefined
    },
    getAttachmentName(att, idx) {
      if (!att) return `附件${idx + 1}`
      if (typeof att === 'string') return att.split('/').pop() || `附件${idx + 1}`
      return att.name || att.fileName || `附件${idx + 1}`
    }
  }
}
</script>

<style scoped>
.detail-container { padding: 8px; }
.detail-toolbar { margin-top: 12px; display: flex; gap: 8px; }
.section-card { margin-top: 12px; }
.section-header { display:flex; align-items:center; gap:8px; font-weight:600; }
.attachments { display: flex; flex-wrap: wrap; gap: 6px; }
.collapse-title { font-weight: 600; }
</style>