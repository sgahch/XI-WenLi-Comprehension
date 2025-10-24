<template>
  <el-dialog
    :visible.sync="visible"
    title="批量导入综测数据"
    width="700px"
    append-to-body
    @close="closeDialog"
  >
    <div class="upload-area">
      <el-upload
        ref="upload"
        class="upload-block"
        drag
        :action="uploadUrl"
        :headers="uploadHeaders"
        :data="uploadData"
        :on-success="handleSuccess"
        :on-error="handleError"
        :before-upload="beforeUpload"
        :auto-upload="false"
        accept=".xlsx,.xls"
      >
        <i class="el-icon-upload" />
        <div class="el-upload__text">将 Excel 文件拖到此处，或 <em>点击上传</em></div>
        <div slot="tip" class="el-upload__tip">只能上传 .xlsx/.xls 文件，且不超过 10MB</div>
      </el-upload>

      <div class="template-actions">
        <el-button type="primary" plain @click="downloadTemplate">
          <i class="el-icon-download" /> 下载导入模板
        </el-button>
      </div>
    </div>

    <span slot="footer" class="dialog-footer">
      <el-button @click="closeDialog">取 消</el-button>
      <el-button type="primary" :loading="uploading" @click="submitUpload">上传文件</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { getToken } from '@/utils/auth'
import { downloadImportTemplate } from '@/api/evaluation/semesterScore'

export default {
  name: 'ExcelImportDialog',
  props: {
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      uploading: false
    }
  },
  computed: {
    uploadUrl() {
      return process.env.VUE_APP_BASE_API + '/evaluation/semesterScore/import'
    },
    uploadHeaders() {
      return { Authorization: 'Bearer ' + getToken() }
    },
    uploadData() {
      return {}
    }
  },
  methods: {
    closeDialog() {
      this.$emit('update:visible', false)
    },
    beforeUpload(file) {
      const isExcel = file.type === 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' || file.type === 'application/vnd.ms-excel'
      const isLt10M = file.size / 1024 / 1024 < 10
      if (!isExcel) {
        this.$message.error('只能上传 Excel 文件！')
        return false
      }
      if (!isLt10M) {
        this.$message.error('上传文件大小不能超过 10MB！')
        return false
      }
      return true
    },
    submitUpload() {
      const uploader = this.$refs.upload
      if (!uploader) return
      if (!uploader.uploadFiles || uploader.uploadFiles.length === 0) {
        this.$message.warning('请先选择文件')
        return
      }
      this.uploading = true
      uploader.submit()
    },
    handleSuccess(response) {
      this.uploading = false
      if (response && (response.code === 200 || response.success)) {
        this.$message.success('导入成功')
        this.$emit('success', response.data || {})
        this.closeDialog()
      } else {
        this.$message.error(response && response.msg ? response.msg : '导入失败')
      }
    },
    handleError(err) {
      this.uploading = false
      this.$message.error('上传失败：' + (err && err.message ? err.message : '未知错误'))
    },
    async downloadTemplate() {
      try {
        const res = await downloadImportTemplate()
        const blob = new Blob([res], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
        const url = window.URL.createObjectURL(blob)
        const a = document.createElement('a')
        a.href = url
        a.download = '综测成绩导入模板.xlsx'
        a.click()
        window.URL.revokeObjectURL(url)
        this.$message.success('模板下载成功')
      } catch (e) {
        this.$message.error('模板下载失败：' + e.message)
      }
    }
  }
}
</script>

<style scoped>
.upload-area { text-align: center; padding: 20px; }
.template-actions { margin-top: 16px; }
.el-upload__tip { margin-top: 10px; color: #909399; font-size: 13px; }
</style>