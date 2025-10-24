<template>
  <div class="page-container">
    <el-card shadow="never" class="card-section">
      <el-form :inline="true" :model="queryParams" label-width="80px" class="query-form">
        <el-form-item label="学年">
          <el-input v-model="queryParams.academicYear" placeholder="如 2024-2025" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="queryParams.status" placeholder="选择状态" clearable>
            <el-option label="待审核" value="submitted" />
            <el-option label="已通过" value="approved" />
            <el-option label="已驳回" value="rejected" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleQuery" v-hasPermi="['evaluation:audit:list']">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never" class="card-section">
      <div class="toolbar">
        <el-button type="success" :disabled="singleDisabled" @click="approve" v-hasPermi="['evaluation:audit:approve']">审核通过</el-button>
        <el-button type="danger" :disabled="singleDisabled" @click="reject" v-hasPermi="['evaluation:audit:reject']">审核驳回</el-button>
      </div>

      <el-table :data="list" border @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="userName" label="学生" width="140" />
        <el-table-column prop="academicYear" label="学年" width="120" />
        <el-table-column prop="semester" label="学期" width="100" />
        <el-table-column prop="submissionStatus" label="状态" width="120" />
        <el-table-column prop="totalScore" label="总分" width="100" />
        <el-table-column label="操作" align="center" fixed="right" width="120">
            <template slot-scope="scope">
              <el-button size="small" @click="openDetail(scope.row)" v-hasPermi="['evaluation:audit:detail']">详情</el-button>
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
        @current-change="handlePageChange" />
      </div>
    </el-card>

    <el-dialog :visible.sync="detailOpen" title="审核详情" width="800px" append-to-body>
      <Detail :record="currentRow" />
    </el-dialog>
  </div>
</template>

<script>
import Detail from './components/Detail.vue'

export default {
  name: "AuditIndex",
  components: { Detail },
  data() {
    return {
      queryParams: { academicYear: '', status: 'submitted' },
      list: [],
      page: { pageNum: 1, pageSize: 10, total: 0 },
      selectedRows: [],
      singleDisabled: true,
      detailOpen: false,
      currentRow: null
    }
  },
  created() { this.handleQuery() },
  methods: {
    handleQuery() {
      this.page.total = 1
      this.list = [{
        userName: '张三',
        academicYear: this.queryParams.academicYear || '2024-2025',
        semester: 1,
        submissionStatus: this.queryParams.status,
        totalScore: 88.0
      }]
    },
    resetQuery() { this.queryParams.academicYear = ''; this.queryParams.status = 'submitted' },
    handleSelectionChange(rows) { this.selectedRows = rows; this.singleDisabled = rows.length !== 1 },
    handleSizeChange(size) { this.page.pageSize = size; this.handleQuery() },
    handlePageChange(pageNum) { this.page.pageNum = pageNum; this.handleQuery() },
    approve() {
      if (!this.selectedRows.length) return
      this.$message.success('审核通过（示例占位）')
    },
    reject() {
      if (!this.selectedRows.length) return
      this.$message.success('审核驳回（示例占位）')
    },
    openDetail(row) { this.currentRow = row; this.detailOpen = true }
  }
}
</script>

<style scoped>
.page-container { padding: 16px; }
.card-section { margin-bottom: 16px; }
.toolbar { display: flex; gap: 8px; margin-bottom: 8px; }
.mt-12 { margin-top: 12px; }
</style>