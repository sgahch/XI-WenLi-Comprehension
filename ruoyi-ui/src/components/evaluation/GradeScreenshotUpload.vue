<template>
  <div class="grade-screenshot-upload">
    <div class="upload-header">
      <span class="header-title">
        <i class="el-icon-picture-outline"></i>
        成绩截图上传
      </span>
      <el-tooltip content="上传教务系统成绩截图，便于班委核验" placement="top">
        <i class="el-icon-question"></i>
      </el-tooltip>
    </div>

    <el-upload
      ref="upload"
      :action="uploadUrl"
      :headers="uploadHeaders"
      :data="uploadData"
      :file-list="fileList"
      :on-success="handleUploadSuccess"
      :on-error="handleUploadError"
      :on-remove="handleRemove"
      :on-preview="handlePreview"
      :before-upload="beforeUpload"
      :limit="limit"
      :on-exceed="handleExceed"
      list-type="picture-card"
      accept="image/jpeg,image/jpg,image/png"
    >
      <i class="el-icon-plus"></i>
      <div slot="tip" class="el-upload__tip">
        <p>只能上传 JPG/PNG 格式的图片，且单个文件不超过 {{ fileSize }}MB</p>
        <p class="tip-highlight">请上传教务系统的成绩截图，确保成绩清晰可见</p>
      </div>
    </el-upload>

    <!-- 图片预览对话框 -->
    <el-dialog
      title="成绩截图预览"
      :visible.sync="previewDialogVisible"
      width="60%"
      append-to-body
    >
      <img :src="previewImageUrl" style="width: 100%; display: block;" />
    </el-dialog>
  </div>
</template>

<script>
import { getToken } from '@/utils/auth'

export default {
  name: 'GradeScreenshotUpload',
  props: {
    // 填报ID（优先使用）
    submissionId: {
      type: Number,
      default: null
    },
    // 详情ID（可选，用于兼容旧代码）
    detailId: {
      type: Number,
      default: null
    },
    // 已上传的文件列表
    value: {
      type: Array,
      default: () => []
    },
    // 最大上传数量
    limit: {
      type: Number,
      default: 3
    },
    // 单个文件大小限制(MB)
    fileSize: {
      type: Number,
      default: 5
    },
    // 是否为查看模式
    isViewMode: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      fileList: [],
      previewDialogVisible: false,
      previewImageUrl: ''
    }
  },
  computed: {
    uploadUrl() {
      // 使用通用上传接口，不需要submissionId或detailId
      return process.env.VUE_APP_BASE_API + '/common/upload'
    },
    uploadHeaders() {
      return {
        Authorization: 'Bearer ' + getToken()
      }
    },
    // 上传时附加的额外参数
    uploadData() {
      const data = {}
      // 如果有submissionId，则传递
      if (this.submissionId) {
        data.submissionId = this.submissionId
      }
      // 如果有detailId，则传递（兼容旧代码）
      if (this.detailId) {
        data.detailId = this.detailId
      }
      return data
    }
  },
  watch: {
    value: {
      handler(val) {
        if (val && val.length > 0) {
          this.fileList = val.map(item => ({
            name: item.originalName || item.fileName,
            url: item.url,
            uid: item.id,
            response: item
          }))
        } else {
          this.fileList = []
        }
      },
      immediate: true,
      deep: true
    }
  },
  methods: {
    // 上传前校验
    beforeUpload(file) {
      // 检查文件类型
      const isImage = file.type === 'image/jpeg' || file.type === 'image/jpg' || file.type === 'image/png'
      if (!isImage) {
        this.$message.error('只能上传 JPG/PNG 格式的图片!')
        return false
      }

      // 检查文件大小
      const isLtSize = file.size / 1024 / 1024 < this.fileSize
      if (!isLtSize) {
        this.$message.error(`图片大小不能超过 ${this.fileSize}MB!`)
        return false
      }

      return true
    },

    // 上传成功
    handleUploadSuccess(response, file, fileList) {
      if (response.code === 200) {
        this.$message.success('成绩截图上传成功')

        // 更新文件列表，提取URL（通用上传接口返回的是response.url，不是response.data.url）
        const screenshots = fileList.map(item => {
          if (item.response && item.response.url) {
            return {
              url: item.response.url,
              fileName: item.response.fileName,
              name: item.name || item.response.originalFilename
            }
          }
          return null
        }).filter(item => item !== null)

        // 触发change事件，传递截图URL列表
        this.$emit('input', screenshots)
        this.$emit('change', screenshots)

        console.log('成绩截图已更新:', screenshots)
      } else {
        this.$message.error(response.msg || '上传失败')
        // 移除失败的文件
        const index = fileList.indexOf(file)
        if (index > -1) {
          fileList.splice(index, 1)
        }
      }
    },

    // 上传失败
    handleUploadError(err, file, fileList) {
      this.$message.error('上传失败: ' + err.message)
    },

    // 移除文件
    handleRemove(file, fileList) {
      const attachments = fileList.map(item => {
        if (item.response && item.response.data) {
          return item.response.data
        }
        return item.response || item
      })
      this.$emit('input', attachments)
      this.$emit('change', attachments)
    },

    // 预览图片
    handlePreview(file) {
      this.previewImageUrl = file.url
      this.previewDialogVisible = true
    },

    // 超出文件数量限制
    handleExceed(files, fileList) {
      this.$message.warning(`最多只能上传 ${this.limit} 张成绩截图`)
    }
  }
}
</script>

<style scoped lang="scss">
.grade-screenshot-upload {
  .upload-header {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    
    .header-title {
      font-size: 14px;
      font-weight: 500;
      color: #303133;
      margin-right: 8px;
      
      i {
        color: #409EFF;
        margin-right: 4px;
      }
    }
    
    .el-icon-question {
      color: #909399;
      cursor: help;
      font-size: 16px;
    }
  }

  ::v-deep .el-upload__tip {
    margin-top: 8px;
    line-height: 1.6;
    
    p {
      margin: 4px 0;
      color: #606266;
      font-size: 12px;
    }
    
    .tip-highlight {
      color: #E6A23C;
      font-weight: 500;
    }
  }

  ::v-deep .el-upload-list__item {
    transition: all 0.3s;
    
    &:hover {
      transform: scale(1.05);
    }
  }
}
</style>

