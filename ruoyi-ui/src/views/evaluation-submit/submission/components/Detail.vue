<template>
  <div class="detail-container">
    <!-- 学生基本信息 -->
    <el-card shadow="never" class="info-card">
      <div slot="header">
        <i class="el-icon-user"></i>
        <span>学生基本信息</span>
      </div>
      <el-descriptions :column="3" border>
        <el-descriptions-item label="姓名">{{ record.studentName || '—' }}</el-descriptions-item>
        <el-descriptions-item label="学号">{{ record.studentNumber || '—' }}</el-descriptions-item>
        <el-descriptions-item label="班级">{{ record.className || '—' }}</el-descriptions-item>
        <el-descriptions-item label="学年学期" :span="2">
          {{ record.academicYear || '—' }} 第{{ record.semester || '—' }}学期
        </el-descriptions-item>
        <el-descriptions-item label="提交时间">
          {{ record.submitTime || record.createTime || '—' }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>

    <!-- 填报状态信息 -->
    <el-card shadow="never" class="info-card">
      <div slot="header">
        <i class="el-icon-document"></i>
        <span>填报状态</span>
      </div>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="状态">{{ statusText }}</el-descriptions-item>
        <el-descriptions-item label="总分">{{ displayTotalScore }}</el-descriptions-item>
        <el-descriptions-item label="审核时间">{{ record.auditTime || '—' }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ record.remark || '—' }}</el-descriptions-item>
      </el-descriptions>
    </el-card>

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

    <!-- 成绩截图 -->
    <el-card shadow="never" class="section-card" v-if="gradeScreenshots.length > 0">
      <div slot="header" class="section-header">
        <i class="el-icon-picture-outline"></i>
        <span>成绩截图</span>
      </div>
      <div class="screenshot-gallery">
        <el-image
          v-for="(screenshot, index) in gradeScreenshots"
          :key="index"
          :src="getImageUrl(screenshot.url)"
          :preview-src-list="gradeScreenshots.map(s => getImageUrl(s.url))"
          fit="cover"
          class="screenshot-item"
        >
          <div slot="error" class="image-slot">
            <i class="el-icon-picture-outline"></i>
          </div>
        </el-image>
      </div>
    </el-card>


    <!-- 明细列表（按维度折叠） -->
    <el-card shadow="never" class="section-card" v-loading="loading">
      <div slot="header" class="section-header">
        <i class="el-icon-document"></i>
        <span>条目明细</span>
      </div>

      <!-- 无数据提示 -->
      <el-empty
        v-if="!detail || !detail.details || detail.details.length === 0"
        description="暂无条目明细数据"
        :image-size="100"
      >
        <template slot="description">
          <p style="color: #909399; font-size: 14px;">此填报记录暂无详细的成果条目数据</p>
          <p style="color: #C0C4CC; font-size: 12px; margin-top: 8px;">
            可能原因：早期测试数据、草稿未完成或数据已被清理
          </p>
        </template>
      </el-empty>

      <!-- 有数据时显示折叠面板 -->
      <el-collapse v-else v-model="activePanels">
        <el-collapse-item v-for="(items, dim) in groupedDetails" :key="dim" :name="dim">
          <template slot="title">
            <span class="collapse-title">{{ dimensionNameMap[dim] || dim }}</span>
          </template>
          <el-table :data="items" border size="small">
            <el-table-column label="类别" min-width="160">
              <template slot-scope="scope">{{ getRuleSnapshotField(scope.row, 'category') }}</template>
            </el-table-column>
            <el-table-column label="项目" min-width="160">
              <template slot-scope="scope">{{ getRuleSnapshotField(scope.row, 'itemName') }}</template>
            </el-table-column>
            <el-table-column prop="finalScore" label="分数" width="120">
              <template slot-scope="scope">{{ (scope.row.finalScore || 0).toFixed(2) }}</template>
            </el-table-column>
            <el-table-column prop="remark" label="备注" min-width="160">
              <template slot-scope="scope">{{ scope.row.remark || '暂无' }}</template>
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
                    type="success"
                  >{{ getAttachmentName(att, idx) }}</el-link>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </el-collapse-item>
      </el-collapse>
    </el-card>

    <!-- 审核记录 -->
    <el-card shadow="never" class="section-card" v-if="auditLogs.length > 0">
      <div slot="header" class="section-header">
        <i class="el-icon-time"></i>
        <span>审核记录</span>
      </div>
      <el-timeline>
        <el-timeline-item
          v-for="(log, index) in auditLogs"
          :key="index"
          :timestamp="log.auditTime"
          placement="top"
          :type="getTimelineType(log.operation)"
          :icon="getTimelineIcon(log.operation)"
        >
          <el-card shadow="hover">
            <h4>{{ getOperationText(log.operation) }}</h4>
            <p><strong>审核人：</strong>{{ log.auditorName || '—' }}</p>
            <p v-if="log.remark"><strong>审核意见：</strong>{{ log.remark }}</p>
            <p><strong>状态变更：</strong>{{ getStatusText(log.oldStatus) }} → {{ getStatusText(log.newStatus) }}</p>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </el-card>

    <div class="detail-toolbar">
      <el-button type="primary" @click="reload" v-hasPermi="['evaluation:submission:query']">刷新</el-button>
    </div>
  </div>
</template>

<script>
import { getSubmissionDetail } from '@/api/evaluation/submission'
import { getAuditLogsBySubmissionId } from '@/api/evaluation/auditLog'

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
      auditLogs: [],
      gradeScreenshots: [], // 成绩截图列表
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
      console.log('[groupedDetails] 开始计算分组详情')
      const details = (this.detail && this.detail.details) || []
      console.log('[groupedDetails] 详情列表:', details)
      console.log('[groupedDetails] 详情数量:', details.length)

      const groups = {}
      details.forEach((d, index) => {
        console.log(`[groupedDetails] 处理第${index + 1}条详情:`, d)

        // 解析 ruleSnapshot（可能是字符串）
        let snapshot = d.ruleSnapshot
        console.log(`[groupedDetails] 第${index + 1}条的ruleSnapshot类型:`, typeof snapshot)
        console.log(`[groupedDetails] 第${index + 1}条的ruleSnapshot内容:`, snapshot)

        if (typeof snapshot === 'string') {
          try {
            snapshot = JSON.parse(snapshot)
            console.log(`[groupedDetails] 第${index + 1}条解析后的snapshot:`, snapshot)
          } catch (e) {
            console.error(`[groupedDetails] 第${index + 1}条解析ruleSnapshot失败:`, e, snapshot)
            return
          }
        }

        // 优先使用 dimensionType（数字），然后使用 dimension（字符串）
        let dim = null
        if (snapshot && snapshot.dimensionType !== undefined) {
          // dimensionType: 0=德育, 1=智育, 2=体育, 3=美育, 4=劳育
          const typeMap = { 0: 'moral', 1: 'intellectual', 2: 'physical', 3: 'aesthetic', 4: 'labor' }
          dim = typeMap[snapshot.dimensionType]
          console.log(`[groupedDetails] 第${index + 1}条通过dimensionType(${snapshot.dimensionType})确定维度:`, dim)
        } else if (snapshot && snapshot.dimension) {
          dim = snapshot.dimension
          console.log(`[groupedDetails] 第${index + 1}条通过dimension确定维度:`, dim)
        }

        if (!dim) {
          console.warn(`[groupedDetails] 第${index + 1}条无法确定维度，跳过`)
          return
        }

        if (!groups[dim]) groups[dim] = []

        // 将解析后的 snapshot 保存回对象，方便模板使用
        d.parsedSnapshot = snapshot
        console.log(`[groupedDetails] 第${index + 1}条的parsedSnapshot:`, d.parsedSnapshot)
        console.log(`[groupedDetails] 第${index + 1}条的category:`, snapshot.category)
        console.log(`[groupedDetails] 第${index + 1}条的itemName:`, snapshot.itemName)

        groups[dim].push(d)
      })

      console.log('[groupedDetails] 最终分组结果:', groups)
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
          // 提取成绩截图
          this.extractGradeScreenshots()
        }
        // 加载审核记录
        await this.loadAuditLogs()
      } catch (e) {
        this.$message.error('加载详情失败')
      } finally {
        this.loading = false
      }
    },

    // 提取成绩截图
    extractGradeScreenshots() {
      this.gradeScreenshots = []
      console.log('开始提取成绩截图, detail:', this.detail) // 调试信息

      if (!this.detail || !this.detail.details) {
        console.log('没有详情数据') // 调试信息
        return
      }

      console.log('详情列表:', this.detail.details) // 调试信息

      // 查找智育维度的详情
      const intellectualDetails = this.detail.details.filter(d => {
        if (d.ruleSnapshot) {
          try {
            const snapshot = typeof d.ruleSnapshot === 'string'
              ? JSON.parse(d.ruleSnapshot)
              : d.ruleSnapshot
            console.log('规则快照:', snapshot) // 调试信息

            // 检查 dimensionType（数字类型）：1=智育
            if (snapshot.dimensionType === 1) {
              return true
            }

            // 兼容旧版本：检查 dimension（字符串类型）
            if (snapshot.dimension === 'intellectual') {
              return true
            }

            return false
          } catch (e) {
            console.error('解析规则快照失败:', e) // 调试信息
            return false
          }
        }
        return false
      })

      console.log('智育维度详情:', intellectualDetails) // 调试信息

      // 提取成绩截图附件
      intellectualDetails.forEach(detail => {
        console.log('详情附件:', detail.attachments) // 调试信息
        if (detail.attachments && Array.isArray(detail.attachments)) {
          detail.attachments.forEach(att => {
            console.log('附件类型:', att.attachmentType) // 调试信息
            if (att.attachmentType === 'GRADE_SCREENSHOT') {
              this.gradeScreenshots.push({
                url: att.url,
                fileName: att.fileName || att.originalName
              })
            }
          })
        }
      })

      console.log('提取到的成绩截图:', this.gradeScreenshots) // 调试信息
    },

    async loadAuditLogs() {
      if (!this.record || !this.record.id) return
      try {
        const resp = await getAuditLogsBySubmissionId(this.record.id)
        if (resp && resp.code === 200) {
          // 按时间倒序排列（最新的在上面）
          this.auditLogs = (resp.data || []).sort((a, b) => {
            return new Date(b.auditTime) - new Date(a.auditTime)
          })
        }
      } catch (e) {
        console.error('加载审核记录失败:', e)
      }
    },
    // 获取 ruleSnapshot 中的字段值
    getRuleSnapshotField(row, fieldName) {
      console.log('[getRuleSnapshotField] 开始解析字段:', fieldName)
      console.log('[getRuleSnapshotField] row对象:', row)
      console.log('[getRuleSnapshotField] row.parsedSnapshot:', row.parsedSnapshot)
      console.log('[getRuleSnapshotField] row.ruleSnapshot:', row.ruleSnapshot)

      // 优先使用已解析的 parsedSnapshot
      if (row.parsedSnapshot) {
        const value = row.parsedSnapshot[fieldName]
        console.log(`[getRuleSnapshotField] 从parsedSnapshot获取${fieldName}:`, value)
        return value || '—'
      }

      // 如果没有 parsedSnapshot，尝试解析 ruleSnapshot
      if (!row.ruleSnapshot) {
        console.warn('[getRuleSnapshotField] ruleSnapshot不存在')
        return '—'
      }

      let snapshot = row.ruleSnapshot
      console.log('[getRuleSnapshotField] ruleSnapshot类型:', typeof snapshot)

      if (typeof snapshot === 'string') {
        try {
          snapshot = JSON.parse(snapshot)
          console.log('[getRuleSnapshotField] 解析后的snapshot:', snapshot)
        } catch (e) {
          console.error('[getRuleSnapshotField] 解析ruleSnapshot失败:', e, snapshot)
          return '—'
        }
      }

      const value = snapshot[fieldName]
      console.log(`[getRuleSnapshotField] 最终获取${fieldName}:`, value)
      return value || '—'
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
      return att.name || att.fileName || att.originalName || `附件${idx + 1}`
    },

    getTimelineType(operation) {
      const typeMap = {
        'APPROVE': 'success',
        'REJECT': 'danger',
        'SUBMIT': 'primary'
      }
      return typeMap[operation] || 'info'
    },

    getTimelineIcon(operation) {
      const iconMap = {
        'APPROVE': 'el-icon-check',
        'REJECT': 'el-icon-close',
        'SUBMIT': 'el-icon-upload'
      }
      return iconMap[operation] || 'el-icon-info'
    },

    getOperationText(operation) {
      const textMap = {
        'APPROVE': '审核通过',
        'REJECT': '审核驳回',
        'SUBMIT': '提交审核'
      }
      return textMap[operation] || '未知操作'
    },

    // 获取图片URL
    getImageUrl(url) {
      if (!url) return ''
      // 如果是完整URL，直接返回
      if (url.startsWith('http://') || url.startsWith('https://')) {
        return url
      }
      // 如果是相对路径，拼接基础URL
      return process.env.VUE_APP_BASE_API + url
    },

    getStatusText(status) {
      const map = {
        0: '草稿',
        1: '待班委审核',
        2: '待辅导员审核',
        3: '已通过',
        4: '已驳回'
      }
      return map[status] || '—'
    }
  }
}
</script>

<style scoped>
.detail-container { padding: 8px; }
.info-card { margin-bottom: 16px; }
.info-card >>> .el-card__header {
  background-color: #f5f7fa;
  padding: 12px 20px;
}
.info-card >>> .el-card__header i {
  margin-right: 8px;
  color: #409eff;
}
.detail-toolbar { margin-top: 12px; display: flex; gap: 8px; }
.section-card { margin-top: 12px; }
.section-header { display:flex; align-items:center; gap:8px; font-weight:600; }
.attachments { display: flex; flex-wrap: wrap; gap: 6px; }
.collapse-title { font-weight: 600; }

/* 成绩截图样式 */
.screenshot-gallery {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  padding: 12px;
}

.screenshot-item {
  width: 150px;
  height: 150px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.screenshot-item:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: #f5f7fa;
  color: #909399;
  font-size: 30px;
}
</style>
