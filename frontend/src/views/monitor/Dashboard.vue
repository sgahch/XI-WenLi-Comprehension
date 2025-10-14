<template>
  <div class="monitor-dashboard">
    <!-- 欢迎头部 -->
    <div class="welcome-header">
      <div class="welcome-content">
        <div class="avatar-section">
          <el-avatar :size="60" :src="userInfo.avatar" class="user-avatar">
            <el-icon><User /></el-icon>
          </el-avatar>
          <div class="user-info">
            <h2>{{ userInfo.userName }}</h2>
            <p class="role-tag">班委 · {{ userInfo.collegeName }}</p>
            <p class="last-login">上次登录：{{ formatTime(userInfo.lastLoginTime) }}</p>
          </div>
        </div>
        <div class="quick-actions">
          <el-button type="primary" @click="showAuditDialog = true">
            <el-icon><DocumentChecked /></el-icon>
            批量审核
          </el-button>
          <el-button type="success" @click="remindStudents">
            <el-icon><Bell /></el-icon>
            提醒学生
          </el-button>
        </div>
      </div>
    </div>

    <!-- 统计卡片 -->
    <div class="stats-grid">
      <div class="stat-card pending">
        <div class="stat-icon">
          <el-icon><Clock /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-number" :data-target="stats.pendingCount">{{ animatedPending }}</div>
          <div class="stat-label">待审核材料</div>
          <div class="stat-trend">
            <span class="trend-text">较昨日 +{{ stats.pendingIncrease }}</span>
          </div>
        </div>
      </div>

      <div class="stat-card approved">
        <div class="stat-icon">
          <el-icon><CircleCheck /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-number" :data-target="stats.approvedCount">{{ animatedApproved }}</div>
          <div class="stat-label">已审核通过</div>
          <div class="stat-trend">
            <span class="trend-text">通过率 {{ stats.approvalRate }}%</span>
          </div>
        </div>
      </div>

      <div class="stat-card rejected">
        <div class="stat-icon">
          <el-icon><CircleClose /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-number" :data-target="stats.rejectedCount">{{ animatedRejected }}</div>
          <div class="stat-label">审核拒绝</div>
          <div class="stat-trend">
            <span class="trend-text">拒绝率 {{ stats.rejectionRate }}%</span>
          </div>
        </div>
      </div>

      <div class="stat-card students">
        <div class="stat-icon">
          <el-icon><User /></el-icon>
        </div>
        <div class="stat-content">
          <div class="stat-number" :data-target="stats.totalStudents">{{ animatedStudents }}</div>
          <div class="stat-label">班级学生</div>
          <div class="stat-trend">
            <span class="trend-text">提交率 {{ stats.submitRate }}%</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 主要内容区域 -->
    <div class="main-content">
      <!-- 待审核材料列表 -->
      <div class="content-card">
        <div class="card-header">
          <h3>
            <el-icon><DocumentChecked /></el-icon>
            待审核材料
          </h3>
          <div class="header-actions">
            <el-button size="small" @click="refreshPendingList">
              <el-icon><Refresh /></el-icon>
              刷新
            </el-button>
          </div>
        </div>
        <div class="card-content">
          <el-table :data="pendingMaterials" style="width: 100%" v-loading="loading">
            <el-table-column prop="studentName" label="学生姓名" width="120" />
            <el-table-column prop="reason" label="加分事由" min-width="200" />
            <el-table-column prop="materialType" label="材料类型" width="100">
              <template #default="scope">
                <el-tag :type="scope.row.materialType === 'PDF' ? 'primary' : 'success'">
                  {{ scope.row.materialType }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="submitTime" label="提交时间" width="180">
              <template #default="scope">
                {{ formatTime(scope.row.submitTime) }}
              </template>
            </el-table-column>
            <el-table-column label="操作" width="200">
              <template #default="scope">
                <el-button size="small" type="primary" @click="viewMaterial(scope.row)">
                  查看
                </el-button>
                <el-button size="small" type="success" @click="auditMaterial(scope.row, 'PASS')">
                  通过
                </el-button>
                <el-button size="small" type="danger" @click="auditMaterial(scope.row, 'REJECT')">
                  拒绝
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>

      <!-- 审核进度统计 -->
      <div class="content-card">
        <div class="card-header">
          <h3>
            <el-icon><TrendCharts /></el-icon>
            审核进度统计
          </h3>
        </div>
        <div class="card-content">
          <div id="auditProgressChart" style="height: 300px;"></div>
        </div>
      </div>
    </div>

    <!-- 批量审核对话框 -->
    <el-dialog v-model="showAuditDialog" title="批量审核" width="600px">
      <el-form :model="batchAuditForm" label-width="100px">
        <el-form-item label="审核结果">
          <el-radio-group v-model="batchAuditForm.result">
            <el-radio label="PASS">通过</el-radio>
            <el-radio label="REJECT">拒绝</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="审核意见">
          <el-input
            v-model="batchAuditForm.opinion"
            type="textarea"
            :rows="3"
            placeholder="请输入审核意见"
          />
        </el-form-item>
        <el-form-item label="选择材料">
          <el-checkbox-group v-model="batchAuditForm.materialIds">
            <el-checkbox
              v-for="material in pendingMaterials"
              :key="material.recordId"
              :label="material.recordId"
            >
              {{ material.studentName }} - {{ material.reason }}
            </el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showAuditDialog = false">取消</el-button>
        <el-button type="primary" @click="submitBatchAudit">确认审核</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { monitorAPI } from '@/api'
import * as echarts from 'echarts'

// 响应式数据
const userInfo = ref({
  userName: '张班委',
  collegeName: '计算机学院',
  avatar: '',
  lastLoginTime: new Date()
})

const stats = ref({
  pendingCount: 0,
  approvedCount: 0,
  rejectedCount: 0,
  totalStudents: 0,
  pendingIncrease: 0,
  approvalRate: 0,
  rejectionRate: 0,
  submitRate: 0
})

const pendingMaterials = ref([])
const loading = ref(false)
const showAuditDialog = ref(false)

const batchAuditForm = reactive({
  result: 'PASS',
  opinion: '',
  materialIds: []
})

// 数字动画
const animatedPending = ref(0)
const animatedApproved = ref(0)
const animatedRejected = ref(0)
const animatedStudents = ref(0)

// 计算属性和方法
const formatTime = (time) => {
  return new Date(time).toLocaleString()
}

// 数字动画函数
const animateNumber = (target, current, setter) => {
  const increment = Math.ceil(target / 30)
  const timer = setInterval(() => {
    current.value += increment
    if (current.value >= target) {
      current.value = target
      clearInterval(timer)
    }
    setter(current.value)
  }, 50)
}

// 页面方法
const refreshPendingList = async () => {
  loading.value = true
  try {
    const response = await monitorAPI.getPendingMaterials('COLLEGE_CS')
    pendingMaterials.value = response.data
  } catch (error) {
    ElMessage.error('获取待审核材料失败')
  } finally {
    loading.value = false
  }
}

const viewMaterial = (material) => {
  // 查看材料详情
  console.log('查看材料:', material)
}

const auditMaterial = async (material, result) => {
  try {
    const { value: opinion } = await ElMessageBox.prompt(
      `确认${result === 'PASS' ? '通过' : '拒绝'}该材料？`,
      '审核确认',
      {
        inputPlaceholder: '请输入审核意见',
        inputType: 'textarea'
      }
    )

    await monitorAPI.auditMaterial(material.recordId, {
      auditResult: result,
      opinion: opinion,
      auditorId: 'MON001'
    })

    ElMessage.success('审核完成')
    refreshPendingList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('审核失败')
    }
  }
}

const submitBatchAudit = async () => {
  if (batchAuditForm.materialIds.length === 0) {
    ElMessage.warning('请选择要审核的材料')
    return
  }

  try {
    await monitorAPI.batchAudit({
      materialIds: batchAuditForm.materialIds,
      result: batchAuditForm.result,
      opinion: batchAuditForm.opinion,
      auditorId: 'MON001'
    })

    ElMessage.success('批量审核完成')
    showAuditDialog.value = false
    refreshPendingList()
  } catch (error) {
    ElMessage.error('批量审核失败')
  }
}

const remindStudents = () => {
  ElMessage.info('提醒功能开发中...')
}

// 初始化图表
const initChart = () => {
  const chartDom = document.getElementById('auditProgressChart')
  const myChart = echarts.init(chartDom)
  
  const option = {
    title: {
      text: '本周审核进度',
      left: 'center'
    },
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: ['待审核', '已通过', '已拒绝'],
      bottom: 0
    },
    xAxis: {
      type: 'category',
      data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '待审核',
        type: 'line',
        data: [12, 8, 15, 10, 6, 4, 2]
      },
      {
        name: '已通过',
        type: 'line',
        data: [5, 10, 8, 12, 15, 18, 20]
      },
      {
        name: '已拒绝',
        type: 'line',
        data: [2, 1, 3, 2, 1, 2, 1]
      }
    ]
  }
  
  myChart.setOption(option)
}

// 生命周期
onMounted(async () => {
  // 加载数据
  await refreshPendingList()
  
  // 模拟统计数据
  stats.value = {
    pendingCount: 15,
    approvedCount: 128,
    rejectedCount: 8,
    totalStudents: 45,
    pendingIncrease: 3,
    approvalRate: 94.1,
    rejectionRate: 5.9,
    submitRate: 88.9
  }
  
  // 启动数字动画
  setTimeout(() => {
    animateNumber(stats.value.pendingCount, animatedPending, (val) => animatedPending.value = val)
    animateNumber(stats.value.approvedCount, animatedApproved, (val) => animatedApproved.value = val)
    animateNumber(stats.value.rejectedCount, animatedRejected, (val) => animatedRejected.value = val)
    animateNumber(stats.value.totalStudents, animatedStudents, (val) => animatedStudents.value = val)
  }, 500)
  
  // 初始化图表
  setTimeout(initChart, 1000)
})
</script>

<style scoped>
.monitor-dashboard {
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}

.welcome-header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.welcome-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatar-section {
  display: flex;
  align-items: center;
  gap: 16px;
}

.user-avatar {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.user-info h2 {
  margin: 0 0 4px 0;
  color: #2c3e50;
  font-size: 24px;
  font-weight: 600;
}

.role-tag {
  color: #7c3aed;
  font-weight: 500;
  margin: 0 0 4px 0;
}

.last-login {
  color: #64748b;
  font-size: 14px;
  margin: 0;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
  margin-bottom: 24px;
}

.stat-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.stat-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  color: white;
}

.stat-card.pending .stat-icon {
  background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
}

.stat-card.approved .stat-icon {
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
}

.stat-card.rejected .stat-icon {
  background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
}

.stat-card.students .stat-icon {
  background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
}

.stat-number {
  font-size: 32px;
  font-weight: 700;
  color: #1e293b;
  margin-bottom: 4px;
}

.stat-label {
  color: #64748b;
  font-size: 14px;
  margin-bottom: 8px;
}

.trend-text {
  font-size: 12px;
  color: #10b981;
  font-weight: 500;
}

.main-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
}

.content-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.card-header {
  padding: 20px 24px;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-header h3 {
  margin: 0;
  color: #1e293b;
  font-size: 18px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 8px;
}

.card-content {
  padding: 24px;
}

@media (max-width: 768px) {
  .main-content {
    grid-template-columns: 1fr;
  }
  
  .welcome-content {
    flex-direction: column;
    gap: 16px;
    text-align: center;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
  }
}
</style>
