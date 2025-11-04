<template>
  <div class="app-container">
    <el-card class="filter-card" shadow="never">
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="80px">
        <el-form-item label="学年" prop="academicYear">
          <el-select v-model="queryParams.academicYear" placeholder="请选择学年" clearable style="width: 150px">
            <el-option
              v-for="year in academicYearOptions"
              :key="year"
              :label="year"
              :value="year"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="学期" prop="semester">
          <el-select v-model="queryParams.semester" placeholder="请选择学期" clearable style="width: 120px">
            <el-option label="第一学期" :value="1" />
            <el-option label="第二学期" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="审核状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 150px">
            <el-option label="待班委审核" :value="1" />
            <el-option label="已通过" :value="2" />
            <el-option label="已驳回" :value="4" />
          </el-select>
        </el-form-item>
        <el-form-item label="学生姓名" prop="studentName">
          <el-input
            v-model="queryParams.studentName"
            placeholder="请输入学生姓名"
            clearable
            style="width: 150px"
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="statistics-row">
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card pending">
          <div class="stat-content">
            <div class="stat-icon">
              <i class="el-icon-time"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.pendingCount }}</div>
              <div class="stat-label">待审核</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card approved">
          <div class="stat-content">
            <div class="stat-icon">
              <i class="el-icon-success"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.approvedCount }}</div>
              <div class="stat-label">已通过</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card rejected">
          <div class="stat-content">
            <div class="stat-icon">
              <i class="el-icon-error"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.rejectedCount }}</div>
              <div class="stat-label">已驳回</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card total">
          <div class="stat-content">
            <div class="stat-icon">
              <i class="el-icon-document"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.totalCount }}</div>
              <div class="stat-label">总计</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 审核列表 -->
    <el-card shadow="never">
      <div slot="header" class="card-header">
        <span>
          <i class="el-icon-document-checked"></i>
          班级综测审核列表
        </span>
        <div class="header-actions">
          <el-button
            type="success"
            icon="el-icon-check"
            size="mini"
            :disabled="multiple"
            @click="handleBatchApprove"
          >
            批量通过
          </el-button>
          <el-button
            type="danger"
            icon="el-icon-close"
            size="mini"
            :disabled="multiple"
            @click="handleBatchReject"
          >
            批量驳回
          </el-button>
        </div>
      </div>

      <el-table
        v-loading="loading"
        :data="submissionList"
        @selection-change="handleSelectionChange"
        border
        stripe
      >
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="序号" type="index" width="60" align="center" />
        <el-table-column label="学生姓名" prop="studentName" width="100" align="center" />
        <el-table-column label="学号" prop="studentNumber" width="120" align="center" />
        <el-table-column label="学年学期" width="150" align="center">
          <template slot-scope="scope">
            {{ scope.row.academicYear }} 第{{ scope.row.semester }}学期
          </template>
        </el-table-column>
        <el-table-column label="总分" prop="totalScore" width="100" align="center">
          <template slot-scope="scope">
            <el-tag :type="getScoreTagType(scope.row.totalScore)" size="small">
              {{ scope.row.totalScore }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="提交时间" prop="submitTime" width="160" align="center">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.submitTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="审核状态" prop="status" width="120" align="center">
          <template slot-scope="scope">
            <dict-tag :options="dict.type.evaluation_status" :value="scope.row.status"/>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-view"
              @click="handleView(scope.row)"
            >
              查看详情
            </el-button>
            <el-button
              v-if="scope.row.status === 1"
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleAudit(scope.row)"
            >
              审核
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>

    <!-- 审核详情对话框 -->
    <audit-detail-dialog
      ref="auditDetailDialog"
      @refresh="getList"
    />

    <!-- 批量审核对话框 -->
    <batch-audit-dialog
      ref="batchAuditDialog"
      @refresh="getList"
    />
  </div>
</template>

<script>
import { listSubmission } from '@/api/evaluation/submission'
import AuditDetailDialog from './components/AuditDetailDialog'
import BatchAuditDialog from './components/BatchAuditDialog'

export default {
  name: 'ClassCommitteeAudit',
  dicts: ['evaluation_status'],
  components: {
    AuditDetailDialog,
    BatchAuditDialog
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 提交列表
      submissionList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        academicYear: null,
        semester: null,
        status: 1, // 默认查询待班委审核的记录
        studentName: null
      },
      // 学年选项
      academicYearOptions: [],
      // 统计数据
      statistics: {
        pendingCount: 0,
        approvedCount: 0,
        rejectedCount: 0,
        totalCount: 0
      }
    }
  },
  created() {
    this.initAcademicYears()
    this.getList()
    this.getStatistics()
  },
  methods: {
    /** 查询提交列表 */
    getList() {
      this.loading = true
      listSubmission(this.queryParams).then(response => {
        this.submissionList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 获取统计数据 */
    getStatistics() {
      // TODO: 调用统计接口
      // 临时模拟数据
      this.statistics = {
        pendingCount: 15,
        approvedCount: 42,
        rejectedCount: 3,
        totalCount: 60
      }
    },
    /** 初始化学年选项 */
    initAcademicYears() {
      const currentYear = new Date().getFullYear()
      for (let i = 0; i < 5; i++) {
        const year = currentYear - i
        this.academicYearOptions.push(`${year}-${year + 1}`)
      }
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    /** 多选框选中数据 */
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.multiple = !selection.length
    },
    /** 查看详情 */
    handleView(row) {
      this.$refs.auditDetailDialog.open(row.id, true)
    },
    /** 审核操作 */
    handleAudit(row) {
      this.$refs.auditDetailDialog.open(row.id, false)
    },
    /** 批量通过 */
    handleBatchApprove() {
      this.$refs.batchAuditDialog.open(this.ids, 'APPROVE')
    },
    /** 批量驳回 */
    handleBatchReject() {
      this.$refs.batchAuditDialog.open(this.ids, 'REJECT')
    },
    /** 获取分数标签类型 */
    getScoreTagType(score) {
      if (score >= 90) return 'success'
      if (score >= 80) return ''
      if (score >= 70) return 'warning'
      if (score >= 60) return 'info'
      return 'danger'
    }
  }
}
</script>

<style scoped lang="scss">
.filter-card {
  margin-bottom: 20px;
}

.statistics-row {
  margin-bottom: 20px;

  .stat-card {
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      transform: translateY(-5px);
    }

    .stat-content {
      display: flex;
      align-items: center;

      .stat-icon {
        font-size: 48px;
        margin-right: 20px;
      }

      .stat-info {
        flex: 1;

        .stat-value {
          font-size: 32px;
          font-weight: bold;
          margin-bottom: 8px;
        }

        .stat-label {
          font-size: 14px;
          color: #909399;
        }
      }
    }

    &.pending {
      .stat-icon { color: #E6A23C; }
      .stat-value { color: #E6A23C; }
    }

    &.approved {
      .stat-icon { color: #67C23A; }
      .stat-value { color: #67C23A; }
    }

    &.rejected {
      .stat-icon { color: #F56C6C; }
      .stat-value { color: #F56C6C; }
    }

    &.total {
      .stat-icon { color: #409EFF; }
      .stat-value { color: #409EFF; }
    }
  }
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;

  span {
    font-size: 16px;
    font-weight: 500;

    i {
      color: #409EFF;
      margin-right: 8px;
    }
  }

  .header-actions {
    display: flex;
    gap: 10px;
  }
}
</style>

