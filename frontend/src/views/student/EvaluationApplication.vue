<template>
  <div class="evaluation-application">
    <!-- 测评学期选择 -->
    <div class="semester-selector">
      <el-select v-model="selectedSemester" placeholder="请选择测评学期" style="width: 200px;">
        <el-option v-for="semester in availableSemesters" :key="semester.value" :label="semester.label" :value="semester.value"></el-option>
      </el-select>
      <el-tag type="info" class="semester-status" v-if="currentSemesterStatus">
        {{ currentSemesterStatus }}
      </el-tag>
      <el-button 
        type="primary" 
        class="create-application-btn" 
        @click="createNewApplication"
        :disabled="!canCreateApplication"
      >
        创建新申请
      </el-button>
    </div>
    
    <!-- 申请列表 -->
    <el-card class="application-list-card">
      <template #header>
        <div class="card-header">
          <span>测评申请列表</span>
          <el-input v-model="searchKeyword" placeholder="搜索申请" prefix-icon="Search" style="width: 200px;"></el-input>
        </div>
      </template>
      
      <el-table 
        :data="filteredApplications" 
        style="width: 100%" 
        border 
        v-loading="loadingApplications"
        element-loading-text="加载中..."
      >
        <el-table-column prop="id" label="申请ID" width="80px"></el-table-column>
        <el-table-column prop="semester" label="测评学期" width="150px"></el-table-column>
        <el-table-column prop="submitTime" label="提交时间" width="180px"></el-table-column>
        <el-table-column prop="status" label="状态" width="100px">
          <template #default="{ row }">
            <el-tag :type="getStatusTagType(row.status)">{{ getStatusText(row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="score" label="得分" width="80px"></el-table-column>
        <el-table-column prop="reviewer" label="审核人" width="120px"></el-table-column>
        <el-table-column label="操作" width="200px" fixed="right">
          <template #default="{ row }">
            <el-button 
              type="primary" 
              size="small" 
              @click="viewApplicationDetail(row.id)"
              v-if="canViewApplication(row)"
            >
              查看
            </el-button>
            <el-button 
              size="small" 
              @click="editApplication(row.id)"
              v-if="canEditApplication(row)"
            >
              编辑
            </el-button>
            <el-button 
              type="danger" 
              size="small" 
              @click="deleteApplication(row.id)"
              v-if="canDeleteApplication(row)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页 -->
      <div class="pagination" v-if="applications.length > 0">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="applications.length"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
      
      <!-- 无数据提示 -->
      <div v-else-if="!loadingApplications" class="no-data">
        暂无测评申请记录
      </div>
    </el-card>
    
    <!-- 测评项目填报弹窗 -->
    <el-dialog
      v-model="showApplicationForm"
      title="测评项目填报"
      width="800px"
      :before-close="handleDialogClose"
    >
      <el-form 
        ref="applicationForm" 
        :model="currentApplication" 
        :rules="applicationRules"
        label-width="120px"
        class="application-form"
      >
        <!-- 基本信息 -->
        <el-divider>基本信息</el-divider>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="测评学期" prop="semester">
              <el-input v-model="currentApplication.semester" disabled></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="申请人" prop="applicantName">
              <el-input v-model="currentApplication.applicantName" disabled></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        
        <!-- 测评项目 -->
        <el-divider>测评项目</el-divider>
        <div class="evaluation-items">
          <el-collapse v-model="activeTab">
            <!-- 思想道德 -->
            <el-collapse-item title="思想道德" name="1">
              <div class="item-content">
                <el-table 
                  :data="currentApplication.moralItems" 
                  style="width: 100%"
                  border
                >
                  <el-table-column prop="name" label="项目名称" width="200px"></el-table-column>
                  <el-table-column prop="description" label="项目描述"></el-table-column>
                  <el-table-column prop="score" label="得分" width="80px">
                    <template #default="{ row }">
                      <el-input-number 
                        v-model="row.score" 
                        :min="0" 
                        :max="row.maxScore"
                        :precision="1"
                        :disabled="!isEditingApplication"
                      ></el-input-number>
                    </template>
                  </el-table-column>
                  <el-table-column prop="maxScore" label="满分" width="80px"></el-table-column>
                  <el-table-column label="证明材料" width="120px">
                    <template #default="{ row }">
                      <el-button 
                        type="text" 
                        size="small" 
                        @click="uploadProofFile(row.id)"
                        v-if="isEditingApplication"
                      >
                        上传
                      </el-button>
                      <el-button 
                        type="text" 
                        size="small" 
                        @click="downloadProofFile(row.proofFileId)"
                        v-else-if="row.proofFileId"
                      >
                        查看
                      </el-button>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </el-collapse-item>
            
            <!-- 学业成绩 -->
            <el-collapse-item title="学业成绩" name="2">
              <div class="item-content">
                <el-table 
                  :data="currentApplication.academicItems" 
                  style="width: 100%"
                  border
                >
                  <el-table-column prop="name" label="项目名称" width="200px"></el-table-column>
                  <el-table-column prop="description" label="项目描述"></el-table-column>
                  <el-table-column prop="score" label="得分" width="80px">
                    <template #default="{ row }">
                      <el-input-number 
                        v-model="row.score" 
                        :min="0" 
                        :max="row.maxScore"
                        :precision="1"
                        :disabled="!isEditingApplication"
                      ></el-input-number>
                    </template>
                  </el-table-column>
                  <el-table-column prop="maxScore" label="满分" width="80px"></el-table-column>
                </el-table>
              </div>
            </el-collapse-item>
            
            <!-- 社会实践 -->
            <el-collapse-item title="社会实践" name="3">
              <div class="item-content">
                <el-table 
                  :data="currentApplication.socialItems" 
                  style="width: 100%"
                  border
                >
                  <el-table-column prop="name" label="项目名称" width="200px"></el-table-column>
                  <el-table-column prop="description" label="项目描述"></el-table-column>
                  <el-table-column prop="score" label="得分" width="80px">
                    <template #default="{ row }">
                      <el-input-number 
                        v-model="row.score" 
                        :min="0" 
                        :max="row.maxScore"
                        :precision="1"
                        :disabled="!isEditingApplication"
                      ></el-input-number>
                    </template>
                  </el-table-column>
                  <el-table-column prop="maxScore" label="满分" width="80px"></el-table-column>
                  <el-table-column label="证明材料" width="120px">
                    <template #default="{ row }">
                      <el-button 
                        type="text" 
                        size="small" 
                        @click="uploadProofFile(row.id)"
                        v-if="isEditingApplication"
                      >
                        上传
                      </el-button>
                      <el-button 
                        type="text" 
                        size="small" 
                        @click="downloadProofFile(row.proofFileId)"
                        v-else-if="row.proofFileId"
                      >
                        查看
                      </el-button>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </el-collapse-item>
          </el-collapse>
        </div>
        
        <!-- 备注信息 -->
        <el-divider>备注信息</el-divider>
        <el-form-item label="备注" prop="remark">
          <el-input 
            v-model="currentApplication.remark" 
            type="textarea" 
            placeholder="请输入备注信息" 
            :rows="4"
            :disabled="!isEditingApplication"
          ></el-input>
        </el-form-item>
      </el-form>
      
      <!-- 弹窗底部按钮 -->
      <template #footer>
        <span class="dialog-footer" v-if="isEditingApplication">
          <el-button @click="handleDialogClose">取消</el-button>
          <el-button type="primary" @click="submitApplication">提交</el-button>
        </span>
        <span class="dialog-footer" v-else>
          <el-button @click="handleDialogClose">关闭</el-button>
        </span>
      </template>
    </el-dialog>
    
    <!-- 文件上传输入框 -->
    <input ref="fileInput" type="file" style="display: none" @change="handleFileUpload">
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, nextTick } from 'vue'
import { useUserStore } from '../../store'
import { ElMessage, ElMessageBox } from 'element-plus'
import { evaluationAPI, userAPI } from '../../api'
import { Search } from '@element-plus/icons-vue'

const userStore = useUserStore()

// 可用学期列表
const availableSemesters = ref([
  { label: '2024-2025春季学期', value: '2024-spring' },
  { label: '2023-2024秋季学期', value: '2023-autumn' },
  { label: '2023-2024春季学期', value: '2023-spring' },
  { label: '2022-2023秋季学期', value: '2022-autumn' }
])

// 选中的学期
const selectedSemester = ref('2024-spring')

// 当前学期状态
const currentSemesterStatus = computed(() => {
  // 这里应该根据后端返回的状态显示
  return '填报中'
})

// 能否创建新申请
const canCreateApplication = computed(() => {
  // 这里应该根据后端返回的权限和状态判断
  return true
})

// 搜索关键词
const searchKeyword = ref('')

// 申请列表
const applications = ref([])

// 过滤后的申请列表
const filteredApplications = computed(() => {
  if (!searchKeyword.value) {
    return applications.value
  }
  return applications.value.filter(item => 
    item.id.toString().includes(searchKeyword.value) ||
    item.semester.includes(searchKeyword.value) ||
    item.applicantName.includes(searchKeyword.value) ||
    getStatusText(item.status).includes(searchKeyword.value)
  )
})

// 加载状态
const loadingApplications = ref(false)

// 分页参数
const currentPage = ref(1)
const pageSize = ref(10)

// 弹窗相关
const showApplicationForm = ref(false)
const isEditingApplication = ref(false)
const currentApplication = reactive({
  id: '',
  semester: '',
  applicantName: '',
  status: '',
  score: 0,
  submitTime: '',
  remark: '',
  moralItems: [],
  academicItems: [],
  socialItems: []
})

// 折叠面板激活项
const activeTab = ref(['1'])

// 表单验证规则
const applicationRules = {
  semester: [
    { required: true, message: '请选择测评学期', trigger: 'change' }
  ]
}

// 表单引用
const applicationForm = ref(null)
const fileInput = ref(null)

// 当前上传文件的项目ID
const currentUploadItemId = ref('')

// 获取状态文本
const getStatusText = (status) => {
  const statusMap = {
    draft: '草稿',
    submitted: '已提交',
    reviewed: '已审核',
    approved: '已通过',
    rejected: '已驳回'
  }
  return statusMap[status] || status
}

// 获取状态标签类型
const getStatusTagType = (status) => {
  const typeMap = {
    draft: 'warning',
    submitted: 'info',
    reviewed: 'primary',
    approved: 'success',
    rejected: 'danger'
  }
  return typeMap[status] || 'default'
}

// 判断是否可以查看申请
const canViewApplication = (row) => {
  return true
}

// 判断是否可以编辑申请
const canEditApplication = (row) => {
  return row.status === 'draft' || row.status === 'rejected'
}

// 判断是否可以删除申请
const canDeleteApplication = (row) => {
  return row.status === 'draft'
}

// 加载申请列表
const loadApplications = async () => {
  try {
    loadingApplications.value = true
    const res = await evaluationAPI.getMyEvaluations({
      params: {
        page: currentPage.value,
        pageSize: pageSize.value,
        semester: selectedSemester.value
      }
    })
    
    if (res.code === 200) {
      applications.value = res.data.list || []
    } else {
      ElMessage.error(res.message || '加载申请列表失败')
    }
  } catch (error) {
    ElMessage.error('加载申请列表失败，请重试')
  } finally {
    loadingApplications.value = false
  }
}

// 创建新申请
const createNewApplication = () => {
  // 重置当前申请数据
  Object.assign(currentApplication, {
    id: '',
    semester: selectedSemester.value,
    applicantName: userStore.getUserInfo?.name || '',
    status: 'draft',
    score: 0,
    submitTime: '',
    remark: '',
    moralItems: [
      { id: 'm1', name: '思想表现', description: '思想道德品质表现情况', score: 0, maxScore: 20, proofFileId: '' },
      { id: 'm2', name: '政治学习', description: '政治理论学习参与情况', score: 0, maxScore: 10, proofFileId: '' },
      { id: 'm3', name: '志愿服务', description: '参与志愿服务活动情况', score: 0, maxScore: 10, proofFileId: '' }
    ],
    academicItems: [
      { id: 'a1', name: '课程成绩', description: '学期课程成绩加权平均分', score: 0, maxScore: 40, proofFileId: '' },
      { id: 'a2', name: '科研项目', description: '参与科研项目情况', score: 0, maxScore: 10, proofFileId: '' },
      { id: 'a3', name: '学术竞赛', description: '参与学术竞赛获奖情况', score: 0, maxScore: 10, proofFileId: '' }
    ],
    socialItems: [
      { id: 's1', name: '社会实践', description: '参与社会实践活动情况', score: 0, maxScore: 15, proofFileId: '' },
      { id: 's2', name: '学生工作', description: '担任学生干部情况', score: 0, maxScore: 10, proofFileId: '' },
      { id: 's3', name: '文体活动', description: '参与文体活动情况', score: 0, maxScore: 10, proofFileId: '' }
    ]
  })
  
  isEditingApplication.value = true
  showApplicationForm.value = true
  activeTab.value = ['1']
}

// 查看申请详情
const viewApplicationDetail = async (id) => {
  try {
    const res = await evaluationAPI.getEvaluationItemDetail(id)
    if (res.code === 200) {
      Object.assign(currentApplication, res.data)
      isEditingApplication.value = false
      showApplicationForm.value = true
      activeTab.value = ['1']
    } else {
      ElMessage.error(res.message || '查看申请详情失败')
    }
  } catch (error) {
    ElMessage.error('查看申请详情失败，请重试')
  }
}

// 编辑申请
const editApplication = async (id) => {
  try {
    const res = await evaluationAPI.getEvaluationItemDetail(id)
    if (res.code === 200) {
      Object.assign(currentApplication, res.data)
      isEditingApplication.value = true
      showApplicationForm.value = true
      activeTab.value = ['1']
    } else {
      ElMessage.error(res.message || '加载申请详情失败')
    }
  } catch (error) {
    ElMessage.error('加载申请详情失败，请重试')
  }
}

// 删除申请
const deleteApplication = (id) => {
  ElMessageBox.confirm(
    '确定要删除此申请吗？删除后无法恢复。',
    '确认删除',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'danger'
    }
  ).then(async () => {
    try {
      const res = await evaluationAPI.deleteEvaluation(id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        // 重新加载申请列表
        loadApplications()
      } else {
        ElMessage.error(res.message || '删除失败')
      }
    } catch (error) {
      ElMessage.error('删除失败，请重试')
    }
  }).catch(() => {
    // 取消删除
  })
}

// 提交申请
const submitApplication = async () => {
  try {
    // 验证表单
    await applicationForm.value.validate()
    
    // 计算总分
    let totalScore = 0
    const allItems = [...currentApplication.moralItems, ...currentApplication.academicItems, ...currentApplication.socialItems]
    allItems.forEach(item => {
      totalScore += item.score || 0
    })
    currentApplication.score = totalScore
    
    // 提交申请
    const res = await evaluationAPI.submitEvaluation(currentApplication)
    
    if (res.code === 200) {
      ElMessage.success('提交成功')
      showApplicationForm.value = false
      // 重新加载申请列表
      loadApplications()
    } else {
      ElMessage.error(res.message || '提交失败')
    }
  } catch (error) {
    // 处理表单验证失败或其他错误
    if (error.name !== 'Error') {
      ElMessage.error('请检查输入信息是否正确')
    }
  }
}

// 处理弹窗关闭
const handleDialogClose = () => {
  // 如果正在编辑且有未保存的更改，可以弹出确认框
  showApplicationForm.value = false
}

// 上传证明材料
const uploadProofFile = (itemId) => {
  currentUploadItemId.value = itemId
  if (fileInput.value) {
    fileInput.value.click()
  }
}

// 处理文件上传
const handleFileUpload = async (event) => {
  const file = event.target.files[0]
  if (!file || !currentUploadItemId.value) return
  
  try {
    // 这里应该调用上传文件的API
    // 为了演示，我们模拟上传成功
    const allItems = [...currentApplication.moralItems, ...currentApplication.academicItems, ...currentApplication.socialItems]
    const item = allItems.find(i => i.id === currentUploadItemId.value)
    if (item) {
      item.proofFileId = `file-${Date.now()}`
      ElMessage.success('文件上传成功')
    }
    
    // 清空input值，以便可以重复选择同一个文件
    event.target.value = ''
  } catch (error) {
    ElMessage.error('文件上传失败，请重试')
  }
}

// 下载证明材料
const downloadProofFile = async (fileId) => {
  if (!fileId) return
  
  try {
    // 这里应该调用下载文件的API
    ElMessage.info('开始下载文件')
  } catch (error) {
    ElMessage.error('文件下载失败，请重试')
  }
}

// 分页处理
const handleSizeChange = (size) => {
  pageSize.value = size
  loadApplications()
}

const handleCurrentChange = (current) => {
  currentPage.value = current
  loadApplications()
}

// 页面挂载时加载申请列表
onMounted(() => {
  loadApplications()
})
</script>

<style scoped>
.evaluation-application {
  width: 100%;
}

/* 学期选择器 */
.semester-selector {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 20px;
}

.semester-status {
  margin-left: 8px;
}

.create-application-btn {
  margin-left: auto;
}

/* 卡片样式 */
.application-list-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 分页样式 */
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

/* 无数据提示 */
.no-data {
  text-align: center;
  color: #909399;
  padding: 40px 0;
}

/* 申请表单 */
.application-form {
  margin-top: 20px;
}

.evaluation-items {
  margin-top: 10px;
}

.item-content {
  padding: 10px 0;
}

/* 弹窗底部按钮 */
.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .semester-selector {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
  
  .create-application-btn {
    margin-left: 0;
    width: 100%;
  }
  
  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }
  
  .el-input {
    width: 100%;
  }
  
  .pagination {
    justify-content: center;
  }
}
</style>