<template>
  <div class="page-container">
    <el-card shadow="never" class="card-section">
      <el-form :inline="true" :model="queryParams" label-width="80px" class="query-form">
        <el-form-item label="学年">
          <el-input v-model="queryParams.academicYear" placeholder="如 2024-2025" clearable />
        </el-form-item>
        <el-form-item label="学期">
          <el-select v-model="queryParams.semester" placeholder="选择学期" clearable>
            <el-option label="第一学期" :value="1" />
            <el-option label="第二学期" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="选择状态" clearable>
            <el-option label="待审核" :value="1" />
            <el-option label="已通过" :value="3" />
            <el-option label="已驳回" :value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="学生姓名">
          <el-input v-model="queryParams.studentName" placeholder="请输入学生姓名" clearable />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleQuery" v-hasPermi="['evaluation:submission:list']">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
          <el-button type="success" @click="handleRefresh" icon="el-icon-refresh">刷新</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never" class="card-section">
      <div class="toolbar">
        <el-button type="success" :disabled="singleDisabled" @click="batchApprove" v-hasPermi="['evaluation:audit:approve']">批量通过</el-button>
        <el-button type="danger" :disabled="singleDisabled" @click="batchReject" v-hasPermi="['evaluation:audit:reject']">批量驳回</el-button>
      </div>

      <el-table 
        :data="list" 
        border 
        @selection-change="handleSelectionChange"
        v-loading="loading"
        element-loading-text="加载中..."
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="userName" label="学生" width="140" />
        <el-table-column prop="academicYear" label="学年" width="120" />
        <el-table-column prop="semester" label="学期" width="100">
          <template slot-scope="scope">
            <span>第{{ scope.row.semester }}学期</span>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="120">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="totalScore" label="总分" width="100">
          <template slot-scope="scope">
            <span>{{ scope.row.totalScore || 0 }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="submitTime" label="提交时间" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.submitTime, '{y}-{m}-{d} {h}:{i}') || '—' }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" fixed="right" width="200">
          <template slot-scope="scope">
            <el-button size="small" @click="openDetail(scope.row)" v-hasPermi="['evaluation:audit:detail']">详情</el-button>
            <el-button 
              v-if="scope.row.status === 1" 
              size="small" 
              type="success" 
              @click="approve(scope.row)" 
              v-hasPermi="['evaluation:audit:approve']"
            >通过</el-button>
            <el-button 
              v-if="scope.row.status === 1" 
              size="small" 
              type="danger" 
              @click="reject(scope.row)" 
              v-hasPermi="['evaluation:audit:reject']"
            >驳回</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="mt-12">
        <el-pagination
          :current-page.sync="page.pageNum"
          :page-size.sync="page.pageSize"
          :total="page.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handlePageChange" 
        />
      </div>
    </el-card>

    <el-dialog :visible.sync="detailOpen" title="审核详情" width="800px" append-to-body>
      <Detail :record="currentRow" @audit-success="handleAuditSuccess" />
    </el-dialog>

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
        <el-button type="primary" @click="confirmAudit">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import Detail from './components/Detail.vue'
import { getSubmissionList, auditSubmission } from '@/api/evaluation/submission'
import { parseTime } from '@/utils/ruoyi'

export default {
  name: "AuditIndex",
  components: { Detail },
  data() {
    return {
      loading: false,
      queryParams: { 
        academicYear: '', 
        semester: null,
        status: 1, // 默认显示待审核
        studentName: ''
      },
      list: [],
      page: { pageNum: 1, pageSize: 10, total: 0 },
      selectedRows: [],
      singleDisabled: true,
      detailOpen: false,
      currentRow: null,
      auditDialogOpen: false,
      auditDialogTitle: '',
      auditForm: {
        operation: '',
        submissionId: null,
        remark: ''
      },
      // 自动刷新定时器
      refreshTimer: null
    }
  },
  created() { 
    this.handleQuery()
    this.startAutoRefresh()
  },
  beforeDestroy() {
    this.stopAutoRefresh()
  },
  methods: {
    parseTime,
    
    async handleQuery() {
      this.loading = true
      try {
        const params = {
          pageNum: this.page.pageNum,
          pageSize: this.page.pageSize,
          ...this.queryParams
        }
        const response = await getSubmissionList(params)
        this.list = response.rows || []
        this.page.total = response.total || 0
      } catch (error) {
        console.error('获取审核列表失败:', error)
        this.$message.error('获取审核列表失败')
        this.list = []
        this.page.total = 0
      } finally {
        this.loading = false
      }
    },
    
    resetQuery() { 
      this.queryParams = { 
        academicYear: '', 
        semester: null,
        status: 1, 
        studentName: '' 
      }
      this.page.pageNum = 1
      this.handleQuery()
    },
    
    handleRefresh() {
      this.handleQuery()
      this.$message.success('数据已刷新')
    },
    
    handleSelectionChange(rows) { 
      this.selectedRows = rows
      this.singleDisabled = rows.length === 0
    },
    
    handleSizeChange(size) { 
      this.page.pageSize = size
      this.handleQuery() 
    },
    
    handlePageChange(pageNum) { 
      this.page.pageNum = pageNum
      this.handleQuery() 
    },
    
    // 单个审核通过
    approve(row) {
      this.auditForm = {
        operation: 'APPROVE',
        submissionId: row.id,
        remark: ''
      }
      this.auditDialogTitle = '审核通过'
      this.auditDialogOpen = true
    },
    
    // 单个审核驳回
    reject(row) {
      this.auditForm = {
        operation: 'REJECT',
        submissionId: row.id,
        remark: ''
      }
      this.auditDialogTitle = '审核驳回'
      this.auditDialogOpen = true
    },
    
    // 批量审核通过
    batchApprove() {
      if (this.selectedRows.length === 0) {
        this.$message.warning('请选择要审核的记录')
        return
      }
      this.auditForm = {
        operation: 'APPROVE',
        batchSubmissionIds: this.selectedRows.map(row => row.id),
        remark: ''
      }
      this.auditDialogTitle = '批量审核通过'
      this.auditDialogOpen = true
    },
    
    // 批量审核驳回
    batchReject() {
      if (this.selectedRows.length === 0) {
        this.$message.warning('请选择要审核的记录')
        return
      }
      this.auditForm = {
        operation: 'REJECT',
        batchSubmissionIds: this.selectedRows.map(row => row.id),
        remark: ''
      }
      this.auditDialogTitle = '批量审核驳回'
      this.auditDialogOpen = true
    },
    
    // 确认审核
    async confirmAudit() {
      try {
        await auditSubmission(this.auditForm)
        this.$message.success('审核操作成功')
        this.auditDialogOpen = false
        this.handleQuery() // 刷新列表
        this.selectedRows = []
        this.singleDisabled = true
      } catch (error) {
        console.error('审核操作失败:', error)
        this.$message.error('审核操作失败')
      }
    },
    
    openDetail(row) { 
      this.currentRow = row
      this.detailOpen = true 
    },
    
    // 审核成功回调
    handleAuditSuccess() {
      this.detailOpen = false
      this.handleQuery() // 刷新列表
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
        1: '待审核',
        2: '待辅导员审核',
        3: '已通过',
        4: '已驳回'
      }
      return statusMap[status] || '未知'
    },
    
    // 开始自动刷新
    startAutoRefresh() {
      // 每30秒自动刷新一次
      this.refreshTimer = setInterval(() => {
        this.handleQuery()
      }, 30000)
    },
    
    // 停止自动刷新
    stopAutoRefresh() {
      if (this.refreshTimer) {
        clearInterval(this.refreshTimer)
        this.refreshTimer = null
      }
    }
  }
}
</script>

<style scoped>
.page-container { padding: 16px; }
.card-section { margin-bottom: 16px; }
.toolbar { display: flex; gap: 8px; margin-bottom: 8px; }
.mt-12 { margin-top: 12px; }
</style>