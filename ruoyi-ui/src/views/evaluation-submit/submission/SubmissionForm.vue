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
                  <el-select 
                    v-model="formData.classId" 
                    placeholder="请选择班级"
                    :disabled="isViewMode"
                    style="width: 100%"
                  >
                    <el-option
                      v-for="cls in classOptions"
                      :key="cls.id"
                      :label="cls.name"
                      :value="cls.id"
                    />
                  </el-select>
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
              <achievement-dimension
                ref="intellectualDimension"
                dimension="intellectual"
                dimension-name="智育"
                :achievements="achievements.intellectual"
                :rule-options="ruleOptions.intellectual"
                :is-view-mode="isViewMode"
                @achievement-change="handleAchievementChange"
                @score-change="updateDimensionScore"
              />
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
import ScoreOverview from './components/ScoreOverview.vue'
import { getRuleTree, createSubmission, updateSubmission, getSubmissionDetail } from '@/api/evaluation/submission'
import { listDept } from '@/api/system/dept'

export default {
  name: 'SubmissionForm',
  components: {
    AchievementDimension,
    ScoreOverview
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
      submitting: false
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

    // 加载班级选项
    async loadClassOptions() {
      try {
        // 从store获取用户信息
        const userInfo = this.$store.getters.userInfo
        
        // 模拟班级数据，实际应该根据用户权限获取可管理的班级
        // 这里假设用户可以管理多个班级，格式为：软件工程2401, 软件工程2402等
        // 只显示班级编号部分（如2401, 2402）
        const mockClasses = [
          { id: 200, name: '2401', fullName: '软件工程2401' },
          { id: 201, name: '2402', fullName: '软件工程2402' },
          { id: 202, name: '2403', fullName: '软件工程2403' },
          { id: 203, name: '2401', fullName: '计算机科学2401' },
          { id: 204, name: '2402', fullName: '计算机科学2402' }
        ]
        
        this.classOptions = mockClasses
        
        // 如果用户有默认班级，自动选中
        if (userInfo && userInfo.deptId) {
          // 这里可以根据用户的部门ID匹配对应的班级
          // 暂时设置第一个班级为默认值
          if (!this.formData.classId && mockClasses.length > 0) {
            this.formData.classId = mockClasses[0].id
          }
        }
      } catch (error) {
        console.error('加载班级选项失败:', error)
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
            // 从id字段解析生成ruleId，用于临时兼容后端未修改的情况
            ruleId: parseInt(level.id.split("_").pop()) || null
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

    // 更新维度分数
    updateDimensionScore(dimension) {
      const dimensionAchievements = this.achievements[dimension]
      const totalScore = dimensionAchievements.reduce((sum, achievement) => {
        return sum + (achievement.score || 0)
      }, 0)
      
      this.scoreOverview[dimension].score = totalScore
    },

    // 更新所有分数
    updateAllScores() {
      Object.keys(this.achievements).forEach(dimension => {
        this.updateDimensionScore(dimension)
      })
    },

    // 保存草稿到本地缓存
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
          
          details.push({
            ruleId: achievement.ruleId,
            finalScore: achievement.score,
            remark: achievement.remark,
            attachments: attachments
          })
        })
      })

      return {
        id: this.formData.id,
        academicYear: this.formData.academicYear,
        semester: this.formData.semester,
        classId: this.formData.classId,
        status: status,
        remark: this.formData.remark,
        details: details
      }
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
          // 检查草稿是否过期（24小时），无时间戳视为过期
          const timestamp = draftData.timestamp || 0
          const isExpired = Date.now() - timestamp > 24 * 60 * 60 * 1000
          
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
            // 清除过期草稿
            this.$cache.local.remove(draftKey)
            console.log('草稿已过期，已清除:', draftKey)
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