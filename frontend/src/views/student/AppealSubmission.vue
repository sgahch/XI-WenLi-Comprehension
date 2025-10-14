<template>
  <div class="appeal-submission-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h1>成绩申诉</h1>
      <p>对综合测评成绩有异议？提交申诉申请</p>
    </div>

    <!-- 申诉须知 -->
    <el-card class="notice-card">
      <template #header>
        <div class="card-header">
          <span>申诉须知</span>
        </div>
      </template>
      <div class="notice-content">
        <ol>
          <li>申诉期限：成绩公布后3个工作日内</li>
          <li>请详细说明申诉理由，并提供相关证明材料</li>
          <li>每个项目只能申诉一次</li>
          <li>申诉结果将在提交后5个工作日内反馈</li>
          <li>恶意申诉将影响您的综合素质评价</li>
        </ol>
      </div>
    </el-card>

    <!-- 申诉表单 -->
    <div class="appeal-form-section">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>申诉信息填写</span>
          </div>
        </template>

        <el-form
          ref="appealFormRef"
          :model="appealForm"
          :rules="appealRules"
          label-width="120px"
          class="appeal-form"
        >
          <!-- 学期选择 -->
          <el-form-item label="测评学期" prop="semesterId">
            <el-select v-model="appealForm.semesterId" placeholder="请选择测评学期" @change="handleSemesterChange">
              <el-option
                v-for="semester in availableSemesters"
                :key="semester.id"
                :label="semester.name"
                :value="semester.id"
              />
            </el-select>
          </el-form-item>

          <!-- 申诉项目选择 -->
          <el-form-item label="申诉项目" prop="evaluationItemId">
            <el-select v-model="appealForm.evaluationItemId" placeholder="请选择申诉项目">
              <el-option
                v-for="item in availableEvaluationItems"
                :key="item.id"
                :label="`${item.category} - ${item.name}`"
                :value="item.id"
              />
            </el-select>
          </el-form-item>

          <!-- 当前得分 -->
          <el-form-item label="当前得分">
            <el-input v-model="currentScore" disabled />
          </el-form-item>

          <!-- 期望得分 -->
          <el-form-item label="期望得分" prop="expectedScore">
            <el-input v-model.number="appealForm.expectedScore" type="number" placeholder="请输入期望得分" />
          </el-form-item>

          <!-- 申诉理由 -->
          <el-form-item label="申诉理由" prop="appealReason">
            <el-input
              v-model="appealForm.appealReason"
              type="textarea"
              :rows="5"
              placeholder="请详细描述您的申诉理由，包括事实依据和相关说明"
            />
          </el-form-item>

          <!-- 证明材料上传 -->
          <el-form-item label="证明材料">
            <el-upload
              class="upload-demo"
              action=""
              :on-change="handleFileChange"
              :before-upload="beforeUpload"
              :auto-upload="false"
              :file-list="fileList"
              :on-remove="handleRemove"
              multiple
            >
              <el-button type="primary">选择文件</el-button>
              <template #tip>
                <div class="el-upload__tip">
                  支持jpg/png/pdf/doc/docx格式文件，单个文件不超过10MB，最多上传5个文件
                </div>
              </template>
            </el-upload>
          </el-form-item>

          <!-- 联系方式 -->
          <el-form-item label="联系方式" prop="contactInfo">
            <el-input v-model="appealForm.contactInfo" placeholder="请留下您的联系电话或邮箱" />
          </el-form-item>

          <!-- 提交按钮 -->
          <el-form-item>
            <el-button type="primary" @click="submitAppeal" :loading="submitting">
              提交申诉
            </el-button>
            <el-button @click="resetForm">取消</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <!-- 申诉记录 -->
    <div class="appeal-records-section">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>申诉记录</span>
          </div>
        </template>

        <el-table
          :data="appealRecords"
          style="width: 100%"
          stripe
          border
          v-loading="loadingRecords"
          element-loading-text="加载中..."
        >
          <el-table-column prop="semesterName" label="测评学期" width="180" />
          <el-table-column prop="itemName" label="申诉项目" min-width="200" />
          <el-table-column prop="originalScore" label="原得分" width="100" />
          <el-table-column prop="expectedScore" label="期望得分" width="100" />
          <el-table-column prop="status" label="状态" width="100">
            <template #default="scope">
              <el-tag :type="getStatusTagType(scope.row.status)">
                {{ getStatusText(scope.row.status) }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="submitTime" label="提交时间" width="180" />
          <el-table-column prop="processTime" label="处理时间" width="180" />
          <el-table-column label="操作" width="120" fixed="right">
            <template #default="scope">
              <el-button type="primary" size="small" @click="viewAppealDetail(scope.row)">
                查看详情
              </el-button>
            </template>
          </el-table-column>
        </el-table>

        <!-- 分页 -->
        <div class="pagination" v-if="appealRecords.length > 0">
          <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :page-sizes="[10, 20, 50, 100]"
            layout="total, sizes, prev, pager, next, jumper"
            :total="totalRecords"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
          />
        </div>

        <!-- 无数据提示 -->
        <div v-else-if="!loadingRecords" class="no-data">
          <el-empty description="暂无申诉记录"></el-empty>
        </div>
      </el-card>
    </div>

    <el-dialog
        v-model="showAppealDetail"
        :title="(selectedAppeal?.semesterName || '') + ' - ' + (selectedAppeal?.itemName || '') + ' 申诉详情'"
        width="60%"
        :before-close="handleCloseDetail"
    >
      <div v-if="selectedAppeal" class="appeal-detail">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="测评学期">{{ selectedAppeal.semesterName }}</el-descriptions-item>
          <el-descriptions-item label="申诉项目">{{ selectedAppeal.itemName }}</el-descriptions-item>
          <el-descriptions-item label="原得分">{{ selectedAppeal.originalScore }}</el-descriptions-item>
          <el-descriptions-item label="期望得分">{{ selectedAppeal.expectedScore }}</el-descriptions-item>
          <el-descriptions-item label="申诉理由">{{ selectedAppeal.appealReason }}</el-descriptions-item>
          <el-descriptions-item label="处理结果">
            <el-tag :type="getStatusTagType(selectedAppeal.status)">
              {{ getStatusText(selectedAppeal.status) }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="处理意见" v-if="selectedAppeal.processOpinion">
            {{ selectedAppeal.processOpinion }}
          </el-descriptions-item>
          <el-descriptions-item label="提交时间">{{ selectedAppeal.submitTime }}</el-descriptions-item>
          <el-descriptions-item label="处理时间" v-if="selectedAppeal.processTime">{{ selectedAppeal.processTime }}</el-descriptions-item>
        </el-descriptions>

        <!-- 证明材料列表 -->
        <div v-if="selectedAppeal.attachments && selectedAppeal.attachments.length > 0" class="attachments">
          <h4>证明材料：</h4>
          <ul>
            <li v-for="(attachment, index) in selectedAppeal.attachments" :key="index" class="attachment-item">
              <el-link :href="attachment.url" target="_blank" type="primary" @click.prevent="downloadAttachment(attachment)">
                <el-icon><Document /></el-icon>
                {{ attachment.name }}
              </el-link>
              <span class="file-size">({{ formatFileSize(attachment.size) }})</span>
            </li>
          </ul>
        </div>
      </div>

      <template #footer>
    <span class="dialog-footer">
      <el-button @click="handleCloseDetail">关闭</el-button>
    </span>
      </template>
    </el-dialog>

  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, nextTick } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Document } from '@element-plus/icons-vue'
import { useUserStore } from '../../store/index.js'
import { submitScoreAppeal, getAppealRecords, getAppealDetail, getEvaluationItems } from '../../api/evaluation.js'

const userStore = useUserStore()

// 表单引用
const appealFormRef = ref(null)

// 加载状态
const submitting = ref(false)
const loadingRecords = ref(false)

// 学期数据
const availableSemesters = ref([
  { id: '2023-2024-2', name: '2023-2024学年第二学期' },
  { id: '2023-2024-1', name: '2023-2024学年第一学期' },
  { id: '2022-2023-2', name: '2022-2023学年第二学期' }
])

// 可选测评项目
const availableEvaluationItems = ref([])

// 申诉表单数据
const appealForm = reactive({
  semesterId: '2023-2024-2',
  evaluationItemId: '',
  expectedScore: '',
  appealReason: '',
  contactInfo: '',
  attachments: []
})

// 当前得分显示
const currentScore = ref('')

// 文件上传相关
const fileList = ref([])

// 表单验证规则
const appealRules = {
  semesterId: [
    { required: true, message: '请选择测评学期', trigger: 'change' }
  ],
  evaluationItemId: [
    { required: true, message: '请选择申诉项目', trigger: 'change' }
  ],
  expectedScore: [
    { required: true, message: '请输入期望得分', trigger: 'blur' },
    { type: 'number', min: 0, max: 100, message: '得分必须在0-100之间', trigger: 'blur' }
  ],
  appealReason: [
    { required: true, message: '请填写申诉理由', trigger: 'blur' },
    { min: 10, max: 1000, message: '申诉理由长度在10-1000个字符之间', trigger: 'blur' }
  ],
  contactInfo: [
    { required: true, message: '请填写联系方式', trigger: 'blur' }
  ]
}

// 申诉记录数据
const appealRecords = ref([])
const totalRecords = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)

// 申诉详情弹窗
const showAppealDetail = ref(false)
const selectedAppeal = ref({})

// 获取状态文本
const getStatusText = (status) => {
  const statusMap = {
    pending: '待处理',
    processing: '处理中',
    approved: '已通过',
    rejected: '已驳回'
  }
  return statusMap[status] || status
}

// 获取状态标签类型
const getStatusTagType = (status) => {
  const typeMap = {
    pending: 'warning',
    processing: 'primary',
    approved: 'success',
    rejected: 'danger'
  }
  return typeMap[status] || 'default'
}

// 格式化文件大小
const formatFileSize = (bytes) => {
  if (bytes === 0) return '0 Bytes'
  const k = 1024
  const sizes = ['Bytes', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
}

// 获取测评项目
const fetchEvaluationItems = async (semesterId) => {
  try {
    // 实际项目中应该调用API
    // const response = await getEvaluationItems(semesterId)
    // availableEvaluationItems.value = response.data
    
    // 使用模拟数据
    loadMockEvaluationItems(semesterId)
  } catch (error) {
    ElMessage.error('获取测评项目失败')
    console.error('获取测评项目失败:', error)
  }
}

// 加载模拟测评项目数据
const loadMockEvaluationItems = (semesterId) => {
  availableEvaluationItems.value = [
    { id: 'm1', category: '思想道德', name: '思想道德表现', score: 92 },
    { id: 'm2', category: '思想道德', name: '政治学习', score: 88 },
    { id: 'm3', category: '思想道德', name: '志愿服务', score: 85 },
    { id: 'a1', category: '学业成绩', name: '课程平均分', score: 87 },
    { id: 'a2', category: '学业成绩', name: '科研项目参与', score: 80 },
    { id: 'a3', category: '学业成绩', name: '学术竞赛获奖', score: 75 },
    { id: 's1', category: '社会实践', name: '社会实践活动', score: 70 },
    { id: 's2', category: '社会实践', name: '学生干部任职', score: 82 },
    { id: 's3', category: '社会实践', name: '文体活动参与', score: 78 }
  ]
}

// 处理学期变更
const handleSemesterChange = (semesterId) => {
  // 重置项目选择
  appealForm.evaluationItemId = ''
  currentScore.value = ''
  // 获取该学期的测评项目
  fetchEvaluationItems(semesterId)
}

// 处理项目变更，更新当前得分
const watchEvaluationItem = (itemId) => {
  const selectedItem = availableEvaluationItems.value.find(item => item.id === itemId)
  if (selectedItem) {
    currentScore.value = selectedItem.score
  }
}

// 文件上传前检查
const beforeUpload = (file) => {
  const isJPG = file.type === 'image/jpeg' || file.type === 'image/png'
  const isPDF = file.type === 'application/pdf'
  const isWord = file.type === 'application/msword' || file.type === 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  const isLt10M = file.size / 1024 / 1024 < 10
  const isAllowedType = isJPG || isPDF || isWord

  if (!isAllowedType) {
    ElMessage.error('只能上传jpg/png/pdf/doc/docx格式的文件!')
    return false
  }
  if (!isLt10M) {
    ElMessage.error('上传文件大小不能超过10MB!')
    return false
  }

  // 检查文件数量限制
  if (fileList.value.length >= 5) {
    ElMessage.error('最多只能上传5个文件!')
    return false
  }

  return true
}

// 处理文件变更
const handleFileChange = (file, files) => {
  fileList.value = files
}

// 处理文件删除
const handleRemove = (file, files) => {
  fileList.value = files
}

// 提交申诉
const submitAppeal = async () => {
  try {
    // 验证表单
    await appealFormRef.value.validate()

    submitting.value = true

    // 构建申诉数据
    const appealData = {
      semesterId: appealForm.semesterId,
      evaluationItemId: appealForm.evaluationItemId,
      originalScore: currentScore.value,
      expectedScore: appealForm.expectedScore,
      appealReason: appealForm.appealReason,
      contactInfo: appealForm.contactInfo,
      // 实际项目中应该上传文件并获取文件ID
      // attachments: fileList.value.map(file => file.id)
    }

    // 实际项目中应该调用API
    // const response = await submitScoreAppeal(appealData)
    
    // 模拟提交成功
    setTimeout(() => {
      ElMessage.success('申诉提交成功！')
      resetForm()
      // 刷新申诉记录
      fetchAppealRecords()
    }, 1000)
  } catch (error) {
    if (error.name === 'Error') {
      ElMessage.error('申诉提交失败，请重试')
    }
    console.error('申诉提交失败:', error)
  } finally {
    submitting.value = false
  }
}

// 重置表单
const resetForm = () => {
  appealFormRef.value.resetFields()
  fileList.value = []
  currentScore.value = ''
}

// 获取申诉记录
const fetchAppealRecords = async () => {
  try {
    loadingRecords.value = true
    // 实际项目中应该调用API
    // const response = await getAppealRecords({ page: currentPage.value, pageSize: pageSize.value })
    // appealRecords.value = response.data.items
    // totalRecords.value = response.data.total
    
    // 使用模拟数据
    loadMockAppealRecords()
  } catch (error) {
    ElMessage.error('获取申诉记录失败')
    console.error('获取申诉记录失败:', error)
  } finally {
    loadingRecords.value = false
  }
}

// 加载模拟申诉记录数据
const loadMockAppealRecords = () => {
  appealRecords.value = [
    {
      id: 1,
      semesterId: '2023-2024-1',
      semesterName: '2023-2024学年第一学期',
      itemId: 'a1',
      itemName: '学业成绩 - 课程平均分',
      originalScore: 85,
      expectedScore: 88,
      appealReason: '我认为我的课程平均分计算有误，根据成绩单，我的平均分应为88分。',
      status: 'approved',
      processOpinion: '经审核，确实存在计算误差，已调整分数。',
      submitTime: '2024-03-16 14:30:00',
      processTime: '2024-03-18 10:15:00',
      attachments: [
        {
          name: '课程成绩单.pdf',
          url: '#',
          size: 1250000
        }
      ]
    },
    {
      id: 2,
      semesterId: '2022-2023-2',
      semesterName: '2022-2023学年第二学期',
      itemId: 's1',
      itemName: '社会实践 - 社会实践活动',
      originalScore: 65,
      expectedScore: 80,
      appealReason: '我参加了暑期三下乡社会实践活动，但系统中没有记录。',
      status: 'rejected',
      processOpinion: '经审核，您提交的社会实践活动不在本学期认定范围内。',
      submitTime: '2023-09-22 09:45:00',
      processTime: '2023-09-25 16:30:00',
      attachments: []
    },
    {
      id: 3,
      semesterId: '2023-2024-2',
      semesterName: '2023-2024学年第二学期',
      itemId: 'a3',
      itemName: '学业成绩 - 学术竞赛获奖',
      originalScore: 70,
      expectedScore: 85,
      appealReason: '我在省级数学建模竞赛中获得了二等奖，应该获得更高的加分。',
      status: 'pending',
      processOpinion: '',
      submitTime: '2024-06-05 11:20:00',
      processTime: '',
      attachments: [
        {
          name: '获奖证书.pdf',
          url: '#',
          size: 2800000
        }
      ]
    }
  ]
  totalRecords.value = appealRecords.value.length
}

// 查看申诉详情
const viewAppealDetail = async (record) => {
  try {
    // 实际项目中应该调用API
    // const response = await getAppealDetail(record.id)
    // selectedAppeal.value = response.data
    
    // 使用模拟数据
    selectedAppeal.value = { ...record }
    showAppealDetail.value = true
  } catch (error) {
    ElMessage.error('查看申诉详情失败')
    console.error('查看申诉详情失败:', error)
  }
}

// 关闭详情弹窗
const handleCloseDetail = () => {
  showAppealDetail.value = false
  selectedAppeal.value = {}
}

// 下载附件
const downloadAttachment = (attachment) => {
  // 实际项目中应该有真实的下载逻辑
  ElMessage.success(`开始下载：${attachment.name}`)
}

// 分页处理
const handleSizeChange = (size) => {
  pageSize.value = size
  currentPage.value = 1
  fetchAppealRecords()
}

const handleCurrentChange = (current) => {
  currentPage.value = current
  fetchAppealRecords()
}

// 监听项目选择变化
import { watch } from 'vue'
watch(() => appealForm.evaluationItemId, (newValue) => {
  if (newValue) {
    watchEvaluationItem(newValue)
  }
})

// 组件挂载时初始化数据
onMounted(() => {
  // 获取当前学期的测评项目
  fetchEvaluationItems(appealForm.semesterId)
  // 获取申诉记录
  fetchAppealRecords()
})
</script>

<style scoped>
.appeal-submission-container {
  padding: 20px;
  background-color: #f5f7fa;
}

.page-header {
  margin-bottom: 20px;
}

.page-header h1 {
  font-size: 24px;
  font-weight: 600;
  color: #303133;
  margin: 0;
}

.page-header p {
  font-size: 14px;
  color: #909399;
  margin: 5px 0 0 0;
}

.notice-card {
  margin-bottom: 20px;
}

.notice-content ol {
  margin: 0;
  padding-left: 20px;
}

.notice-content li {
  margin: 5px 0;
  color: #606266;
  line-height: 1.6;
}

.appeal-form-section {
  margin-bottom: 20px;
}

.appeal-form {
  margin-top: 20px;
}

.appeal-records-section {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header span {
  font-weight: 500;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.no-data {
  padding: 40px 0;
  text-align: center;
}

.appeal-detail {
  padding: 20px 0;
}

.attachments {
  margin-top: 20px;
}

.attachments h4 {
  margin: 0 0 10px 0;
  color: #303133;
}

.attachment-item {
  padding: 5px 0;
}

.file-size {
  margin-left: 10px;
  color: #909399;
  font-size: 12px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
}

@media (max-width: 768px) {
  .appeal-submission-container {
    padding: 10px;
  }
  
  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
  
  .pagination {
    justify-content: center;
  }
}
</style>