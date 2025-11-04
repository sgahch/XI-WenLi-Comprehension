<template>
  <div class="submission-form-container">
    <!-- 页面头部 -->
    <el-card shadow="never" class="header-card">
      <div slot="header" class="header-content">
        <div class="title-section">
          <h2><i class="el-icon-edit-outline"></i> 综合测评填报</h2>
          <p class="subtitle">Comprehensive Assessment Submission</p>
        </div>
        <div class="action-section">
          <el-button 
            type="primary" 
            icon="el-icon-document" 
            @click="saveDraft"
            :loading="saving"
            :disabled="isViewMode"
          >
            保存草稿
          </el-button>
          <el-button 
            type="success" 
            icon="el-icon-check" 
            @click="submitForAudit"
            :loading="submitting"
            :disabled="isViewMode"
          >
            提交审核
          </el-button>
        </div>
      </div>
    </el-card>

    <el-row :gutter="20">
      <!-- 左侧主要内容区 -->
      <el-col :span="18">
        <!-- 基本信息 -->
        <el-card shadow="never" class="basic-info-card">
          <div slot="header">
            <i class="el-icon-user"></i>
            <span>基本信息</span>
          </div>
          
          <el-form 
            :model="formData" 
            :rules="formRules" 
            ref="basicForm" 
            label-width="100px"
            class="basic-form"
          >
            <el-row :gutter="20">
              <el-col :span="8">
                <el-form-item label="学年" prop="academicYear">
                  <el-select 
                    v-model="formData.academicYear" 
                    placeholder="请选择学年"
                    :disabled="isViewMode"
                    style="width: 100%"
                  >
                    <el-option
                      v-for="year in academicYearOptions"
                      :key="year"
                      :label="year"
                      :value="year"
                    />
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item label="学期" prop="semester">
                  <el-select 
                    v-model="formData.semester" 
                    placeholder="请选择学期"
                    :disabled="isViewMode"
                    style="width: 100%"
                  >
                    <el-option label="第一学期" :value="1" />
                    <el-option label="第二学期" :value="2" />
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item label="班级" prop="classId">
                  <el-input
                    v-model="className"
                    placeholder="加载中..."
                    :disabled="true"
                    style="width: 100%"
                  >
                    <i slot="prefix" class="el-icon-school"></i>
                  </el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
        </el-card>

        <!-- 成果填报区域 -->
        <el-card shadow="never" class="achievements-card">
          <div slot="header">
            <i class="el-icon-trophy"></i>
            <span>成果填报</span>
          </div>

          <el-tabs v-model="activeTab" type="card" class="dimension-tabs">
            <!-- 德育 -->
            <el-tab-pane label="德育" name="moral">
              <achievement-dimension
                ref="moralDimension"
                dimension="moral"
                dimension-name="德育"
                :achievements="achievements.moral"
                :rule-options="ruleOptions.moral"
                :is-view-mode="isViewMode"
                @achievement-change="handleAchievementChange"
                @score-change="updateDimensionScore"
              />
            </el-tab-pane>

            <!-- 智育 -->
            <el-tab-pane label="智育" name="intellectual">
              <!-- 成绩截图上传区域 -->
              <el-card shadow="never" class="screenshot-upload-card">
                <div slot="header">
                  <i class="el-icon-picture-outline"></i>
                  <span>成绩截图上传</span>
                  <el-tooltip content="请上传教务系统的成绩截图，用于核验智育成绩" placement="top">
                    <i class="el-icon-question" style="margin-left: 8px; color: #909399; cursor: help;"></i>
                  </el-tooltip>
                </div>
                <grade-screenshot-upload
                  v-model="gradeScreenshots"
                  :submission-id="submissionId"
                  :is-view-mode="isViewMode"
                  @change="handleScreenshotChange"
                />
              </el-card>

              <!-- 课程成绩录入区域 -->
              <el-card shadow="never" class="course-grade-card">
                <div slot="header">
                  <i class="el-icon-edit"></i>
                  <span>课程成绩录入</span>
                  <el-tooltip content="请根据成绩截图录入各科成绩，系统将自动计算加分" placement="top">
                    <i class="el-icon-question" style="margin-left: 8px; color: #909399; cursor: help;"></i>
                  </el-tooltip>
                </div>
                <course-grade-input
                  ref="courseGradeInput"
                  :achievements="courseAchievements"
                  :rule-options="flatIntellectualRules"
                  :is-view-mode="isViewMode"
                  @achievement-change="handleCourseAchievementChange"
                  @score-change="handleCourseScoreChange"
                />
              </el-card>

              <!-- 其他智育成果（学科竞赛、科研项目等） -->
              <el-card shadow="never" class="other-achievement-card">
                <div slot="header">
                  <i class="el-icon-trophy"></i>
                  <span>其他智育成果</span>
                  <el-tooltip content="学科竞赛、科研项目、学术论文等" placement="top">
                    <i class="el-icon-question" style="margin-left: 8px; color: #909399; cursor: help;"></i>
                  </el-tooltip>
                </div>
                <achievement-dimension
                  ref="intellectualDimension"
                  dimension="intellectual"
                  dimension-name="智育"
                  :achievements="otherIntellectualAchievements"
                  :rule-options="otherIntellectualRuleOptions"
                  :is-view-mode="isViewMode"
                  @achievement-change="handleOtherAchievementChange"
                  @score-change="handleOtherScoreChange"
                />
              </el-card>
            </el-tab-pane>

            <!-- 体育 -->
            <el-tab-pane label="体育" name="physical">
              <achievement-dimension
                ref="physicalDimension"
                dimension="physical"
                dimension-name="体育"
                :achievements="achievements.physical"
                :rule-options="ruleOptions.physical"
                :is-view-mode="isViewMode"
                @achievement-change="handleAchievementChange"
                @score-change="updateDimensionScore"
              />
            </el-tab-pane>

            <!-- 美育 -->
            <el-tab-pane label="美育" name="aesthetic">
              <achievement-dimension
                ref="aestheticDimension"
                dimension="aesthetic"
                dimension-name="美育"
                :achievements="achievements.aesthetic"
                :rule-options="ruleOptions.aesthetic"
                :is-view-mode="isViewMode"
                @achievement-change="handleAchievementChange"
                @score-change="updateDimensionScore"
              />
            </el-tab-pane>

            <!-- 劳育 -->
            <el-tab-pane label="劳育" name="labor">
              <achievement-dimension
                ref="laborDimension"
                dimension="labor"
                dimension-name="劳育"
                :achievements="achievements.labor"
                :rule-options="ruleOptions.labor"
                :is-view-mode="isViewMode"
                @achievement-change="handleAchievementChange"
                @score-change="updateDimensionScore"
              />
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>

      <!-- 右侧分数总览 -->
      <el-col :span="6">
        <div class="score-overview-container">
          <score-overview
            :scores="scoreOverview"
            :total-score="totalScore"
            class="score-overview-panel"
          />
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import AchievementDimension from './components/AchievementDimension.vue'
import CourseGradeInput from './components/CourseGradeInput.vue'
import ScoreOverview from './components/ScoreOverview.vue'
import GradeScreenshotUpload from '@/components/evaluation/GradeScreenshotUpload.vue'
import { getRuleTree, createSubmission, updateSubmission, getSubmissionDetail } from '@/api/evaluation/submission'
import { listDept } from '@/api/system/dept'
import { parseTime } from '@/utils/ruoyi'

export default {
  name: 'SubmissionForm',
  components: {
    AchievementDimension,
    CourseGradeInput,
    ScoreOverview,
    GradeScreenshotUpload
  },
  props: {
    // 表单模式：add-新增, edit-编辑, view-查看
    mode: {
      type: String,
      default: 'add'
    },
    // 记录ID（编辑和查看模式需要）
    recordId: {
      type: [String, Number],
      default: null
    }
  },
  data() {
    return {
      // 当前激活的标签页
      activeTab: 'moral',
      
      // 表单数据
      formData: {
        id: null,
        academicYear: '',
        semester: null,
        classId: null,
        status: 0, // 0-草稿，1-待审核
        remark: ''
      },

      // 各维度成果数据
      achievements: {
        moral: [],
        intellectual: [],
        physical: [],
        aesthetic: [],
        labor: []
      },

      // 成绩截图列表
      gradeScreenshots: [],

      // 成绩截图URL列表（用于提交）
      gradeScreenshotUrls: [],

      // 填报ID（用于成绩截图上传）
      submissionId: null,

      // 班级名称（只读展示）
      className: '',

      // 各维度规则选项（级联数据）
      ruleOptions: {
        moral: [],
        intellectual: [],
        physical: [],
        aesthetic: [],
        labor: []
      },

      // 分数总览
      scoreOverview: {
        moral: { name: '德育', score: 0, color: '#e74c3c' },
        intellectual: { name: '智育', score: 0, color: '#3498db' },
        physical: { name: '体育', score: 0, color: '#27ae60' },
        aesthetic: { name: '美育', score: 0, color: '#9b59b6' },
        labor: { name: '劳育', score: 0, color: '#f39c12' }
      },

      // 学年选项
      academicYearOptions: [],

      // 班级选项
      classOptions: [],

      // 表单验证规则
      formRules: {
        academicYear: [
          { required: true, message: '请选择学年', trigger: 'change' }
        ],
        semester: [
          { required: true, message: '请选择学期', trigger: 'change' }
        ],
        classId: [
          { required: true, message: '请选择班级', trigger: 'change' }
        ]
      },

      // 加载状态
      loading: false,
      saving: false,
      submitting: false,

      // 自动保存定时器
      autoSaveTimer: null
    }
  },
  computed: {
    // 是否为查看模式
    isViewMode() {
      return this.mode === 'view'
    },

    // 总分
    totalScore() {
      return Object.values(this.scoreOverview).reduce((sum, item) => sum + item.score, 0)
    },

    // 课程成绩（从智育成果中过滤）
    courseAchievements() {
      return this.achievements.intellectual.filter(a => a.category === '课程成绩')
    },

    // 其他智育成果（非课程成绩）
    otherIntellectualAchievements() {
      return this.achievements.intellectual.filter(a => a.category !== '课程成绩')
    },

    // 其他智育规则选项（非课程成绩）
    otherIntellectualRuleOptions() {
      return this.ruleOptions.intellectual.filter(r => r.category !== '课程成绩')
    },

    // 扁平化的智育规则列表（用于CourseGradeInput组件）
    flatIntellectualRules() {
      const flatRules = []

      // 安全检查：确保 ruleOptions.intellectual 是数组
      if (!Array.isArray(this.ruleOptions.intellectual)) {
        console.warn('[SubmissionForm] ruleOptions.intellectual 不是数组:', this.ruleOptions.intellectual)
        return flatRules
      }

      // 遍历级联数据结构，提取所有规则
      this.ruleOptions.intellectual.forEach(category => {
        // 安全检查：确保 category.children 存在
        if (!category || !Array.isArray(category.children)) {
          console.warn('[SubmissionForm] category.children 不存在或不是数组:', category)
          return
        }

        category.children.forEach(item => {
          // 安全检查：确保 item.children 存在
          if (!item || !Array.isArray(item.children)) {
            console.warn('[SubmissionForm] item.children 不存在或不是数组:', item)
            return
          }

          item.children.forEach(level => {
            // 安全检查：确保 level 和 level.ruleData 存在
            if (!level || !level.ruleData) {
              console.warn('[SubmissionForm] level 或 level.ruleData 不存在:', level)
              return
            }

            flatRules.push({
              id: level.value,
              category: category.value,
              itemName: item.value,
              level: level.ruleData.level,
              score: level.score,
              requireAttachment: level.requireAttachment,
              attachmentTypes: level.attachmentTypes,
              ruleData: level.ruleData,
              // 添加课程相关字段（如果存在）
              courseCode: level.ruleData.courseCode || level.ruleData.itemCode || '',
              credit: level.ruleData.credit || 0,
              gradePoint: level.ruleData.gradePoint || 0
            })
          })
        })
      })

      console.log('[SubmissionForm] flatIntellectualRules 生成完成，共', flatRules.length, '条规则')
      return flatRules
    }
  },
  watch: {
    // 监听记录ID变化，重新加载数据
    recordId: {
      handler(newVal) {
        if (newVal && (this.mode === 'edit' || this.mode === 'view')) {
          this.loadSubmissionData()
        }
      },
      immediate: true
    }
  },
  created() {
    this.initializeData()
  },
  watch: {
    // 监听基本信息变化，自动保存草稿
    'formData.academicYear': 'checkAndAutoSaveDraft',
    'formData.semester': 'checkAndAutoSaveDraft',
    'formData.classId': 'checkAndAutoSaveDraft'
  },
  methods: {
    // 初始化数据
    async initializeData() {
      this.loading = true
      try {
        // 并行加载基础数据
        await Promise.all([
          this.generateAcademicYears(),
          this.loadClassOptions(),
          this.loadRuleOptions()
        ])

        // 如果是编辑或查看模式，加载填报数据
        if (this.recordId && (this.mode === 'edit' || this.mode === 'view')) {
          await this.loadSubmissionData()
        } else {
          // 新增模式，设置默认值
          this.setDefaultValues()
          // 尝试加载本地草稿
          this.loadDraftFromLocalStorage()
        }
      } catch (error) {
        console.error('初始化数据失败:', error)
        this.$message.error('初始化数据失败')
      } finally {
        this.loading = false
      }
    },

    // 生成学年选项
    generateAcademicYears() {
      const currentYear = new Date().getFullYear()
      const years = []
      for (let i = -2; i <= 2; i++) {
        const startYear = currentYear + i
        const endYear = startYear + 1
        years.push(`${startYear}-${endYear}`)
      }
      this.academicYearOptions = years
    },

    // 加载班级信息（从用户信息中获取）
    async loadClassOptions() {
      try {
        // 从store获取用户信息
        const dept = this.$store.getters.dept
        const deptId = this.$store.getters.deptId

        if (dept && dept.deptId && dept.deptName) {
          // 自动设置用户所属班级
          this.formData.classId = dept.deptId
          this.className = dept.deptName
          console.log('已自动设置班级:', dept.deptName)
        } else if (deptId) {
          // 如果只有deptId，没有dept对象
          this.formData.classId = deptId
          this.className = '班级ID: ' + deptId
          console.warn('部门信息不完整，只有deptId:', deptId)
        } else {
          this.$message.error('无法获取用户班级信息，请联系管理员')
          this.className = '未设置班级'
        }
      } catch (error) {
        console.error('加载班级信息失败:', error)
        this.$message.error('加载班级信息失败')
        this.className = '加载失败'
      }
    },

    // 加载规则选项（级联数据）
    async loadRuleOptions() {
      try {
        const dimensions = ['moral', 'intellectual', 'physical', 'aesthetic', 'labor']
        
        for (const dimension of dimensions) {
          const response = await getRuleTree({ dimension })
          if (response.code === 200 && response.data.length > 0) {
            this.ruleOptions[dimension] = this.transformRuleData(response.data[0])
          }
        }
      } catch (error) {
        console.error('加载规则选项失败:', error)
        this.$message.error('加载规则选项失败')
      }
    },

    // 转换规则数据为级联选择器格式
    transformRuleData(dimensionData) {
      return dimensionData.categories.map(category => ({
        value: category.category,
        label: category.category,
        children: category.items.map(item => ({
          value: item.itemName,
          label: item.itemName,
          children: item.levels.map(level => ({
            value: level.id,
            label: `${level.level} (${level.score}分)`,
            score: level.score,
            requireAttachment: level.requireAttachment,
            attachmentTypes: level.attachmentTypes,
            ruleData: level,
            // 兼容处理：如果id是字符串则解析，如果是数字则直接使用
            ruleId: typeof level.id === 'string'
              ? (parseInt(level.id.split("_").pop()) || null)
              : level.id
          }))
        }))
      }))
    },

    // 设置默认值
    setDefaultValues() {
      const currentYear = new Date().getFullYear()
      const currentMonth = new Date().getMonth() + 1
      
      // 设置默认学年
      this.formData.academicYear = `${currentYear}-${currentYear + 1}`
      
      // 根据当前月份设置默认学期
      this.formData.semester = currentMonth >= 9 || currentMonth <= 1 ? 1 : 2
    },

    // 加载填报数据
    async loadSubmissionData() {
      try {
        const response = await getSubmissionDetail(this.recordId)
        if (response.code === 200) {
          const data = response.data

          // 设置基本信息
          this.formData = {
            id: data.id,
            academicYear: data.academicYear,
            semester: data.semester,
            classId: data.classId,
            status: data.status,
            remark: data.remark || ''
          }

          // 设置submissionId（用于成绩截图上传）
          this.submissionId = data.id

          // 设置成果数据
          this.loadAchievementsFromDetails(data.details)

          // 更新分数总览
          this.updateAllScores()
        }
      } catch (error) {
        console.error('加载填报数据失败:', error)
        this.$message.error('加载填报数据失败')
      }
    },

    // 从详情数据加载成果
    loadAchievementsFromDetails(details) {
      // 清空现有成果
      Object.keys(this.achievements).forEach(key => {
        this.achievements[key] = []
      })

      // 按维度分组详情数据
      details.forEach(detail => {
        const dimension = detail.ruleSnapshot.dimension
        if (this.achievements[dimension]) {
          this.achievements[dimension].push({
            id: detail.id,
            ruleId: detail.ruleId,
            selectedRule: [
              detail.ruleSnapshot.category,
              detail.ruleSnapshot.itemName,
              detail.ruleId
            ],
            score: detail.finalScore,
            remark: detail.remark || '',
            attachments: detail.attachments || [],
            ruleData: detail.ruleSnapshot
          })
        }
      })
    },

    // 处理成果变化
    handleAchievementChange(dimension, achievements) {
      this.achievements[dimension] = achievements
      this.updateDimensionScore(dimension)
    },

    // 处理课程成绩变化
    handleCourseAchievementChange(dimension, courseList) {
      console.log('[SubmissionForm] 课程成绩变更:', courseList)

      // 防止重复更新：检查是否真的有变化
      const otherAchievements = this.achievements.intellectual.filter(a => a.category !== '课程成绩')
      const newIntellectual = [...courseList, ...otherAchievements]

      // 生成指纹比较
      const oldFingerprint = this.achievements.intellectual
        .map(a => `${a.ruleId}-${a.grade}-${a.score}-${a.level}`)
        .sort()
        .join('|')
      const newFingerprint = newIntellectual
        .map(a => `${a.ruleId}-${a.grade}-${a.score}-${a.level}`)
        .sort()
        .join('|')

      if (oldFingerprint === newFingerprint) {
        console.log('[SubmissionForm] 课程成绩无实质变化，跳过更新')
        return
      }

      this.achievements.intellectual = newIntellectual
      console.log('[SubmissionForm] 合并后的智育成果:', this.achievements.intellectual)
      this.updateDimensionScore('intellectual')
    },

    // 处理课程成绩分数变化
    handleCourseScoreChange(dimension, score) {
      console.log('[SubmissionForm] 课程成绩分数变更:', score)
      // 重新计算智育总分
      this.updateDimensionScore('intellectual')
    },

    // 处理其他智育成果变化
    handleOtherAchievementChange(dimension, otherList) {
      console.log('[SubmissionForm] 其他智育成果变更:', otherList)

      // 防止重复更新：检查是否真的有变化
      const courseAchievements = this.achievements.intellectual.filter(a => a.category === '课程成绩')
      const newIntellectual = [...courseAchievements, ...otherList]

      // 生成指纹比较
      const oldFingerprint = this.achievements.intellectual
        .map(a => `${a.ruleId}-${a.grade}-${a.score}-${a.level}`)
        .sort()
        .join('|')
      const newFingerprint = newIntellectual
        .map(a => `${a.ruleId}-${a.grade}-${a.score}-${a.level}`)
        .sort()
        .join('|')

      if (oldFingerprint === newFingerprint) {
        console.log('[SubmissionForm] 其他智育成果无实质变化，跳过更新')
        return
      }

      this.achievements.intellectual = newIntellectual
      console.log('[SubmissionForm] 合并后的智育成果:', this.achievements.intellectual)
      this.updateDimensionScore('intellectual')
    },

    // 处理其他智育成果分数变化
    handleOtherScoreChange(dimension, score) {
      console.log('[SubmissionForm] 其他智育成果分数变更:', score)
      // 重新计算智育总分
      this.updateDimensionScore('intellectual')
    },

    // 处理成绩截图变化
    handleScreenshotChange(screenshots) {
      this.gradeScreenshots = screenshots
      // 提取URL列表
      this.gradeScreenshotUrls = screenshots.map(item => item.url)
      console.log('成绩截图已更新:', screenshots)
      console.log('成绩截图URLs:', this.gradeScreenshotUrls)
    },

    // 更新维度分数
    updateDimensionScore(dimension) {
      const dimensionAchievements = this.achievements[dimension]
      const totalScore = dimensionAchievements.reduce((sum, achievement) => {
        return sum + (achievement.score || 0)
      }, 0)

      // 使用 Vue.set 确保响应式更新
      this.$set(this.scoreOverview[dimension], 'score', totalScore)
      console.log(`[SubmissionForm] 更新${dimension}维度分数: ${totalScore}`)
    },

    // 更新所有分数
    updateAllScores() {
      Object.keys(this.achievements).forEach(dimension => {
        this.updateDimensionScore(dimension)
      })
    },

    // 检查并自动保存草稿
    async checkAndAutoSaveDraft() {
      // 检查基本信息是否完整
      if (this.formData.academicYear &&
          this.formData.semester &&
          this.formData.classId &&
          !this.submissionId && // 只在没有submissionId时创建
          !this.isViewMode) { // 非查看模式

        // 延迟执行，避免频繁调用
        if (this.autoSaveTimer) {
          clearTimeout(this.autoSaveTimer)
        }

        this.autoSaveTimer = setTimeout(() => {
          this.autoSaveDraft()
        }, 1000) // 1秒后执行
      }
    },

    // 自动保存草稿到后端
    async autoSaveDraft() {
      try {
        console.log('开始自动保存草稿...')

        const submissionData = this.buildSubmissionData(0) // 0-草稿状态

        const response = await createSubmission(submissionData)

        if (response.code === 200 && response.data && response.data.id) {
          this.submissionId = response.data.id
          this.formData.id = response.data.id

          this.$message.success('基本信息已自动保存')
          console.log('自动保存草稿成功，submissionId:', this.submissionId)
        }
      } catch (error) {
        console.error('自动保存草稿失败:', error)
        // 不显示错误提示，避免打扰用户
      }
    },

    // 保存草稿到本地缓存（保留原有功能）
    async saveDraft() {
      if (!await this.validateForm()) {
        return
      }

      this.saving = true
      try {
        const submissionData = this.buildSubmissionData(0) // 0-草稿状态

        // 生成草稿缓存key（加入用户维度，避免跨账号污染）
        const userKey = (this.$store && this.$store.getters) ? (this.$store.getters.userId || this.$store.getters.name || 'anon') : 'anon'
        const draftKey = `evaluationSubmissionDraft_${userKey}_${this.formData.academicYear}_${this.formData.semester}_${this.formData.classId || 'new'}`

        // 保存草稿数据到本地缓存
        const draftData = {
          ...submissionData,
          timestamp: Date.now(),
          achievements: this.achievements // 保存成果数据
        }

        this.$cache.local.setJSON(draftKey, draftData)
        this.$message.success('草稿已保存到本地')

        console.log('草稿保存成功:', draftKey)
      } catch (error) {
        console.error('保存草稿失败:', error)
        this.$message.error('保存草稿失败')
      } finally {
        this.saving = false
      }
    },

    // 提交审核
    async submitForAudit() {
      if (!await this.validateForm()) {
        return
      }

      if (!await this.validateAchievements()) {
        return
      }

      this.submitting = true
      try {
        const submissionData = this.buildSubmissionData(1) // 1-待审核状态
        
        let response
        if (this.formData.id) {
          response = await updateSubmission(submissionData)
        } else {
          response = await createSubmission(submissionData)
        }

        if (response.code === 200) {
          this.$message.success('提交成功，等待审核')

          // 添加空值检查，防止undefined对象访问错误
          if (response.data && response.data.id) {
            this.formData.id = response.data.id
            // 设置submissionId，用于成绩截图上传
            this.submissionId = response.data.id
          } else {
            console.warn('响应数据中缺少id字段:', response)
          }
          
          // 提交成功后清除本地草稿（父组件与子组件）
          this.clearDraftFromLocalStorage()
          const childRefs = ['moralDimension','intellectualDimension','physicalDimension','aestheticDimension','laborDimension']
          childRefs.forEach(refName => {
            const child = this.$refs[refName]
            if (child && typeof child.clearDraftFromLocalStorage === 'function') {
              try {
                child.clearDraftFromLocalStorage()
              } catch (e) {
                console.warn(`清理子组件草稿失败: ${refName}`, e)
              }
            }
          })
          
          this.$emit('submit-success', response.data || {})
        } else {
          this.$message.error(response.msg || '提交失败')
        }
      } catch (error) {
        console.error('提交审核失败:', error)
        this.$message.error('提交审核失败')
      } finally {
        this.submitting = false
      }
    },

    // 验证表单
    async validateForm() {
      try {
        await this.$refs.basicForm.validate()
        return true
      } catch (error) {
        this.$message.error('请完善基本信息')
        return false
      }
    },

    // 验证成果数据
    async validateAchievements() {
      // 检查是否至少有一个成果
      const hasAchievements = Object.values(this.achievements).some(achievements => 
        achievements.length > 0
      )

      if (!hasAchievements) {
        this.$message.error('请至少添加一个成果')
        return false
      }

      // 检查必须上传附件的规则
      for (const dimension of Object.keys(this.achievements)) {
        for (const achievement of this.achievements[dimension]) {
          if (achievement.ruleData && achievement.ruleData.requireAttachment) {
            if (!achievement.attachments || achievement.attachments.length === 0) {
              this.$message.error(`${achievement.ruleData.itemName} ${achievement.ruleData.level} 需要上传附件`)
              return false
            }
          }
        }
      }

      return true
    },

    // 构建提交数据
    buildSubmissionData(status) {
      const details = []
      
      // 收集所有维度的成果数据
      Object.keys(this.achievements).forEach(dimension => {
        this.achievements[dimension].forEach(achievement => {
          // 处理attachments字段：将字符串转换为对象数组
          let attachments = []
          if (achievement.attachments) {
            if (typeof achievement.attachments === 'string' && achievement.attachments.trim()) {
              // 如果是字符串，按逗号分割并转换为对象数组
              attachments = achievement.attachments.split(',').map(url => ({
                url: url.trim(),
                fileName: this.getFileNameFromUrl(url.trim())
              }))
            } else if (Array.isArray(achievement.attachments)) {
              // 如果已经是数组，确保格式正确
              attachments = achievement.attachments.map(item => {
                if (typeof item === 'string') {
                  return {
                    url: item,
                    fileName: this.getFileNameFromUrl(item)
                  }
                }
                return item
              })
            }
          }

          // 构建详情对象
          const detail = {
            ruleId: achievement.ruleId,
            finalScore: achievement.score,
            remark: achievement.remark,
            attachments: attachments
          }

          // 如果是课程成绩，需要添加自定义的 ruleSnapshot
          if (achievement.category === '课程成绩' && achievement.grade !== undefined) {
            // 构建包含课程成绩信息的 ruleSnapshot
            const ruleSnapshot = {
              dimensionType: 1, // 智育
              category: '课程成绩',
              itemName: achievement.itemName || achievement.courseName || '',
              courseCode: achievement.courseCode || '',
              credit: achievement.credit || 0,
              grade: achievement.grade, // 学生的实际成绩
              gradePoint: achievement.gradePoint || 0,
              level: achievement.level || '',
              score: achievement.score || 0
            }
            detail.ruleSnapshot = JSON.stringify(ruleSnapshot)
          }

          details.push(detail)
        })
      })

      const result = {
        id: this.formData.id,
        academicYear: this.formData.academicYear,
        semester: this.formData.semester,
        classId: this.formData.classId,
        status: status,
        remark: this.formData.remark,
        details: details,
        gradeScreenshotUrls: this.gradeScreenshotUrls // 新增：成绩截图URL列表
      }

      // 如果是提交审核（status=1），添加提交时间
      if (status === 1) {
        result.submitTime = parseTime(new Date(), '{y}-{m}-{d} {h}:{i}:{s}')
      }

      return result
    },

    // 从URL中提取文件名
    getFileNameFromUrl(url) {
      if (!url) return ''
      const parts = url.split('/')
      return parts[parts.length - 1] || 'unknown'
    },

    // 本地缓存加载草稿
    loadDraftFromLocalStorage() {
      try {
        const userKey = (this.$store && this.$store.getters) ? (this.$store.getters.userId || this.$store.getters.name || 'anon') : 'anon'
        const draftKey = `evaluationSubmissionDraft_${userKey}_${this.formData.academicYear}_${this.formData.semester}_${this.formData.classId || 'new'}`
        const draftData = this.$cache.local.getJSON(draftKey)

        if (draftData) {
          // 检查草稿是否过期（3天），无时间戳视为过期
          const THREE_DAYS = 3 * 24 * 60 * 60 * 1000
          const timestamp = draftData.timestamp || 0
          const isExpired = Date.now() - timestamp > THREE_DAYS

          if (!isExpired) {
            // 恢复表单数据
            if (draftData.academicYear) this.formData.academicYear = draftData.academicYear
            if (draftData.semester) this.formData.semester = draftData.semester
            if (draftData.classId) this.formData.classId = draftData.classId
            if (draftData.remark) this.formData.remark = draftData.remark

            // 恢复成果数据
            if (draftData.achievements) {
              this.achievements = { ...this.achievements, ...draftData.achievements }
              this.updateAllScores()
            }

            this.$message.success('已恢复本地草稿数据')
            console.log('草稿加载成功:', draftKey)
          } else {
            // 清除过期草稿（3天）
            this.$cache.local.remove(draftKey)
            console.log('草稿已过期（超过3天），已清除:', draftKey)
          }
        }
      } catch (error) {
        console.warn('加载草稿失败:', error)
      }
    },

    // 清除本地草稿
    clearDraftFromLocalStorage() {
      try {
        const userKey = (this.$store && this.$store.getters) ? (this.$store.getters.userId || this.$store.getters.name || 'anon') : 'anon'
        const draftKey = `evaluationSubmissionDraft_${userKey}_${this.formData.academicYear}_${this.formData.semester}_${this.formData.classId || 'new'}`
        this.$cache.local.remove(draftKey)
        console.log('草稿已清除:', draftKey)
      } catch (error) {
        console.warn('清除草稿失败:', error)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.submission-form-container {
  padding: 20px;
  background-color: #f5f5f5;
  min-height: 100vh;
}

.header-card {
  margin-bottom: 20px;
  
  .header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    
    .title-section {
      h2 {
        margin: 0;
        color: #303133;
        font-size: 24px;
        
        i {
          margin-right: 8px;
          color: #409EFF;
        }
      }
      
      .subtitle {
        margin: 5px 0 0 0;
        color: #909399;
        font-size: 14px;
      }
    }
    
    .action-section {
      .el-button {
        margin-left: 10px;
      }
    }
  }
}

.basic-info-card {
  margin-bottom: 20px;
  
  .basic-form {
    .el-form-item {
      margin-bottom: 20px;
    }
  }
}

.achievements-card {
  margin-bottom: 20px;
  
  .dimension-tabs {
    ::v-deep .el-tabs__header {
      margin-bottom: 20px;
    }
    
    ::v-deep .el-tabs__item {
      font-size: 16px;
      font-weight: 500;
    }
    
    ::v-deep .el-tabs__content {
      padding: 0;
    }
  }
}

.screenshot-upload-card {
  margin-bottom: 20px;

  ::v-deep .el-card__header {
    background-color: #f0f9ff;
    border-bottom: 1px solid #d1e7fd;
    padding: 12px 20px;

    i {
      color: #409eff;
      margin-right: 8px;
    }

    span {
      font-weight: 600;
      color: #303133;
    }
  }
}

.score-overview-container {
  position: sticky;
  top: 20px;
}

.score-overview-panel {
  position: sticky;
  top: 20px;
}

// 响应式设计
@media (max-width: 1200px) {
  .submission-form-container {
    .el-col:last-child {
      margin-top: 20px;
    }
  }
}

@media (max-width: 768px) {
  .submission-form-container {
    padding: 10px;
    
    .header-content {
      flex-direction: column;
      align-items: flex-start;
      
      .action-section {
        margin-top: 15px;
        width: 100%;
        
        .el-button {
          width: 48%;
          margin-left: 0;
          margin-right: 4%;
          
          &:last-child {
            margin-right: 0;
          }
        }
      }
    }
  }
}
</style>