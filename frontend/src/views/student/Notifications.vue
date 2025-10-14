<template>
  <div class="notifications">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>通知公告</h2>
      <p>查看系统发布的通知和公告信息</p>
    </div>
    
    <!-- 筛选和搜索 -->
    <div class="filter-section">
      <el-select v-model="notificationType" placeholder="请选择通知类型" style="width: 150px; margin-right: 10px;">
        <el-option label="全部类型" value=""></el-option>
        <el-option label="系统通知" value="system"></el-option>
        <el-option label="测评通知" value="evaluation"></el-option>
        <el-option label="成绩通知" value="score"></el-option>
        <el-option label="活动通知" value="activity"></el-option>
      </el-select>
      <el-select v-model="readStatus" placeholder="阅读状态" style="width: 120px; margin-right: 10px;">
        <el-option label="全部" value=""></el-option>
        <el-option label="未读" value="unread"></el-option>
        <el-option label="已读" value="read"></el-option>
      </el-select>
      <el-input v-model="searchKeyword" placeholder="搜索通知标题" prefix-icon="Search" style="width: 300px;"></el-input>
      <el-button type="primary" @click="fetchNotifications" style="margin-left: 10px;">搜索</el-button>
    </div>
    
    <!-- 通知列表 -->
    <el-card class="notifications-card">
      <template #header>
        <div class="card-header">
          <span>通知列表</span>
          <el-badge v-if="unreadCount > 0" :value="unreadCount" type="danger" class="unread-badge">
            <el-button type="text" @click="markAllAsRead">全部标记为已读</el-button>
          </el-badge>
        </div>
      </template>
      
      <el-table 
        :data="filteredNotifications" 
        style="width: 100%" 
        border 
        v-loading="loading"
        element-loading-text="加载中..."
      >
        <el-table-column type="index" label="序号" width="60px"></el-table-column>
        <el-table-column prop="title" label="标题" min-width="300px">
          <template #default="{ row }">
            <div class="notification-title" @click="viewNotificationDetail(row.id)">
              <span :class="{ 'unread-title': row.readStatus === 'unread' }">
                {{ row.title }}
              </span>
              <el-tag v-if="row.isTop" type="warning" size="small" style="margin-left: 10px;">置顶</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="type" label="类型" width="100px">
          <template #default="{ row }">
            <el-tag :type="getTypeTagType(row.type)">{{ getTypeText(row.type) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="publishTime" label="发布时间" width="180px"></el-table-column>
        <el-table-column prop="publisher" label="发布人" width="120px"></el-table-column>
        <el-table-column prop="readStatus" label="阅读状态" width="100px">
          <template #default="{ row }">
            <el-tag :type="getStatusTagType(row.readStatus)">{{ getStatusText(row.readStatus) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120px" fixed="right">
          <template #default="{ row }">
            <el-button 
              type="text" 
              size="small" 
              @click="viewNotificationDetail(row.id)"
            >
              查看
            </el-button>
            <el-button 
              type="text" 
              size="small" 
              @click="deleteNotification(row.id)"
              v-if="canDeleteNotification(row)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页 -->
      <div class="pagination" v-if="notifications.length > 0">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="notifications.length"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
      
      <!-- 无数据提示 -->
      <div v-else-if="!loading" class="no-data">
        暂无通知公告
      </div>
    </el-card>
    
    <!-- 通知详情弹窗 -->
    <el-dialog
      v-model="showNotificationDetail"
      :title="currentNotification.title || '通知详情'"
      width="800px"
      :before-close="handleDetailClose"
    >
      <div class="notification-detail" v-if="currentNotification">
        <div class="detail-header">
          <h3>{{ currentNotification.title }}</h3>
          <div class="detail-meta">
            <span class="meta-item">发布人: {{ currentNotification.publisher }}</span>
            <span class="meta-item">发布时间: {{ currentNotification.publishTime }}</span>
            <span class="meta-item">类型: {{ getTypeText(currentNotification.type) }}</span>
            <el-tag v-if="currentNotification.isTop" type="warning" size="small">置顶</el-tag>
          </div>
        </div>
        <el-divider />
        <div class="detail-content" v-html="currentNotification.content"></div>
        
        <!-- 附件列表 -->
        <div class="attachment-list" v-if="currentNotification.attachments && currentNotification.attachments.length > 0">
          <el-divider>附件</el-divider>
          <el-list>
            <el-list-item v-for="(attachment, index) in currentNotification.attachments" :key="index" class="attachment-item">
              <template #default>
                <div class="attachment-info" @click="downloadAttachment(attachment)">
                  <el-icon class="attachment-icon"><document /></el-icon>
                  <span class="attachment-name">{{ attachment.name }}</span>
                  <span class="attachment-size">({{ formatFileSize(attachment.size) }})</span>
                </div>
              </template>
            </el-list-item>
          </el-list>
        </div>
      </div>
      
      <!-- 弹窗底部按钮 -->
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="handleDetailClose">关闭</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useUserStore } from '../../store'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Document } from '@element-plus/icons-vue'
import { notificationAPI } from '../../api'

const userStore = useUserStore()

// 筛选条件
const notificationType = ref('')
const readStatus = ref('')
const searchKeyword = ref('')

// 加载状态
const loading = ref(false)

// 通知列表
const notifications = ref([])

// 未读通知数量
const unreadCount = computed(() => {
  return notifications.value.filter(item => item.readStatus === 'unread').length
})

// 过滤后的通知列表
const filteredNotifications = computed(() => {
  return notifications.value.filter(item => {
    const matchesType = !notificationType.value || item.type === notificationType.value
    const matchesStatus = !readStatus.value || item.readStatus === readStatus.value
    const matchesKeyword = !searchKeyword.value || item.title.includes(searchKeyword.value)
    return matchesType && matchesStatus && matchesKeyword
  })
})

// 分页参数
const currentPage = ref(1)
const pageSize = ref(10)

// 通知详情弹窗
const showNotificationDetail = ref(false)
const currentNotification = ref(null)

// 获取类型文本
const getTypeText = (type) => {
  const typeMap = {
    system: '系统通知',
    evaluation: '测评通知',
    score: '成绩通知',
    activity: '活动通知'
  }
  return typeMap[type] || type
}

// 获取类型标签类型
const getTypeTagType = (type) => {
  const typeMap = {
    system: 'primary',
    evaluation: 'success',
    score: 'warning',
    activity: 'info'
  }
  return typeMap[type] || 'default'
}

// 获取状态文本
const getStatusText = (status) => {
  const statusMap = {
    unread: '未读',
    read: '已读'
  }
  return statusMap[status] || status
}

// 获取状态标签类型
const getStatusTagType = (status) => {
  const typeMap = {
    unread: 'danger',
    read: 'success'
  }
  return typeMap[status] || 'default'
}

// 判断是否可以删除通知
const canDeleteNotification = (row) => {
  // 这里应该根据后端返回的权限判断
  return true
}

// 获取通知列表
const fetchNotifications = async () => {
  try {
    loading.value = true
    const res = await notificationAPI.getUserNotifications({
      params: {
        page: currentPage.value,
        pageSize: pageSize.value,
        type: notificationType.value,
        readStatus: readStatus.value,
        keyword: searchKeyword.value
      }
    })
    
    if (res.code === 200) {
      // 填充模拟数据，实际应该使用res.data
      fillMockData()
    } else {
      ElMessage.error(res.message || '获取通知列表失败')
    }
  } catch (error) {
    ElMessage.error('获取通知列表失败，请重试')
  } finally {
    loading.value = false
  }
}

// 填充模拟数据（实际项目中应该删除这部分，直接使用API返回数据）
const fillMockData = () => {
  notifications.value = [
    {
      id: '1',
      title: '2024-2025春季学期综合测评开始通知',
      type: 'evaluation',
      content: '<p>各位同学：</p><p>2024-2025春季学期综合测评工作即将开始，请同学们于2024年6月20日至7月10日期间登录系统进行测评项目填报。</p><p>具体要求如下：</p><ol><li>请如实填写各项测评内容，提供真实有效的证明材料；</li><li>测评项目包括思想道德、学业成绩、社会实践三个模块；</li><li>如有疑问，请联系辅导员咨询。</li></ol><p>祝各位同学测评顺利！</p>',
      publishTime: '2024-06-10 09:00:00',
      publisher: '学生处',
      readStatus: 'unread',
      isTop: true,
      attachments: [
        {
          name: '综合测评指南.pdf',
          url: '/api/file/download/guide',
          size: 2500000
        }
      ]
    },
    {
      id: '2',
      title: '2023-2024秋季学期成绩公布通知',
      type: 'score',
      content: '<p>各位同学：</p><p>2023-2024秋季学期综合测评成绩已公布，请同学们登录系统查看个人成绩。</p><p>成绩查询时间：2024年3月1日至3月15日</p><p>如有异议，请在成绩公布后3个工作日内提交申诉。</p>',
      publishTime: '2024-02-28 16:30:00',
      publisher: '学生处',
      readStatus: 'read',
      isTop: false,
      attachments: []
    },
    {
      id: '3',
      title: '系统升级维护通知',
      type: 'system',
      content: '<p>尊敬的用户：</p><p>为了提供更好的服务，综合测评系统将于2024年5月15日凌晨2:00-4:00进行升级维护，期间系统将暂时无法访问。请大家提前做好安排，避免影响使用。</p><p>感谢您的理解与支持！</p>',
      publishTime: '2024-05-10 14:00:00',
      publisher: '系统管理员',
      readStatus: 'read',
      isTop: false,
      attachments: []
    },
    {
      id: '4',
      title: '关于开展2024年暑期社会实践活动的通知',
      type: 'activity',
      content: '<p>各位同学：</p><p>为深入学习贯彻习近平新时代中国特色社会主义思想，引导广大青年学生在社会实践中受教育、长才干、作贡献，学校决定开展2024年暑期社会实践活动。</p><p>活动时间：2024年7月15日至8月20日</p><p>报名时间：2024年6月1日至6月15日</p><p>请有意愿参加的同学登录系统查看详细通知并报名。</p>',
      publishTime: '2024-05-25 10:00:00',
      publisher: '团委',
      readStatus: 'unread',
      isTop: false,
      attachments: [
        {
          name: '社会实践活动方案.docx',
          url: '/api/file/download/social-practice',
          size: 1500000
        },
        {
          name: '社会实践安全责任书.pdf',
          url: '/api/file/download/safety-responsibility',
          size: 800000
        }
      ]
    },
    {
      id: '5',
      title: '关于加强学生信息安全的通知',
      type: 'system',
      content: '<p>各位同学：</p><p>近期发现有不法分子冒充学校工作人员，以各种理由索要学生个人信息和账号密码。请同学们提高警惕，注意以下几点：</p><ol><li>学校工作人员不会以任何理由索要你的账号密码；</li><li>不要点击来历不明的链接，不要下载来历不明的文件；</li><li>定期修改密码，密码应包含字母、数字和特殊字符；</li><li>如发现可疑情况，请及时向辅导员或保卫处报告。</li></ol>',
      publishTime: '2024-04-18 15:30:00',
      publisher: '网络中心',
      readStatus: 'read',
      isTop: false,
      attachments: []
    },
    {
      id: '6',
      title: '2024-2025学年奖学金申请通知',
      type: 'evaluation',
      content: '<p>各位同学：</p><p>2024-2025学年奖学金申请工作即将开始，请符合条件的同学准备相关材料并按时提交申请。</p><p>申请时间：2024年9月1日至9月15日</p><p>申请条件及流程请查看附件。</p>',
      publishTime: '2024-08-20 09:00:00',
      publisher: '学生处',
      readStatus: 'unread',
      isTop: false,
      attachments: [
        {
          name: '奖学金申请指南.pdf',
          url: '/api/file/download/scholarship-guide',
          size: 3200000
        },
        {
          name: '奖学金申请表.docx',
          url: '/api/file/download/scholarship-form',
          size: 1200000
        }
      ]
    }
  ]
}

// 查看通知详情
const viewNotificationDetail = async (id) => {
  try {
    const res = await notificationAPI.getNotificationDetail(id)
    if (res.code === 200) {
      // 填充模拟数据，实际应该使用res.data
      setCurrentNotification(id)
      
      // 标记为已读
      if (currentNotification.value.readStatus === 'unread') {
        markAsRead(id)
      }
      
      showNotificationDetail.value = true
    } else {
      ElMessage.error(res.message || '查看通知详情失败')
    }
  } catch (error) {
    ElMessage.error('查看通知详情失败，请重试')
  }
}

// 设置当前通知详情
const setCurrentNotification = (id) => {
  const notification = notifications.value.find(item => item.id === id)
  if (notification) {
    currentNotification.value = { ...notification }
  } else {
    // 如果找不到，使用默认数据
    currentNotification.value = {
      id: '',
      title: '通知详情',
      type: 'system',
      content: '<p>暂无通知内容</p>',
      publishTime: '',
      publisher: '',
      readStatus: 'read',
      isTop: false,
      attachments: []
    }
  }
}

// 标记为已读
const markAsRead = async (id) => {
  try {
    const res = await notificationAPI.markAsRead(id)
    if (res.code === 200) {
      // 更新本地数据
      const notification = notifications.value.find(item => item.id === id)
      if (notification) {
        notification.readStatus = 'read'
      }
    }
  } catch (error) {
    console.error('标记为已读失败', error)
  }
}

// 全部标记为已读
const markAllAsRead = async () => {
  try {
    const unreadNotifications = notifications.value.filter(item => item.readStatus === 'unread')
    if (unreadNotifications.length === 0) {
      ElMessage.info('没有未读通知')
      return
    }
    
    const res = await notificationAPI.markAllAsRead()
    if (res.code === 200) {
      // 更新本地数据
      unreadNotifications.forEach(notification => {
        notification.readStatus = 'read'
      })
      ElMessage.success('全部标记为已读成功')
    } else {
      ElMessage.error(res.message || '全部标记为已读失败')
    }
  } catch (error) {
    ElMessage.error('全部标记为已读失败，请重试')
  }
}

// 删除通知
const deleteNotification = (id) => {
  ElMessageBox.confirm(
    '确定要删除此通知吗？删除后无法恢复。',
    '确认删除',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'danger'
    }
  ).then(async () => {
    try {
      const res = await notificationAPI.deleteNotification(id)
      if (res.code === 200) {
        // 更新本地数据
        const index = notifications.value.findIndex(item => item.id === id)
        if (index > -1) {
          notifications.value.splice(index, 1)
        }
        ElMessage.success('删除成功')
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

// 下载附件
const downloadAttachment = (attachment) => {
  try {
    // 创建下载链接
    const link = document.createElement('a')
    link.href = attachment.url
    link.download = attachment.name
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    ElMessage.success('开始下载附件')
  } catch (error) {
    ElMessage.error('附件下载失败，请重试')
  }
}

// 格式化文件大小
const formatFileSize = (bytes) => {
  if (bytes === 0) return '0 Bytes'
  
  const k = 1024
  const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
}

// 处理详情弹窗关闭
const handleDetailClose = () => {
  showNotificationDetail.value = false
  currentNotification.value = null
}

// 分页处理
const handleSizeChange = (size) => {
  pageSize.value = size
  fetchNotifications()
}

const handleCurrentChange = (current) => {
  currentPage.value = current
  fetchNotifications()
}

// 页面挂载时加载数据
onMounted(() => {
  fetchNotifications()
})
</script>

<style scoped>
.notifications {
  width: 100%;
  padding: 20px;
}

/* 页面标题 */
.page-header {
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0 0 5px 0;
  color: #303133;
}

.page-header p {
  margin: 0;
  color: #909399;
}

/* 筛选区域 */
.filter-section {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 10px;
}

/* 通知卡片 */
.notifications-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.unread-badge {
  margin-left: auto;
}

/* 通知标题 */
.notification-title {
  cursor: pointer;
  display: flex;
  align-items: center;
}

.unread-title {
  font-weight: bold;
  color: #303133;
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

/* 通知详情 */
.notification-detail {
  max-height: 600px;
  overflow-y: auto;
}

.detail-header {
  margin-bottom: 20px;
}

.detail-header h3 {
  margin: 0 0 10px 0;
  color: #303133;
}

.detail-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  color: #606266;
  font-size: 14px;
}

.meta-item {
  display: flex;
  align-items: center;
}

.detail-content {
  line-height: 1.8;
  color: #303133;
}

.detail-content p {
  margin: 10px 0;
}

.detail-content ol, .detail-content ul {
  margin: 10px 0;
  padding-left: 20px;
}

/* 附件列表 */
.attachment-list {
  margin-top: 20px;
}

.attachment-item {
  padding: 10px 0;
  cursor: pointer;
}

.attachment-info {
  display: flex;
  align-items: center;
  color: #303133;
}

.attachment-info:hover {
  color: #409EFF;
}

.attachment-icon {
  margin-right: 10px;
}

.attachment-name {
  margin-right: 5px;
}

.attachment-size {
  color: #909399;
  font-size: 12px;
}

/* 弹窗底部按钮 */
.dialog-footer {
  display: flex;
  justify-content: flex-end;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .notifications {
    padding: 10px;
  }
  
  .filter-section {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
  
  .filter-section .el-select,
  .filter-section .el-input,
  .filter-section .el-button {
    width: 100%;
    margin-right: 0;
    margin-left: 0;
  }
  
  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
  
  .unread-badge {
    margin-left: 0;
  }
  
  .detail-meta {
    flex-direction: column;
    gap: 5px;
  }
  
  .pagination {
    justify-content: center;
  }
}
</style>