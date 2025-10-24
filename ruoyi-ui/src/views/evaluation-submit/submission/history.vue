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
        <el-form-item>
          <el-button type="primary" @click="handleQuery" v-hasPermi="['evaluation:submission:history']">查询历史</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never" class="card-section">
      <el-table :data="list" border>
        <el-table-column prop="academicYear" label="学年" width="120" />
        <el-table-column prop="semester" label="学期" width="100" />
        <el-table-column prop="status" label="状态" width="120" />
        <el-table-column prop="totalScore" label="总分" width="100" />
        <el-table-column prop="submitTime" label="提交时间" min-width="160" />
        <el-table-column label="操作" width="160" fixed="right">
          <template slot-scope="scope">
            <el-button size="small" @click="openDetail(scope.row)" v-hasPermi="['evaluation:submission:query']">详情</el-button>
            <el-button size="small" @click="handleDownload(scope.row)" v-hasPermi="['evaluation:attachment:download']">下载附件</el-button>
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

    <el-dialog :visible.sync="detailOpen" title="历史详情" width="800px" append-to-body>
      <Detail :record="currentRow" />
    </el-dialog>
  </div>
</template>

<script>
import Detail from './components/Detail.vue'
import { listSemesterScoreDetail } from '@/api/evaluation/semesterScore'

export default {
  name: "SubmissionHistory",
  components: { Detail },
  data() {
    return {
      queryParams: { academicYear: '', semester: undefined },
      list: [],
      page: { pageNum: 1, pageSize: 10, total: 0 },
      detailOpen: false,
      currentRow: null
    }
  },
  created() { this.handleQuery() },
  methods: {
    handleQuery() {
      const params = {
        academicYear: this.queryParams.academicYear || undefined,
        semester: this.queryParams.semester || undefined,
        pageNum: this.page.pageNum,
        pageSize: this.page.pageSize
      }
      listSemesterScoreDetail(params)
        .then(res => {
          this.list = res.rows || []
          this.page.total = res.total || 0
        })
        .catch(err => {
          this.$message.error((err && err.message) || '历史加载失败')
          this.list = []
          this.page.total = 0
        })
    },
    resetQuery() {
      this.queryParams.academicYear = ''
      this.queryParams.semester = undefined
    },
    handleSizeChange(size) { this.page.pageSize = size; this.handleQuery() },
    handlePageChange(pageNum) { this.page.pageNum = pageNum; this.handleQuery() },
    openDetail(row) { this.currentRow = row; this.detailOpen = true },
    handleDownload() { this.$message.info('开始下载附件（示例占位）') }
  }
}
</script>

<style scoped>
.page-container { padding: 16px; }
.card-section { margin-bottom: 16px; }
.mt-12 { margin-top: 12px; }
</style>