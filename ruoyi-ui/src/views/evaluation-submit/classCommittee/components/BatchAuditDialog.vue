<template>
  <el-dialog
    :title="dialogTitle"
    :visible.sync="visible"
    width="600px"
    :close-on-click-modal="false"
    @close="handleClose"
  >
    <div class="batch-audit-container">
      <el-alert
        :title="alertTitle"
        :type="alertType"
        :closable="false"
        show-icon
        style="margin-bottom: 20px"
      >
        <p>您已选择 <strong>{{ submissionIds.length }}</strong> 条记录进行批量{{ operationText }}</p>
        <p v-if="operation === 'REJECT'" style="margin-top: 8px; color: #F56C6C;">
          <i class="el-icon-warning"></i>
          驳回操作将要求学生重新提交，请谨慎操作！
        </p>
      </el-alert>

      <el-form ref="batchAuditForm" :model="batchAuditForm" :rules="batchAuditRules" label-width="100px">
        <el-form-item label="审核意见" prop="remark">
          <el-input
            v-model="batchAuditForm.remark"
            type="textarea"
            :rows="5"
            :placeholder="remarkPlaceholder"
            maxlength="500"
            show-word-limit
          />
        </el-form-item>
      </el-form>
    </div>

    <div slot="footer" class="dialog-footer">
      <el-button @click="handleClose">取 消</el-button>
      <el-button
        :type="operation === 'APPROVE' ? 'success' : 'danger'"
        :loading="submitting"
        @click="handleSubmit"
      >
        确认{{ operationText }}
      </el-button>
    </div>
  </el-dialog>
</template>

<script>
import { batchAuditSubmission } from '@/api/evaluation/submission'

export default {
  name: 'BatchAuditDialog',
  data() {
    return {
      visible: false,
      submitting: false,
      operation: 'APPROVE', // APPROVE 或 REJECT
      submissionIds: [],
      batchAuditForm: {
        submissionIds: [],
        operation: 'APPROVE',
        remark: ''
      },
      batchAuditRules: {
        remark: [
          { validator: this.validateRemark, trigger: 'blur' }
        ]
      }
    }
  },
  computed: {
    dialogTitle() {
      return this.operation === 'APPROVE' ? '批量通过' : '批量驳回'
    },
    operationText() {
      return this.operation === 'APPROVE' ? '通过' : '驳回'
    },
    alertType() {
      return this.operation === 'APPROVE' ? 'success' : 'warning'
    },
    alertTitle() {
      return this.operation === 'APPROVE' ? '批量通过确认' : '批量驳回确认'
    },
    remarkPlaceholder() {
      if (this.operation === 'REJECT') {
        return '请输入驳回原因（必填）'
      }
      return '请输入审核意见（选填）'
    }
  },
  methods: {
    /** 打开对话框 */
    open(submissionIds, operation) {
      if (!submissionIds || submissionIds.length === 0) {
        this.$message.warning('请先选择要审核的记录')
        return
      }
      this.visible = true
      this.operation = operation
      this.submissionIds = submissionIds
      this.batchAuditForm.submissionIds = submissionIds
      this.batchAuditForm.operation = operation
    },
    /** 验证审核意见 */
    validateRemark(rule, value, callback) {
      if (this.operation === 'REJECT' && !value) {
        callback(new Error('批量驳回时必须填写驳回原因'))
      } else {
        callback()
      }
    },
    /** 提交审核 */
    handleSubmit() {
      this.$refs.batchAuditForm.validate(valid => {
        if (valid) {
          const confirmMessage = this.operation === 'APPROVE'
            ? `确认批量通过这 ${this.submissionIds.length} 条记录吗？`
            : `确认批量驳回这 ${this.submissionIds.length} 条记录吗？`

          this.$confirm(confirmMessage, '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.submitBatchAudit()
          })
        }
      })
    },
    /** 执行批量审核 */
    async submitBatchAudit() {
      this.submitting = true
      try {
        const response = await batchAuditSubmission(this.batchAuditForm)
        if (response.code === 200) {
          const result = response.data
          const successCount = result.successCount || 0
          const failCount = result.failCount || 0

          if (failCount === 0) {
            this.$message.success(`批量${this.operationText}成功，共处理 ${successCount} 条记录`)
          } else {
            this.$message.warning(
              `批量${this.operationText}完成，成功 ${successCount} 条，失败 ${failCount} 条`
            )
          }

          this.visible = false
          this.$emit('refresh')
        } else {
          this.$message.error(response.msg || `批量${this.operationText}失败`)
        }
      } catch (error) {
        this.$message.error(`批量${this.operationText}失败：` + error.message)
      } finally {
        this.submitting = false
      }
    },
    /** 关闭对话框 */
    handleClose() {
      this.visible = false
      this.resetForm()
    },
    /** 重置表单 */
    resetForm() {
      this.operation = 'APPROVE'
      this.submissionIds = []
      this.batchAuditForm = {
        submissionIds: [],
        operation: 'APPROVE',
        remark: ''
      }
      if (this.$refs.batchAuditForm) {
        this.$refs.batchAuditForm.resetFields()
      }
    }
  }
}
</script>

<style scoped lang="scss">
.batch-audit-container {
  ::v-deep .el-alert {
    p {
      margin: 0;
      line-height: 1.8;

      strong {
        color: #409EFF;
        font-size: 18px;
      }
    }
  }
}
</style>

