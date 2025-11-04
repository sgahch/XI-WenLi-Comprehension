<template>
  <el-dialog
    :title="dialogTitle"
    :visible.sync="visible"
    width="80%"
    :close-on-click-modal="false"
    @close="handleClose"
  >
    <div v-loading="loading" class="audit-detail-container">
      <!-- 学生基本信息 -->
      <el-card shadow="never" class="info-card">
        <div slot="header">
          <i class="el-icon-user"></i>
          学生基本信息
        </div>
        <el-descriptions :column="3" border>
          <el-descriptions-item label="姓名">{{ submissionDetail.studentName }}</el-descriptions-item>
          <el-descriptions-item label="学号">{{ submissionDetail.studentNumber }}</el-descriptions-item>
          <el-descriptions-item label="班级">{{ submissionDetail.className }}</el-descriptions-item>
          <el-descriptions-item label="学年学期" :span="2">
            {{ submissionDetail.academicYear }} 第{{ submissionDetail.semester }}学期
          </el-descriptions-item>
          <el-descriptions-item label="提交时间">
            {{ parseTime(submissionDetail.submitTime) }}
          </el-descriptions-item>
        </el-descriptions>
      </el-card>

      <!-- 成绩汇总 -->
      <el-card shadow="never" class="score-card">
        <div slot="header">
          <i class="el-icon-data-line"></i>
          成绩汇总
          <span style="margin-left: 10px; font-size: 14px; color: #909399;">
            (点击维度卡片查看详情)
          </span>
        </div>
        <el-row :gutter="20">
          <el-col :span="4">
            <div
              class="score-item clickable"
              :class="{ active: activeDimension === 'moral' }"
              @click="switchDimension('moral')"
            >
              <div class="score-label">德育</div>
              <div class="score-value moral">{{ submissionDetail.moralScore || 0 }}</div>
            </div>
          </el-col>
          <el-col :span="4">
            <div
              class="score-item clickable"
              :class="{ active: activeDimension === 'intellectual' }"
              @click="switchDimension('intellectual')"
            >
              <div class="score-label">智育</div>
              <div class="score-value intellectual">{{ submissionDetail.intellectualScore || 0 }}</div>
            </div>
          </el-col>
          <el-col :span="4">
            <div
              class="score-item clickable"
              :class="{ active: activeDimension === 'physical' }"
              @click="switchDimension('physical')"
            >
              <div class="score-label">体育</div>
              <div class="score-value physical">{{ submissionDetail.physicalScore || 0 }}</div>
            </div>
          </el-col>
          <el-col :span="4">
            <div
              class="score-item clickable"
              :class="{ active: activeDimension === 'aesthetic' }"
              @click="switchDimension('aesthetic')"
            >
              <div class="score-label">美育</div>
              <div class="score-value aesthetic">{{ submissionDetail.aestheticScore || 0 }}</div>
            </div>
          </el-col>
          <el-col :span="4">
            <div
              class="score-item clickable"
              :class="{ active: activeDimension === 'labor' }"
              @click="switchDimension('labor')"
            >
              <div class="score-label">劳育</div>
              <div class="score-value labor">{{ submissionDetail.laborScore || 0 }}</div>
            </div>
          </el-col>
          <el-col :span="4">
            <div class="score-item total">
              <div class="score-label">总分</div>
              <div class="score-value">{{ submissionDetail.totalScore || 0 }}</div>
            </div>
          </el-col>
        </el-row>
      </el-card>

      <!-- 维度详情展示区域 -->
      <el-card v-if="activeDimension" shadow="never" class="dimension-detail-card">
        <div slot="header">
          <i class="el-icon-document"></i>
          {{ getDimensionName(activeDimension) }}详情
        </div>

        <!-- 成绩截图核验（仅智育维度显示） -->
        <grade-screenshot-viewer
          v-if="activeDimension === 'intellectual' && intellectualDetailId"
          :detail-id="intellectualDetailId"
          :grade-data="gradeDataList"
        />

        <!-- 维度成果详情 -->
        <dimension-detail-viewer
          :dimension-name="getDimensionName(activeDimension)"
          :detail-list="getActiveDimensionDetails()"
        />
      </el-card>

      <!-- 证明材料预览 -->
      <el-card v-if="certificateList.length > 0" shadow="never" class="certificate-card">
        <div slot="header">
          <i class="el-icon-folder-opened"></i>
          证明材料
          <span class="certificate-count">(共{{ certificateList.length }}个文件)</span>
        </div>
        <div class="certificate-list">
          <div
            v-for="(cert, index) in certificateList"
            :key="index"
            class="certificate-item"
          >
            <div class="certificate-info">
              <i :class="getFileIcon(cert.fileType)" class="file-icon"></i>
              <div class="file-details">
                <div class="file-name" :title="cert.originalName">{{ cert.originalName }}</div>
                <div class="file-meta">
                  <span>{{ formatFileSize(cert.fileSize) }}</span>
                  <span class="separator">|</span>
                  <span>{{ cert.fileType }}</span>
                  <span class="separator">|</span>
                  <span>{{ parseTime(cert.uploadTime, '{y}-{m}-{d}') }}</span>
                </div>
              </div>
            </div>
            <div class="certificate-actions">
              <el-button
                v-if="isImageFile(cert.fileType)"
                type="text"
                size="small"
                icon="el-icon-view"
                @click="handlePreviewCertificate(cert)"
              >
                预览
              </el-button>
              <el-button
                type="text"
                size="small"
                icon="el-icon-download"
                @click="handleDownloadCertificate(cert)"
              >
                下载
              </el-button>
            </div>
          </div>
        </div>
      </el-card>

      <!-- 自我评价 -->
      <el-card v-if="submissionDetail.selfEvaluation" shadow="never" class="evaluation-card">
        <div slot="header">
          <i class="el-icon-edit-outline"></i>
          自我评价
        </div>
        <div class="evaluation-content">
          {{ submissionDetail.selfEvaluation }}
        </div>
      </el-card>

      <!-- 图片预览对话框 -->
      <el-dialog
        title="证明材料预览"
        :visible.sync="previewDialogVisible"
        width="60%"
        append-to-body
      >
        <div class="preview-container">
          <img :src="previewImageUrl" alt="证明材料" style="width: 100%; height: auto;">
        </div>
      </el-dialog>

      <!-- 审核历史 -->
      <el-card v-if="auditLogs.length > 0" shadow="never" class="audit-history-card">
        <div slot="header">
          <i class="el-icon-time"></i>
          审核历史
        </div>
        <el-timeline>
          <el-timeline-item
            v-for="(log, index) in auditLogs"
            :key="index"
            :timestamp="parseTime(log.auditTime)"
            placement="top"
            :type="getTimelineType(log.operation)"
            :icon="getTimelineIcon(log.operation)"
          >
            <el-card>
              <h4>{{ getOperationText(log.operation) }}</h4>
              <p>审核人：{{ log.auditorName }}</p>
              <p v-if="log.remark">审核意见：{{ log.remark }}</p>
            </el-card>
          </el-timeline-item>
        </el-timeline>
      </el-card>

      <!-- 审核操作区 -->
      <el-card v-if="!viewOnly && submissionDetail.status === 1" shadow="never" class="audit-action-card">
        <div slot="header">
          <i class="el-icon-edit"></i>
          审核操作
        </div>
        <el-form ref="auditForm" :model="auditForm" :rules="auditRules" label-width="100px">
          <el-form-item label="审核结果" prop="operation">
            <el-radio-group v-model="auditForm.operation">
              <el-radio label="APPROVE">
                <el-tag type="success" size="medium">通过</el-tag>
              </el-radio>
              <el-radio label="REJECT">
                <el-tag type="danger" size="medium">驳回</el-tag>
              </el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="审核意见" prop="remark">
            <el-input
              v-model="auditForm.remark"
              type="textarea"
              :rows="4"
              placeholder="请输入审核意见（驳回时必填）"
              maxlength="500"
              show-word-limit
            />
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <div slot="footer" class="dialog-footer">
      <el-button @click="handleClose">取 消</el-button>
      <el-button
        v-if="!viewOnly && submissionDetail.status === 1"
        type="primary"
        :loading="submitting"
        @click="handleSubmitAudit"
      >
        提交审核
      </el-button>
    </div>
  </el-dialog>
</template>

<script>
import { getSubmission, auditSubmission } from '@/api/evaluation/submission'
import { listAuditLog } from '@/api/evaluation/auditLog'
import { getCertificates } from '@/api/evaluation/attachment'
import GradeScreenshotViewer from '@/components/evaluation/GradeScreenshotViewer'
import DimensionDetailViewer from '@/components/evaluation/DimensionDetailViewer'

export default {
  name: 'AuditDetailDialog',
  components: {
    GradeScreenshotViewer,
    DimensionDetailViewer
  },
  data() {
    return {
      visible: false,
      loading: false,
      submitting: false,
      viewOnly: false,
      submissionDetail: {},
      intellectualDetailId: null, // 智育维度的detailId
      activeDimension: 'intellectual', // 当前激活的维度，默认智育
      auditLogs: [],
      gradeDataList: [],
      certificateList: [],
      previewDialogVisible: false,
      previewImageUrl: '',
      auditForm: {
        submissionId: null,
        operation: 'APPROVE',
        remark: ''
      },
      auditRules: {
        operation: [
          { required: true, message: '请选择审核结果', trigger: 'change' }
        ],
        remark: [
          { required: false, message: '请输入审核意见', trigger: 'blur' },
          { validator: this.validateRemark, trigger: 'blur' }
        ]
      }
    }
  },
  computed: {
    dialogTitle() {
      return this.viewOnly ? '查看详情' : '审核详情'
    }
  },
  methods: {
    /** 打开对话框 */
    open(submissionId, viewOnly = false) {
      this.visible = true
      this.viewOnly = viewOnly
      this.auditForm.submissionId = submissionId
      this.loadDetail(submissionId)
      this.loadAuditLogs(submissionId)
      this.loadCertificates(submissionId)
    },
    /** 加载详情 */
    async loadDetail(submissionId) {
      this.loading = true
      try {
        console.log('=== [班委审核] 开始加载填报详情 ===')
        console.log('填报记录ID (submissionId):', submissionId)

        const response = await getSubmission(submissionId)
        console.log('后端返回的完整数据:', response)

        if (response.code === 200) {
          this.submissionDetail = response.data
          console.log('填报详情 (submissionDetail):', this.submissionDetail)
          console.log('详情列表 (details):', this.submissionDetail.details)

          // 查找智育维度的detailId
          this.intellectualDetailId = this.findIntellectualDetailId(response.data)
          console.log('✅ 找到智育维度的detailId:', this.intellectualDetailId)

          if (!this.intellectualDetailId) {
            console.warn('⚠️ 未找到智育维度的detailId，成绩截图将无法显示')
          }

          // 从智育维度的详情中提取课程成绩数据
          this.gradeDataList = this.extractGradeData(response.data)
          console.log('✅ 提取到课程成绩数据:', this.gradeDataList)
        }
      } catch (error) {
        console.error('❌ 加载详情失败:', error)
        this.$message.error('加载详情失败')
      } finally {
        this.loading = false
      }
    },
    /** 查找智育维度的detailId */
    findIntellectualDetailId(submissionDetail) {
      console.log('--- 开始查找智育维度的detailId ---')

      if (!submissionDetail || !submissionDetail.details) {
        console.warn('⚠️ submissionDetail 或 details 为空')
        return null
      }

      console.log(`共有 ${submissionDetail.details.length} 个维度详情`)

      for (let i = 0; i < submissionDetail.details.length; i++) {
        const detail = submissionDetail.details[i]
        console.log(`\n检查第 ${i + 1} 个详情:`, detail)

        if (detail.ruleSnapshot) {
          try {
            const snapshot = typeof detail.ruleSnapshot === 'string'
              ? JSON.parse(detail.ruleSnapshot)
              : detail.ruleSnapshot

            console.log(`  规则快照 (ruleSnapshot):`, snapshot)
            console.log(`  dimensionType: ${snapshot.dimensionType}`)
            console.log(`  dimension: ${snapshot.dimension}`)

            // 检查 dimensionType（数字类型）：1=智育
            if (snapshot.dimensionType === 1) {
              console.log(`  ✅ 找到智育维度！detailId = ${detail.id}`)
              return detail.id
            }

            // 兼容旧版本：检查 dimension（字符串类型）
            if (snapshot.dimension === 'intellectual') {
              console.log(`  ✅ 找到智育维度（旧版本）！detailId = ${detail.id}`)
              return detail.id
            }

            console.log(`  ❌ 不是智育维度，跳过`)
          } catch (e) {
            console.error(`  ❌ 解析ruleSnapshot失败:`, e)
          }
        } else {
          console.log(`  ⚠️ 该详情没有ruleSnapshot`)
        }
      }

      console.log('❌ 未找到智育维度的detailId')
      return null
    },
    /** 从智育维度的详情中提取课程成绩数据 */
    extractGradeData(submissionDetail) {
      console.log('--- 开始提取课程成绩数据 ---')

      if (!submissionDetail || !submissionDetail.details) {
        console.warn('⚠️ submissionDetail 或 details 为空')
        return []
      }

      const gradeDataList = []

      // 遍历所有详情，找到智育维度且类别为"课程成绩"的项
      submissionDetail.details.forEach(detail => {
        try {
          // 解析 ruleSnapshot
          const snapshot = typeof detail.ruleSnapshot === 'string'
            ? JSON.parse(detail.ruleSnapshot)
            : detail.ruleSnapshot

          // 检查是否是智育维度的课程成绩
          if (snapshot.dimensionType === 1 && snapshot.category === '课程成绩') {
            // 从 snapshot 或 detail 中提取课程信息
            const gradeData = {
              courseName: snapshot.itemName || snapshot.courseName || '未知课程',
              courseCode: snapshot.courseCode || '',
              credit: snapshot.credit || 0,
              score: detail.grade || snapshot.grade || 0,
              gradePoint: snapshot.gradePoint || 0
            }

            gradeDataList.push(gradeData)
            console.log(`  ✅ 提取课程: ${gradeData.courseName}, 成绩: ${gradeData.score}`)
          }
        } catch (e) {
          console.error('解析详情失败:', e, detail)
        }
      })

      console.log(`--- 提取完成，共 ${gradeDataList.length} 门课程 ---`)
      return gradeDataList
    },
    /** 加载审核历史 */
    async loadAuditLogs(submissionId) {
      try {
        const response = await listAuditLog({ submissionId })
        if (response.code === 200) {
          this.auditLogs = response.rows || []
        }
      } catch (error) {
        console.error('加载审核历史失败', error)
      }
    },
    /** 加载证明材料 */
    async loadCertificates(submissionId) {
      try {
        const response = await getCertificates(submissionId)
        if (response.code === 200) {
          this.certificateList = response.data || []
        }
      } catch (error) {
        console.error('加载证明材料失败', error)
      }
    },
    /** 切换维度 */
    switchDimension(dimension) {
      console.log('[班委审核] 切换到维度:', dimension)
      this.activeDimension = dimension
    },
    /** 获取维度名称 */
    getDimensionName(dimension) {
      const nameMap = {
        'moral': '德育',
        'intellectual': '智育',
        'physical': '体育',
        'aesthetic': '美育',
        'labor': '劳育'
      }
      return nameMap[dimension] || dimension
    },
    /** 获取当前激活维度的详情列表 */
    getActiveDimensionDetails() {
      if (!this.submissionDetail.details) {
        return []
      }

      const dimensionTypeMap = {
        'moral': 2,
        'intellectual': 1,
        'physical': 3,
        'aesthetic': 4,
        'labor': 5
      }

      const targetType = dimensionTypeMap[this.activeDimension]

      console.log(`[班委审核] 获取${this.getDimensionName(this.activeDimension)}详情, dimensionType=${targetType}`)

      const details = this.submissionDetail.details.filter(detail => {
        if (detail.ruleSnapshot) {
          try {
            const snapshot = typeof detail.ruleSnapshot === 'string'
              ? JSON.parse(detail.ruleSnapshot)
              : detail.ruleSnapshot
            return snapshot.dimensionType === targetType
          } catch (e) {
            console.error('解析ruleSnapshot失败:', e)
            return false
          }
        }
        return false
      })

      console.log(`[班委审核] 找到${details.length}条${this.getDimensionName(this.activeDimension)}详情`)
      return details
    },
    /** 验证审核意见 */
    validateRemark(rule, value, callback) {
      if (this.auditForm.operation === 'REJECT' && !value) {
        callback(new Error('驳回时必须填写审核意见'))
      } else {
        callback()
      }
    },
    /** 提交审核 */
    handleSubmitAudit() {
      this.$refs.auditForm.validate(valid => {
        if (valid) {
          this.$confirm('确认提交审核结果吗？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.submitAudit()
          })
        }
      })
    },
    /** 执行审核 */
    async submitAudit() {
      this.submitting = true
      try {
        const response = await auditSubmission(this.auditForm)
        if (response.code === 200) {
          this.$message.success('审核成功')
          this.visible = false
          this.$emit('refresh')
        } else {
          this.$message.error(response.msg || '审核失败')
        }
      } catch (error) {
        this.$message.error('审核失败：' + error.message)
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
      this.submissionDetail = {}
      this.intellectualDetailId = null
      this.auditLogs = []
      this.gradeDataList = []
      this.certificateList = []
      this.auditForm = {
        submissionId: null,
        operation: 'APPROVE',
        remark: ''
      }
      if (this.$refs.auditForm) {
        this.$refs.auditForm.resetFields()
      }
    },
    /** 获取文件图标 */
    getFileIcon(fileType) {
      const type = fileType.toLowerCase()
      const iconMap = {
        'pdf': 'el-icon-document',
        'doc': 'el-icon-document',
        'docx': 'el-icon-document',
        'xls': 'el-icon-document',
        'xlsx': 'el-icon-document',
        'jpg': 'el-icon-picture-outline',
        'jpeg': 'el-icon-picture-outline',
        'png': 'el-icon-picture-outline'
      }
      return iconMap[type] || 'el-icon-document'
    },
    /** 判断是否为图片文件 */
    isImageFile(fileType) {
      const type = fileType.toLowerCase()
      return ['jpg', 'jpeg', 'png', 'gif', 'bmp'].includes(type)
    },
    /** 格式化文件大小 */
    formatFileSize(bytes) {
      if (!bytes || bytes === 0) return '0 B'
      const k = 1024
      const sizes = ['B', 'KB', 'MB', 'GB']
      const i = Math.floor(Math.log(bytes) / Math.log(k))
      return (bytes / Math.pow(k, i)).toFixed(2) + ' ' + sizes[i]
    },
    /** 获取附件完整URL */
    getAttachmentUrl(cert) {
      console.log('[班委审核] 获取附件URL:', cert)

      // 优先使用url字段
      if (cert.url) {
        // 如果URL是完整的HTTP地址，直接返回
        if (cert.url.startsWith('http://') || cert.url.startsWith('https://')) {
          return cert.url
        }
        // 否则拼接基础URL
        return process.env.VUE_APP_BASE_API + cert.url
      }

      // 兼容旧版本的filePath字段
      if (cert.filePath) {
        if (cert.filePath.startsWith('http://') || cert.filePath.startsWith('https://')) {
          return cert.filePath
        }
        return process.env.VUE_APP_BASE_API + cert.filePath
      }

      console.warn('[班委审核] 附件URL为空:', cert)
      return ''
    },
    /** 预览证明材料 */
    handlePreviewCertificate(cert) {
      console.log('[班委审核] 预览证明材料:', cert)

      if (this.isImageFile(cert.fileType)) {
        const url = this.getAttachmentUrl(cert)
        console.log('[班委审核] 预览图片URL:', url)

        if (!url) {
          this.$message.error('附件URL为空，无法预览')
          return
        }

        this.previewImageUrl = url
        this.previewDialogVisible = true
      } else {
        this.$message.warning('该文件类型不支持预览，请下载后查看')
      }
    },
    /** 下载证明材料 */
    handleDownloadCertificate(cert) {
      console.log('[班委审核] 下载证明材料:', cert)

      const url = this.getAttachmentUrl(cert)
      console.log('[班委审核] 下载URL:', url)

      if (!url) {
        this.$message.error('附件URL为空，无法下载')
        return
      }

      const link = document.createElement('a')
      link.href = url
      link.download = cert.originalName || 'download'
      link.target = '_blank'
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
    },
    /** 获取操作文本 */
    getOperationText(operation) {
      const map = {
        'SUBMIT': '学生提交',
        'APPROVE': '审核通过',
        'REJECT': '审核驳回'
      }
      return map[operation] || operation
    },
    /** 获取时间线类型 */
    getTimelineType(operation) {
      const map = {
        'SUBMIT': 'primary',
        'APPROVE': 'success',
        'REJECT': 'danger'
      }
      return map[operation] || 'info'
    },
    /** 获取时间线图标 */
    getTimelineIcon(operation) {
      const map = {
        'SUBMIT': 'el-icon-upload',
        'APPROVE': 'el-icon-check',
        'REJECT': 'el-icon-close'
      }
      return map[operation] || 'el-icon-info'
    }
  }
}
</script>

<style scoped lang="scss">
.audit-detail-container {
  .info-card,
  .score-card,
  .evaluation-card,
  .audit-history-card,
  .audit-action-card {
    margin-bottom: 20px;

    ::v-deep .el-card__header {
      font-weight: 500;
      font-size: 15px;

      i {
        color: #409EFF;
        margin-right: 6px;
      }
    }
  }

  .score-card {
    .score-item {
      text-align: center;
      padding: 20px;
      border-radius: 4px;
      background: #F5F7FA;

      .score-label {
        font-size: 14px;
        color: #606266;
        margin-bottom: 10px;
      }

      .score-value {
        font-size: 28px;
        font-weight: bold;

        &.moral { color: #E6A23C; }
        &.intellectual { color: #409EFF; }
        &.physical { color: #67C23A; }
        &.aesthetic { color: #F56C6C; }
        &.labor { color: #909399; }
      }

      &.total {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

        .score-label {
          color: #fff;
        }

        .score-value {
          color: #fff;
        }
      }

      // 可点击样式
      &.clickable {
        cursor: pointer;
        transition: all 0.3s;

        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        &.active {
          border: 2px solid #409EFF;
          background-color: #ecf5ff;
          box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
        }
      }
    }
  }

  // 维度详情卡片
  .dimension-detail-card {
    margin-top: 20px;
  }

  .evaluation-content {
    line-height: 1.8;
    color: #606266;
    white-space: pre-wrap;
  }

  .certificate-card {
    .certificate-count {
      font-size: 12px;
      color: #909399;
      margin-left: 8px;
    }

    .certificate-list {
      .certificate-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 12px;
        border: 1px solid #EBEEF5;
        border-radius: 4px;
        margin-bottom: 10px;
        transition: all 0.3s;

        &:hover {
          background-color: #F5F7FA;
          border-color: #409EFF;
        }

        &:last-child {
          margin-bottom: 0;
        }

        .certificate-info {
          display: flex;
          align-items: center;
          flex: 1;
          min-width: 0;

          .file-icon {
            font-size: 32px;
            color: #409EFF;
            margin-right: 12px;
            flex-shrink: 0;
          }

          .file-details {
            flex: 1;
            min-width: 0;

            .file-name {
              font-size: 14px;
              color: #303133;
              margin-bottom: 4px;
              overflow: hidden;
              text-overflow: ellipsis;
              white-space: nowrap;
            }

            .file-meta {
              font-size: 12px;
              color: #909399;

              .separator {
                margin: 0 8px;
              }
            }
          }
        }

        .certificate-actions {
          display: flex;
          gap: 8px;
          flex-shrink: 0;
        }
      }
    }
  }
}

.preview-container {
  text-align: center;

  img {
    max-width: 100%;
    height: auto;
  }
}
</style>

