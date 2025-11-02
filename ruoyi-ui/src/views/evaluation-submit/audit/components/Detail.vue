<template>
  <div class="detail-container">
    <!-- 基本信息 -->
    <el-descriptions title="基本信息" :column="2" border class="mb-20">
      <el-descriptions-item label="学生">{{ record.userName }}</el-descriptions-item>
      <el-descriptions-item label="学年">{{ record.academicYear }}</el-descriptions-item>
      <el-descriptions-item label="学期">第{{ record.semester }}学期</el-descriptions-item>
      <el-descriptions-item label="状态">
        <el-tag :type="getStatusType(record.status)">
          {{ getStatusText(record.status) }}
        </el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="总分">{{ record.totalScore || 0 }}</el-descriptions-item>
      <el-descriptions-item label="提交时间">{{ record.submitTime || '—' }}</el-descriptions-item>
      <el-descriptions-item label="自我评价" :span="2">{{ record.remark || '无' }}</el-descriptions-item>
    </el-descriptions>

    <!-- 详细成果信息 -->
    <div v-if="detailData && detailData.details" class="achievement-details">
      <h3>成果详情</h3>
      <el-tabs v-model="activeTab" type="card">
        <el-tab-pane 
          v-for="(group, dimension) in groupedDetails" 
          :key="dimension"
          :label="getDimensionName(dimension) + ' (' + group.length + '项)'"
          :name="dimension"
        >
          <div v-for="(item, index) in group" :key="index" class="achievement-item">
            <el-card shadow="hover" class="mb-10">
              <div slot="header" class="clearfix">
                <span class="item-title">{{ item.ruleData && item.ruleData.itemName ? item.ruleData.itemName : '未知项目' }}</span>
                <span class="item-score">{{ item.score || 0 }}分</span>
              </div>
              <div class="item-content">
                <p><strong>等级：</strong>{{ item.ruleData && item.ruleData.level ? item.ruleData.level : '—' }}</p>
                <p><strong>说明：</strong>{{ item.remark || '无' }}</p>
                <div v-if="item.attachments && item.attachments.length > 0" class="attachments">
                  <strong>附件：</strong>
                  <el-tag 
                    v-for="(attachment, idx) in item.attachments" 
                    :key="idx" 
                    type="info" 
                    class="ml-5"
                  >
                    {{ attachment.fileName || ('附件' + (idx + 1)) }}
                  </el-tag>
                </div>
              </div>
            </el-card>
          </div>
          <div v-if="group.length === 0" class="empty-state">
            <p>该维度暂无成果</p>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>

    <!-- 审核操作 -->
    <div class="detail-toolbar">
      <el-button 
        type="success" 
        @click="handleApprove" 
        :disabled="!canAudit"
      >
        通过
      </el-button>
      <el-button 
        type="danger" 
        @click="handleReject" 
        :disabled="!canAudit"
      >
        驳回
      </el-button>
      <el-button @click="handleRefresh" icon="el-icon-refresh">刷新</el-button>
    </div>

    <!-- 审核意见对话框 -->
    <el-dialog :visible.sync="auditDialogOpen" :title="auditDialogTitle" width="500px" append-to-body>
      <el-form :model="auditForm" label-width="80px">
        <el-form-item label="审核意见">
          <el-input 
            v-model="auditForm.remark" 
            type="textarea" 
            :rows="4" 
            placeholder="请输入审核意见（可选）"
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="auditDialogOpen = false">取消</el-button>
        <el-button type="primary" @click="confirmAudit" :loading="auditing">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getSubmissionDetail, auditSubmission } from '@/api/evaluation/submission'

export default {
  name: "AuditDetail",
  props: {
    record: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      detailData: null,
      activeTab: 'moral',
      auditDialogOpen: false,
      auditDialogTitle: '',
      auditForm: {
        operation: '',
        submissionId: null,
        remark: ''
      },
      auditing: false
    }
  },
  computed: {
    // 是否可以审核
    canAudit() {
      return this.record && (this.record.status === 1 || this.record.status === 2)
    },
    
    // 按维度分组的详情数据
    groupedDetails() {
      if (!this.detailData || !this.detailData.details) {
        return {}
      }
      
      const groups = {
        moral: [],
        intellectual: [],
        physical: [],
        aesthetic: [],
        labor: []
      }
      
      this.detailData.details.forEach(item => {
        const dimension = this.getDimensionByRuleId(item.ruleId)
        if (groups[dimension]) {
          groups[dimension].push(item)
        }
      })
      
      return groups
    }
  },
  watch: {
    record: {
      handler(newRecord) {
        if (newRecord && newRecord.id) {
          this.loadDetailData()
        }
      },
      immediate: true
    }
  },
  methods: {
    // 加载详细数据
    async loadDetailData() {
      if (!this.record || !this.record.id) return
      
      try {
        const response = await getSubmissionDetail(this.record.id)
        this.detailData = response.data
      } catch (error) {
        console.error('加载详情失败:', error)
        this.$message.error('加载详情失败')
      }
    },
    
    // 刷新数据
    handleRefresh() {
      this.loadDetailData()
      this.$message.success('数据已刷新')
    },
    
    // 审核通过
    handleApprove() {
      this.auditForm = {
        operation: 'APPROVE',
        submissionId: this.record.id,
        remark: ''
      }
      this.auditDialogTitle = '审核通过'
      this.auditDialogOpen = true
    },
    
    // 审核驳回
    handleReject() {
      this.auditForm = {
        operation: 'REJECT',
        submissionId: this.record.id,
        remark: ''
      }
      this.auditDialogTitle = '审核驳回'
      this.auditDialogOpen = true
    },
    
    // 确认审核
    async confirmAudit() {
      this.auditing = true
      try {
        await auditSubmission(this.auditForm)
        this.$message.success('审核操作成功')
        this.auditDialogOpen = false
        this.$emit('audit-success')
      } catch (error) {
        console.error('审核操作失败:', error)
        this.$message.error('审核操作失败')
      } finally {
        this.auditing = false
      }
    },
    
    // 获取状态类型
    getStatusType(status) {
      const statusMap = {
        0: 'info',    // 草稿
        1: 'warning', // 待审核
        2: 'warning', // 待辅导员审核
        3: 'success', // 已通过
        4: 'danger'   // 已驳回
      }
      return statusMap[status] || 'info'
    },
    
    // 获取状态文本
    getStatusText(status) {
      const statusMap = {
        0: '草稿',
        1: '待班委审核',
        2: '待辅导员审核',
        3: '已通过',
        4: '已驳回'
      }
      return statusMap[status] || '未知'
    },
    
    // 获取维度名称
    getDimensionName(dimension) {
      const dimensionMap = {
        moral: '德育',
        intellectual: '智育',
        physical: '体育',
        aesthetic: '美育',
        labor: '劳育'
      }
      return dimensionMap[dimension] || dimension
    },
    
    // 根据规则ID获取维度
    getDimensionByRuleId(ruleId) {
      // 这里需要根据实际的规则ID规律来判断维度
      // 暂时使用简单的判断逻辑
      if (!ruleId) return 'moral'
      
      const ruleStr = ruleId.toString()
      if (ruleStr.startsWith('1')) return 'moral'
      if (ruleStr.startsWith('2')) return 'intellectual'
      if (ruleStr.startsWith('3')) return 'physical'
      if (ruleStr.startsWith('4')) return 'aesthetic'
      if (ruleStr.startsWith('5')) return 'labor'
      
      return 'moral' // 默认
    }
  }
}
</script>

<style scoped>
.detail-container {
  padding: 16px;
}

.mb-20 {
  margin-bottom: 20px;
}

.mb-10 {
  margin-bottom: 10px;
}

.ml-5 {
  margin-left: 5px;
}

.achievement-details h3 {
  margin-bottom: 16px;
  color: #303133;
}

.achievement-item {
  margin-bottom: 16px;
}

.clearfix::after {
  content: "";
  display: table;
  clear: both;
}

.item-title {
  font-weight: bold;
  color: #303133;
}

.item-score {
  float: right;
  color: #409EFF;
  font-weight: bold;
}

.item-content p {
  margin: 8px 0;
  line-height: 1.5;
}

.attachments {
  margin-top: 12px;
}

.empty-state {
  text-align: center;
  padding: 40px 0;
  color: #909399;
}

.detail-toolbar {
  margin-top: 20px;
  text-align: center;
}

.detail-toolbar .el-button {
  margin: 0 8px;
}
</style>