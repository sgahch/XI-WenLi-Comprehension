<template>
  <div class="schedule-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h1>测评日程安排</h1>
      <p>查看和管理您的测评相关时间节点</p>
    </div>

    <!-- 学期选择器 -->
    <div class="semester-selector">
      <el-select v-model="selectedSemester" placeholder="请选择学期" @change="handleSemesterChange">
        <el-option
          v-for="semester in semesters"
          :key="semester.id"
          :label="semester.name"
          :value="semester.id"
        />
      </el-select>
    </div>

    <!-- 日程概览 -->
    <div class="schedule-overview">
      <el-card class="overview-card">
        <template #header>
          <div class="card-header">
            <span>当前学期重要节点</span>
          </div>
        </template>
        <div class="overview-items">
          <div v-if="upcomingEvents.length === 0" class="no-events">
            <el-empty description="暂无重要时间节点"></el-empty>
          </div>
          <div v-else class="event-items">
            <div v-for="event in upcomingEvents" :key="event.id" class="event-item">
              <el-card :class="getEventLevelClass(event.level)" class="mini-card">
                <div class="event-content">
                  <div class="event-title">{{ event.title }}</div>
                  <div class="event-date">
                    <el-icon><Calendar /></el-icon>
                    {{ formatDate(event.startDate) }} - {{ formatDate(event.endDate) }}
                  </div>
                  <div class="event-days" v-if="event.daysRemaining !== null">
                    <span v-if="event.daysRemaining > 0" class="days-remaining">还有 {{ event.daysRemaining }} 天</span>
                    <span v-else-if="event.daysRemaining === 0" class="days-today">今天截止</span>
                    <span v-else class="days-overdue">已逾期 {{ Math.abs(event.daysRemaining) }} 天</span>
                  </div>
                </div>
              </el-card>
            </div>
          </div>
        </div>
      </el-card>
    </div>

    <!-- 日历视图 -->
    <div class="calendar-section">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>日历视图</span>
            <div class="calendar-controls">
              <el-button type="text" @click="prevMonth">
                <el-icon><ArrowLeft /></el-icon>
              </el-button>
              <span class="current-month">{{ currentMonthText }}</span>
              <el-button type="text" @click="nextMonth">
                <el-icon><ArrowRight /></el-icon>
              </el-button>
            </div>
          </div>
        </template>

        <!-- 自定义日历组件 -->
        <div class="custom-calendar">
          <!-- 星期头部 -->
          <div class="calendar-header">
            <div class="weekday" v-for="day in weekDays" :key="day">{{ day }}</div>
          </div>
          
          <!-- 日期格子 -->
          <div class="calendar-body">
            <div class="calendar-row" v-for="(week, weekIndex) in calendarData" :key="weekIndex">
              <div
                v-for="(day, dayIndex) in week"
                :key="dayIndex"
                class="calendar-day"
                :class="{
                  'other-month': !day.isCurrentMonth,
                  'today': day.isToday,
                  'has-event': day.events.length > 0,
                  'past-day': day.isPast,
                  'future-day': day.isFuture
                }"
                @click="selectDay(day)"
              >
                <span class="day-number">{{ day.day }}</span>
                <div class="day-events" v-if="day.events.length > 0">
                  <div
                    v-for="event in day.events.slice(0, 2)"
                    :key="event.id"
                    :class="`event-badge event-${event.level}`"
                    :title="event.title"
                  ></div>
                  <div v-if="day.events.length > 2" class="event-more" :title="`还有${day.events.length - 2}个事件`">
                    +{{ day.events.length - 2 }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </el-card>
    </div>

    <!-- 事件列表 -->
    <div class="events-section">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>事件列表</span>
            <div class="events-filter">
              <el-select v-model="eventFilter" placeholder="筛选事件类型">
                <el-option label="全部" value="all" />
                <el-option label="截止日期" value="deadline" />
                <el-option label="开始日期" value="start" />
                <el-option label="重要提醒" value="reminder" />
              </el-select>
            </div>
          </div>
        </template>

        <el-table
          :data="filteredEvents"
          style="width: 100%"
          stripe
          border
          v-loading="loadingEvents"
          element-loading-text="加载中..."
        >
          <el-table-column prop="title" label="事件名称" min-width="250" />
          <el-table-column prop="type" label="事件类型" width="120">
            <template #default="scope">
              <el-tag :type="getEventTypeTagType(scope.row.type)">{{ getEventTypeText(scope.row.type) }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="level" label="重要程度" width="100">
            <template #default="scope">
              <el-tag :type="getEventLevelTagType(scope.row.level)">{{ getEventLevelText(scope.row.level) }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="startDate" label="开始日期" width="150" :formatter="formatDate" />
          <el-table-column prop="endDate" label="截止日期" width="150" :formatter="formatDate" />
          <el-table-column prop="daysRemaining" label="剩余天数" width="100">
            <template #default="scope">
              <span v-if="scope.row.daysRemaining > 0" class="days-remaining-text">
                {{ scope.row.daysRemaining }}天
              </span>
              <span v-else-if="scope.row.daysRemaining === 0" class="days-today-text">
                今天
              </span>
              <span v-else class="days-overdue-text">
                逾期{{ Math.abs(scope.row.daysRemaining) }}天
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="description" label="事件描述" min-width="200" show-overflow-tooltip />
          <el-table-column label="操作" width="100" fixed="right">
            <template #default="scope">
              <el-button type="text" @click="viewEventDetail(scope.row)">查看详情</el-button>
            </template>
          </el-table-column>
        </el-table>

        <!-- 分页 -->
        <div class="pagination" v-if="filteredEvents.length > 0">
          <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :page-sizes="[10, 20, 50, 100]"
            layout="total, sizes, prev, pager, next, jumper"
            :total="filteredEvents.length"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
          />
        </div>

        <!-- 无数据提示 -->
        <div v-else-if="!loadingEvents" class="no-data">
          <el-empty description="暂无事件安排"></el-empty>
        </div>
      </el-card>
    </div>

    <!-- 事件详情弹窗 -->
    <el-dialog
      v-model="showEventDetail"
      :title="selectedEvent.title"
      width="50%"
      :before-close="handleCloseDetail"
    >
      <div v-if="selectedEvent" class="event-detail">
        <el-descriptions :column="1" border>
          <el-descriptions-item label="事件类型">
            <el-tag :type="getEventTypeTagType(selectedEvent.type)">{{ getEventTypeText(selectedEvent.type) }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="重要程度">
            <el-tag :type="getEventLevelTagType(selectedEvent.level)">{{ getEventLevelText(selectedEvent.level) }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="开始日期">{{ formatDate(selectedEvent.startDate) }}</el-descriptions-item>
          <el-descriptions-item label="截止日期">{{ formatDate(selectedEvent.endDate) }}</el-descriptions-item>
          <el-descriptions-item label="剩余天数">
            <span v-if="selectedEvent.daysRemaining > 0" class="days-remaining-text">
              还有 {{ selectedEvent.daysRemaining }} 天
            </span>
            <span v-else-if="selectedEvent.daysRemaining === 0" class="days-today-text">
              今天截止
            </span>
            <span v-else class="days-overdue-text">
              已逾期 {{ Math.abs(selectedEvent.daysRemaining) }} 天
            </span>
          </el-descriptions-item>
          <el-descriptions-item label="详细描述" :contentStyle="{ whiteSpace: 'pre-wrap' }">
            {{ selectedEvent.description }}
          </el-descriptions-item>
          <el-descriptions-item label="操作指南" :contentStyle="{ whiteSpace: 'pre-wrap' }" v-if="selectedEvent.guide">
            {{ selectedEvent.guide }}
          </el-descriptions-item>
        </el-descriptions>

        <!-- 相关链接 -->
        <div v-if="selectedEvent.links && selectedEvent.links.length > 0" class="event-links">
          <h4>相关链接：</h4>
          <el-list>
            <el-list-item v-for="(link, index) in selectedEvent.links" :key="index">
              <template #default>
                <el-link :href="link.url" target="_blank" type="primary">
                  <el-icon><Link /></el-icon>
                  {{ link.name }}
                </el-link>
              </template>
            </el-list-item>
          </el-list>
        </div>
      </div>

      <template #footer>
        <span class="dialog-footer">
          <el-button @click="handleCloseDetail">关闭</el-button>
          <el-button type="primary" @click="setReminder" v-if="selectedEvent.daysRemaining > 0">
            设置提醒
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { Calendar, ArrowLeft, ArrowRight, Link } from '@element-plus/icons-vue'
import { useUserStore } from '../../store/index.js'
import { getSemesterSchedule, getEventDetail } from '../../api/schedule.js'

const userStore = useUserStore()

// 加载状态
const loadingEvents = ref(false)

// 学期数据
const semesters = ref([
  { id: '2023-2024-2', name: '2023-2024学年第二学期' },
  { id: '2023-2024-1', name: '2023-2024学年第一学期' },
  { id: '2022-2023-2', name: '2022-2023学年第二学期' }
])

// 选中的学期
const selectedSemester = ref('2023-2024-2')

// 事件数据
const events = ref([])
const upcomingEvents = ref([])

// 事件筛选
const eventFilter = ref('all')

// 分页数据
const currentPage = ref(1)
const pageSize = ref(10)
const totalEvents = ref(0)

// 日历相关
const weekDays = ['日', '一', '二', '三', '四', '五', '六']
const currentDate = ref(new Date())
const calendarData = ref([])
const selectedDay = ref(null)

// 事件详情弹窗
const showEventDetail = ref(false)
const selectedEvent = ref({})

// 获取当前月份文本
const currentMonthText = computed(() => {
  const year = currentDate.value.getFullYear()
  const month = currentDate.value.getMonth() + 1
  return `${year}年${month}月`
})

// 格式化日期
const formatDate = (dateStr) => {
  if (!dateStr) return ''
  const date = new Date(dateStr)
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

// 计算剩余天数
const calculateDaysRemaining = (endDateStr) => {
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  const endDate = new Date(endDateStr)
  endDate.setHours(0, 0, 0, 0)
  const diffTime = endDate - today
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
  return diffDays
}

// 获取事件类型文本
const getEventTypeText = (type) => {
  const typeMap = {
    deadline: '截止日期',
    start: '开始日期',
    reminder: '重要提醒'
  }
  return typeMap[type] || type
}

// 获取事件类型标签类型
const getEventTypeTagType = (type) => {
  const typeMap = {
    deadline: 'danger',
    start: 'primary',
    reminder: 'warning'
  }
  return typeMap[type] || 'default'
}

// 获取事件重要程度文本
const getEventLevelText = (level) => {
  const levelMap = {
    high: '高',
    medium: '中',
    low: '低'
  }
  return levelMap[level] || level
}

// 获取事件重要程度标签类型
const getEventLevelTagType = (level) => {
  const levelMap = {
    high: 'danger',
    medium: 'warning',
    low: 'success'
  }
  return levelMap[level] || 'default'
}

// 获取事件重要程度样式类
const getEventLevelClass = (level) => {
  const levelMap = {
    high: 'event-high',
    medium: 'event-medium',
    low: 'event-low'
  }
  return levelMap[level] || ''
}

// 筛选后的事件列表
const filteredEvents = computed(() => {
  let filtered = [...events.value]
  
  if (eventFilter.value !== 'all') {
    filtered = filtered.filter(event => event.type === eventFilter.value)
  }
  
  // 按截止日期排序，即将到期的事件排在前面
  filtered.sort((a, b) => {
    if (a.daysRemaining === null) return 1
    if (b.daysRemaining === null) return -1
    return a.daysRemaining - b.daysRemaining
  })
  
  totalEvents.value = filtered.length
  
  // 分页处理
  const startIndex = (currentPage.value - 1) * pageSize.value
  const endIndex = startIndex + pageSize.value
  return filtered.slice(startIndex, endIndex)
})

// 获取日程数据
const fetchScheduleData = async (semesterId) => {
  try {
    loadingEvents.value = true
    // 实际项目中应该调用API
    // const response = await getSemesterSchedule(semesterId)
    // events.value = response.data
    
    // 使用模拟数据
    loadMockScheduleData(semesterId)
    
    // 计算剩余天数
    events.value.forEach(event => {
      if (event.endDate) {
        event.daysRemaining = calculateDaysRemaining(event.endDate)
      } else {
        event.daysRemaining = null
      }
    })
    
    // 更新近期重要事件
    updateUpcomingEvents()
    
    // 生成日历数据
    generateCalendarData()
  } catch (error) {
    ElMessage.error('获取日程数据失败')
    console.error('获取日程数据失败:', error)
  } finally {
    loadingEvents.value = false
  }
}

// 加载模拟日程数据
const loadMockScheduleData = (semesterId) => {
  const baseDate = new Date()
  const today = new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate())
  
  // 生成日期函数
  const addDays = (date, days) => {
    const newDate = new Date(date)
    newDate.setDate(newDate.getDate() + days)
    return newDate
  }
  
  const formatDateForData = (date) => {
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
  }
  
  events.value = [
    {
      id: 1,
      title: '思想道德测评数据填报',
      type: 'start',
      level: 'high',
      startDate: formatDateForData(addDays(today, 3)),
      endDate: formatDateForData(addDays(today, 10)),
      description: '学生登录系统，填写本学年思想道德表现相关信息，包括政治学习、志愿服务、社会实践等内容。',
      guide: '1. 登录系统后点击"测评填报"\n2. 选择"思想道德"模块\n3. 如实填写各项内容\n4. 上传相关证明材料\n5. 提交审核'
    },
    {
      id: 2,
      title: '学业成绩自评提交截止',
      type: 'deadline',
      level: 'high',
      startDate: formatDateForData(addDays(today, -5)),
      endDate: formatDateForData(addDays(today, 2)),
      description: '学生提交学业成绩自评表，包括课程成绩、科研参与、学术竞赛等情况。',
      guide: '1. 准备好成绩单和获奖证书\n2. 登录系统填写相关信息\n3. 上传证明材料\n4. 确认提交'
    },
    {
      id: 3,
      title: '班级互评开始',
      type: 'start',
      level: 'medium',
      startDate: formatDateForData(addDays(today, 15)),
      endDate: formatDateForData(addDays(today, 20)),
      description: '班级成员之间进行综合素质互评，评价内容包括思想道德、学业表现、社会实践等方面。',
      links: [
        { name: '班级互评指南', url: '#' },
        { name: '评价标准说明', url: '#' }
      ]
    },
    {
      id: 4,
      title: '辅导员审核期',
      type: 'reminder',
      level: 'medium',
      startDate: formatDateForData(addDays(today, 22)),
      endDate: formatDateForData(addDays(today, 30)),
      description: '辅导员对学生提交的测评数据进行审核，如有问题会反馈给学生进行修改。',
      guide: '请保持联系方式畅通，及时查看系统通知，如有需要配合修改数据。'
    },
    {
      id: 5,
      title: '成绩公示期',
      type: 'reminder',
      level: 'high',
      startDate: formatDateForData(addDays(today, 35)),
      endDate: formatDateForData(addDays(today, 40)),
      description: '综合测评初步成绩公示，学生可登录系统查看自己的测评成绩。',
      guide: '1. 登录系统后点击"成绩查询"\n2. 查看各项测评成绩\n3. 如有异议，在公示期内提交申诉'
    },
    {
      id: 6,
      title: '申诉截止日期',
      type: 'deadline',
      level: 'high',
      startDate: formatDateForData(addDays(today, 35)),
      endDate: formatDateForData(addDays(today, 42)),
      description: '学生对测评成绩有异议的，需在此日期前提交申诉申请。',
      guide: '1. 点击"成绩申诉"\n2. 选择申诉项目\n3. 填写申诉理由\n4. 上传证明材料\n5. 提交申诉',
      links: [
        { name: '申诉流程说明', url: '#' }
      ]
    },
    {
      id: 7,
      title: '最终成绩公布',
      type: 'reminder',
      level: 'high',
      startDate: formatDateForData(addDays(today, 50)),
      endDate: formatDateForData(addDays(today, 50)),
      description: '综合测评最终成绩正式公布，学生可登录系统查看最终测评结果。',
      guide: '最终成绩将作为评优评先、奖学金评定的重要依据。'
    }
  ]
}

// 更新近期重要事件
const updateUpcomingEvents = () => {
  // 获取未来30天内的高、中等级事件
  const today = new Date()
  const futureDate = new Date()
  futureDate.setDate(today.getDate() + 30)
  
  upcomingEvents.value = events.value
    .filter(event => {
      const eventDate = event.endDate ? new Date(event.endDate) : new Date(event.startDate)
      return (event.level === 'high' || event.level === 'medium') && 
             eventDate >= today && 
             eventDate <= futureDate
    })
    .sort((a, b) => {
      // 按重要程度和剩余天数排序
      if (a.level !== b.level) {
        return a.level === 'high' ? -1 : 1
      }
      return (a.daysRemaining || 0) - (b.daysRemaining || 0)
    })
    .slice(0, 5) // 最多显示5个
}

// 生成日历数据
const generateCalendarData = () => {
  const year = currentDate.value.getFullYear()
  const month = currentDate.value.getMonth()
  
  // 获取当月第一天是星期几
  const firstDay = new Date(year, month, 1)
  const firstDayOfWeek = firstDay.getDay()
  
  // 获取当月的天数
  const daysInMonth = new Date(year, month + 1, 0).getDate()
  
  // 获取上个月的最后几天
  const prevMonth = month === 0 ? 11 : month - 1
  const prevMonthYear = month === 0 ? year - 1 : year
  const daysInPrevMonth = new Date(prevMonthYear, prevMonth + 1, 0).getDate()
  
  const calendar = []
  let week = []
  
  // 添加上个月的日期
  for (let i = firstDayOfWeek - 1; i >= 0; i--) {
    const day = daysInPrevMonth - i
    const date = new Date(prevMonthYear, prevMonth, day)
    week.push({
      day,
      date,
      isCurrentMonth: false,
      isToday: false,
      isPast: true,
      isFuture: false,
      events: getEventsForDate(date)
    })
  }
  
  // 添加当月的日期
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  
  for (let day = 1; day <= daysInMonth; day++) {
    const date = new Date(year, month, day)
    const dateOnly = new Date(year, month, day)
    dateOnly.setHours(0, 0, 0, 0)
    
    week.push({
      day,
      date,
      isCurrentMonth: true,
      isToday: dateOnly.getTime() === today.getTime(),
      isPast: dateOnly < today,
      isFuture: dateOnly > today,
      events: getEventsForDate(date)
    })
    
    // 每周结束后换行
    if (week.length === 7) {
      calendar.push(week)
      week = []
    }
  }
  
  // 添加下个月的日期，补足最后一周
  if (week.length > 0) {
    const nextMonth = month === 11 ? 0 : month + 1
    const nextMonthYear = month === 11 ? year + 1 : year
    const remainingDays = 7 - week.length
    
    for (let day = 1; day <= remainingDays; day++) {
      const date = new Date(nextMonthYear, nextMonth, day)
      week.push({
        day,
        date,
        isCurrentMonth: false,
        isToday: false,
        isPast: false,
        isFuture: true,
        events: getEventsForDate(date)
      })
    }
    
    calendar.push(week)
  }
  
  calendarData.value = calendar
}

// 获取指定日期的事件
const getEventsForDate = (date) => {
  const dateStr = formatDate(date)
  return events.value.filter(event => {
    const eventStartDate = formatDate(event.startDate)
    const eventEndDate = event.endDate ? formatDate(event.endDate) : eventStartDate
    return dateStr >= eventStartDate && dateStr <= eventEndDate
  })
}

// 处理学期变更
const handleSemesterChange = (semesterId) => {
  // 重置分页
  currentPage.value = 1
  // 重新获取日程数据
  fetchScheduleData(semesterId)
}

// 上个月
const prevMonth = () => {
  currentDate.value.setMonth(currentDate.value.getMonth() - 1)
  generateCalendarData()
}

// 下个月
const nextMonth = () => {
  currentDate.value.setMonth(currentDate.value.getMonth() + 1)
  generateCalendarData()
}

// 选择日期
const selectDay = (day) => {
  selectedDay.value = day
  if (day.events.length > 0) {
    // 如果有事件，可以自动显示第一个事件的详情
    selectedEvent.value = day.events[0]
    showEventDetail.value = true
  }
}

// 查看事件详情
const viewEventDetail = async (event) => {
  try {
    // 实际项目中应该调用API
    // const response = await getEventDetail(event.id)
    // selectedEvent.value = response.data
    
    // 使用现有数据
    selectedEvent.value = { ...event }
    showEventDetail.value = true
  } catch (error) {
    ElMessage.error('查看事件详情失败')
    console.error('查看事件详情失败:', error)
  }
}

// 关闭详情弹窗
const handleCloseDetail = () => {
  showEventDetail.value = false
  selectedEvent.value = {}
}

// 设置提醒
const setReminder = () => {
  ElMessage.success('提醒设置成功！系统将在事件开始前向您发送通知')
}

// 分页处理
const handleSizeChange = (size) => {
  pageSize.value = size
  currentPage.value = 1
}

const handleCurrentChange = (current) => {
  currentPage.value = current
}

// 监听筛选条件变化
watch(eventFilter, () => {
  currentPage.value = 1
})

// 组件挂载时初始化数据
onMounted(() => {
  fetchScheduleData(selectedSemester.value)
})
</script>

<style scoped>
.schedule-container {
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

.semester-selector {
  margin-bottom: 20px;
  width: 300px;
}

.schedule-overview {
  margin-bottom: 20px;
}

.overview-items {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
}

.event-items {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
}

.event-item {
  flex: 1;
  min-width: 200px;
}

.mini-card {
  height: 100%;
}

.event-content {
  text-align: center;
  padding: 10px;
}

.event-title {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.event-date {
  font-size: 12px;
  color: #606266;
  margin-bottom: 5px;
}

.event-days {
  font-size: 12px;
  font-weight: 500;
}

.days-remaining {
  color: #67c23a;
}

.days-today {
  color: #e6a23c;
}

.days-overdue {
  color: #f56c6c;
}

.event-high {
  border-left: 4px solid #f56c6c;
}

.event-medium {
  border-left: 4px solid #e6a23c;
}

.event-low {
  border-left: 4px solid #67c23a;
}

.calendar-section {
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

.calendar-controls {
  display: flex;
  align-items: center;
  gap: 10px;
}

.current-month {
  font-weight: 500;
  min-width: 100px;
  text-align: center;
}

.custom-calendar {
  margin-top: 20px;
}

.calendar-header {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  background-color: #f5f7fa;
  padding: 10px 0;
}

.weekday {
  text-align: center;
  font-weight: 500;
  color: #606266;
}

.calendar-body {
  border: 1px solid #ebeef5;
  border-top: none;
}

.calendar-row {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
}

.calendar-day {
  height: 100px;
  border: 1px solid #ebeef5;
  padding: 5px;
  display: flex;
  flex-direction: column;
  cursor: pointer;
  transition: background-color 0.3s;
}

.calendar-day:hover {
  background-color: #f5f7fa;
}

.calendar-day.other-month {
  background-color: #fafafa;
  color: #c0c4cc;
}

.calendar-day.today {
  background-color: #ecf5ff;
}

.calendar-day.today .day-number {
  background-color: #409eff;
  color: white;
  border-radius: 50%;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
}

.day-number {
  font-size: 14px;
  margin-bottom: 5px;
  text-align: center;
}

.day-events {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.event-badge {
  width: 100%;
  height: 4px;
  border-radius: 2px;
}

.event-high {
  background-color: #f56c6c;
}

.event-medium {
  background-color: #e6a23c;
}

.event-low {
  background-color: #67c23a;
}

.event-more {
  font-size: 10px;
  color: #909399;
  text-align: center;
  margin-top: 2px;
}

.events-section {
  margin-bottom: 20px;
}

.events-filter {
  width: 200px;
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

.event-detail {
  padding: 20px 0;
}

.event-links {
  margin-top: 20px;
}

.event-links h4 {
  margin: 0 0 10px 0;
  color: #303133;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
}

.days-remaining-text {
  color: #67c23a;
}

.days-today-text {
  color: #e6a23c;
}

.days-overdue-text {
  color: #f56c6c;
}

@media (max-width: 768px) {
  .schedule-container {
    padding: 10px;
  }
  
  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 10px;
  }
  
  .semester-selector {
    width: 100%;
  }
  
  .event-item {
    min-width: 100%;
  }
  
  .calendar-day {
    height: 80px;
  }
  
  .pagination {
    justify-content: center;
  }
}
</style>