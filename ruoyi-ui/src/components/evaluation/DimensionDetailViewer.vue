<template>
  <div class="dimension-detail-viewer">
    <!-- 成果列表 -->
    <el-table
      v-if="detailList.length > 0"
      :data="detailList"
      border
      style="width: 100%"
    >
      <el-table-column label="序号" type="index" width="60" align="center" />
      
      <el-table-column label="类别" min-width="120">
        <template slot-scope="scope">
          {{ getRuleSnapshotField(scope.row, 'category') }}
        </template>
      </el-table-column>

      <el-table-column label="项目名称" min-width="150">
        <template slot-scope="scope">
          {{ getRuleSnapshotField(scope.row, 'itemName') }}
        </template>
      </el-table-column>

      <el-table-column label="等级" min-width="120">
        <template slot-scope="scope">
          {{ getRuleSnapshotField(scope.row, 'level') }}
        </template>
      </el-table-column>

      <el-table-column label="得分" width="100" align="center">
        <template slot-scope="scope">
          <el-tag :type="getScoreTagType(scope.row.finalScore)" size="medium">
            {{ scope.row.finalScore || 0 }}分
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="备注" min-width="150">
        <template slot-scope="scope">
          {{ scope.row.remark || '—' }}
        </template>
      </el-table-column>

      <el-table-column label="附件" min-width="150">
        <template slot-scope="scope">
          <div v-if="scope.row.attachments && scope.row.attachments.length > 0" class="attachment-list">
            <el-link
              v-for="(att, idx) in scope.row.attachments"
              :key="idx"
              type="primary"
              :underline="false"
              @click="handlePreviewAttachment(att)"
              style="margin-right: 10px;"
            >
              <i :class="getFileIcon(att.fileType)"></i>
              {{ att.originalName }}
            </el-link>
          </div>
          <span v-else>—</span>
        </template>
      </el-table-column>
    </el-table>

    <!-- 空状态 -->
    <el-empty
      v-else
      description="该维度暂无成果记录"
      :image-size="100"
    />

    <!-- 总分统计 -->
    <div v-if="detailList.length > 0" class="score-summary">
      <span>{{ dimensionName }}总分：</span>
      <el-tag type="success" size="large" effect="dark">{{ totalScore.toFixed(2) }}分</el-tag>
    </div>

    <!-- 图片预览对话框 -->
    <el-dialog
      title="附件预览"
      :visible.sync="previewDialogVisible"
      width="60%"
      append-to-body
    >
      <div class="preview-container">
        <img v-if="isImageFile(previewFileType)" :src="previewFileUrl" alt="附件预览" style="width: 100%; height: auto;">
        <div v-else class="non-image-preview">
          <i :class="getFileIcon(previewFileType)" style="font-size: 64px; color: #909399;"></i>
          <p>该文件类型不支持预览，请下载后查看</p>
          <el-button type="primary" @click="handleDownloadFile">下载文件</el-button>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'DimensionDetailViewer',
  props: {
    // 维度名称
    dimensionName: {
      type: String,
      required: true
    },
    // 详情列表
    detailList: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      previewDialogVisible: false,
      previewFileUrl: '',
      previewFileType: '',
      previewFileName: ''
    }
  },
  computed: {
    // 计算总分
    totalScore() {
      return this.detailList.reduce((sum, detail) => sum + (parseFloat(detail.finalScore) || 0), 0)
    }
  },
  methods: {
    // 获取 ruleSnapshot 中的字段值
    getRuleSnapshotField(row, fieldName) {
      if (!row.ruleSnapshot) {
        console.warn('[DimensionDetailViewer] ruleSnapshot 为空:', row)
        return '—'
      }

      let snapshot = row.ruleSnapshot

      // 如果是字符串，尝试解析
      if (typeof snapshot === 'string') {
        try {
          snapshot = JSON.parse(snapshot)
        } catch (e) {
          console.error('[DimensionDetailViewer] 解析 ruleSnapshot 失败:', e, snapshot)
          return '—'
        }
      }

      const value = snapshot[fieldName]
      console.log(`[DimensionDetailViewer] 获取字段 ${fieldName}:`, value, '完整snapshot:', snapshot)

      return value || '—'
    },

    // 获取分数标签类型
    getScoreTagType(score) {
      if (score >= 10) {
        return 'success'
      } else if (score >= 5) {
        return 'warning'
      } else if (score > 0) {
        return 'info'
      }
      return ''
    },

    // 获取文件图标
    getFileIcon(fileType) {
      if (!fileType) return 'el-icon-document'
      
      const type = fileType.toLowerCase()
      if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].includes(type)) {
        return 'el-icon-picture-outline'
      } else if (['pdf'].includes(type)) {
        return 'el-icon-document'
      } else if (['doc', 'docx'].includes(type)) {
        return 'el-icon-document'
      } else if (['xls', 'xlsx'].includes(type)) {
        return 'el-icon-s-grid'
      } else if (['zip', 'rar', '7z'].includes(type)) {
        return 'el-icon-folder-opened'
      }
      return 'el-icon-document'
    },

    // 判断是否为图片文件
    isImageFile(fileType) {
      if (!fileType) return false
      const type = fileType.toLowerCase()
      return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].includes(type)
    },

    // 预览附件
    handlePreviewAttachment(attachment) {
      console.log('[DimensionDetailViewer] 预览附件:', attachment)
      
      this.previewFileUrl = this.getAttachmentUrl(attachment)
      this.previewFileType = attachment.fileType
      this.previewFileName = attachment.originalName
      this.previewDialogVisible = true
    },

    // 获取附件URL
    getAttachmentUrl(attachment) {
      if (attachment.url) {
        // 如果URL是完整的HTTP地址，直接返回
        if (attachment.url.startsWith('http://') || attachment.url.startsWith('https://')) {
          return attachment.url
        }
        // 否则拼接基础URL
        return process.env.VUE_APP_BASE_API + attachment.url
      }
      
      // 兼容旧版本的filePath字段
      if (attachment.filePath) {
        if (attachment.filePath.startsWith('http://') || attachment.filePath.startsWith('https://')) {
          return attachment.filePath
        }
        return process.env.VUE_APP_BASE_API + attachment.filePath
      }
      
      return ''
    },

    // 下载文件
    handleDownloadFile() {
      if (this.previewFileUrl) {
        window.open(this.previewFileUrl, '_blank')
      }
    }
  }
}
</script>

<style scoped>
.dimension-detail-viewer {
  padding: 15px;
}

.attachment-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.score-summary {
  margin-top: 20px;
  padding: 15px;
  text-align: right;
  font-size: 16px;
  font-weight: bold;
  background-color: #f5f7fa;
  border-radius: 4px;
}

.score-summary span {
  margin-right: 10px;
  color: #606266;
}

.preview-container {
  text-align: center;
}

.non-image-preview {
  padding: 40px;
  text-align: center;
}

.non-image-preview p {
  margin: 20px 0;
  color: #909399;
  font-size: 14px;
}
</style>

