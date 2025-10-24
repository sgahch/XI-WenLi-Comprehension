<template>
  <div class="enhanced-submission-form">
    <el-card shadow="never" class="form-card">
      <div slot="header" class="card-header">
        <h3><i class="el-icon-edit-outline"></i> 综合测评填报表单</h3>
        <span class="subtitle">Comprehensive Assessment Submission Form</span>
      </div>

      <el-form
        :model="formData"
        :rules="rules"
        ref="submissionForm"
        label-width="120px"
        class="submission-form"
      >
        <!-- 基本信息 -->
        <el-card shadow="never" class="section-card">
          <div slot="header" class="section-header">
            <i class="el-icon-user"></i>
            <span>基本信息</span>
          </div>

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
                  placeholder="选择学期"
                  :disabled="isViewMode"
                  style="width: 100%"
                >
                  <el-option label="第一学期" :value="1" />
                  <el-option label="第二学期" :value="2" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="班级" prop="className">
                <el-input
                  v-model="formData.className"
                  placeholder="班级名称"
                  :disabled="isViewMode"
                />
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>

        <!-- 德智体美劳五个维度 -->
        <el-tabs v-model="activeTab" type="card" class="dimension-tabs">
          <!-- 德育 -->
          <el-tab-pane label="德育" name="moral">
            <!-- 内联表单：德育 -->
            <el-form :inline="true" class="inline-extra-form" v-if="!isViewMode">
              <el-form-item label="事项">
                <el-input v-model="formData.moralExtra.activityName" placeholder="活动/事项名称" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="日期">
                <el-date-picker v-model="formData.moralExtra.date" type="date" placeholder="选择日期" :disabled="isViewMode" style="width: 180px" />
              </el-form-item>
              <el-form-item label="组织">
                <el-input v-model="formData.moralExtra.organization" placeholder="组织/主办方" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="地点">
                <el-input v-model="formData.moralExtra.location" placeholder="地点" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="备注">
                <el-input v-model="formData.moralExtra.description" placeholder="备注说明" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="附件">
                <FileUpload v-model="formData.moralExtra.attachment" :limit="3" :fileSize="10" :disabled="isViewMode" />
              </el-form-item>
            </el-form>
            <dimension-score-panel
              ref="moralPanel"
              :dimension="'moral'"
              :title="'德育'"
              :icon="'el-icon-star-on'"
              :color="'#e74c3c'"
              :score-data="formData.moralScore"
              :detail-items="formData.moralDetails"
              :config-items="configItems.moral"
              :is-view-mode="isViewMode"
              @score-change="handleScoreChange"
              @detail-change="handleDetailChange"
            />
          </el-tab-pane>

          <!-- 智育 -->
          <el-tab-pane label="智育" name="intellectual">
            <!-- 内联表单：智育 -->
            <el-form :inline="true" class="inline-extra-form" v-if="!isViewMode">
              <el-form-item label="事项">
                <el-input v-model="formData.intellectualExtra.activityName" placeholder="活动/事项名称" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="日期">
                <el-date-picker v-model="formData.intellectualExtra.date" type="date" placeholder="选择日期" :disabled="isViewMode" style="width: 180px" />
              </el-form-item>
              <el-form-item label="组织">
                <el-input v-model="formData.intellectualExtra.organization" placeholder="组织/主办方" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="地点">
                <el-input v-model="formData.intellectualExtra.location" placeholder="地点" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="备注">
                <el-input v-model="formData.intellectualExtra.description" placeholder="备注说明" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="附件">
                <FileUpload v-model="formData.intellectualExtra.attachment" :limit="3" :fileSize="10" :disabled="isViewMode" />
              </el-form-item>
            </el-form>
            <dimension-score-panel
              ref="intellectualPanel"
              :dimension="'intellectual'"
              :title="'智育'"
              :icon="'el-icon-reading'"
              :color="'#3498db'"
              :score-data="formData.intellectualScore"
              :detail-items="formData.intellectualDetails"
              :config-items="configItems.intellectual"
              :is-view-mode="isViewMode"
              @score-change="handleScoreChange"
              @detail-change="handleDetailChange"
            />
          </el-tab-pane>

          <!-- 体育 -->
          <el-tab-pane label="体育" name="physical">
            <!-- 内联表单：体育 -->
            <el-form :inline="true" class="inline-extra-form" v-if="!isViewMode">
              <el-form-item label="事项">
                <el-input v-model="formData.physicalExtra.activityName" placeholder="活动/事项名称" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="日期">
                <el-date-picker v-model="formData.physicalExtra.date" type="date" placeholder="选择日期" :disabled="isViewMode" style="width: 180px" />
              </el-form-item>
              <el-form-item label="组织">
                <el-input v-model="formData.physicalExtra.organization" placeholder="组织/主办方" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="地点">
                <el-input v-model="formData.physicalExtra.location" placeholder="地点" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="备注">
                <el-input v-model="formData.physicalExtra.description" placeholder="备注说明" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="附件">
                <FileUpload v-model="formData.physicalExtra.attachment" :limit="3" :fileSize="10" :disabled="isViewMode" />
              </el-form-item>
            </el-form>
            <dimension-score-panel
              ref="physicalPanel"
              :dimension="'physical'"
              :title="'体育'"
              :icon="'el-icon-trophy'"
              :color="'#27ae60'"
              :score-data="formData.physicalScore"
              :detail-items="formData.physicalDetails"
              :config-items="configItems.physical"
              :is-view-mode="isViewMode"
              @score-change="handleScoreChange"
              @detail-change="handleDetailChange"
            />
          </el-tab-pane>

          <!-- 美育 -->
          <el-tab-pane label="美育" name="aesthetic">
            <!-- 内联表单：美育 -->
            <el-form :inline="true" class="inline-extra-form" v-if="!isViewMode">
              <el-form-item label="事项">
                <el-input v-model="formData.aestheticExtra.activityName" placeholder="活动/事项名称" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="日期">
                <el-date-picker v-model="formData.aestheticExtra.date" type="date" placeholder="选择日期" :disabled="isViewMode" style="width: 180px" />
              </el-form-item>
              <el-form-item label="组织">
                <el-input v-model="formData.aestheticExtra.organization" placeholder="组织/主办方" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="地点">
                <el-input v-model="formData.aestheticExtra.location" placeholder="地点" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="备注">
                <el-input v-model="formData.aestheticExtra.description" placeholder="备注说明" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="附件">
                <FileUpload v-model="formData.aestheticExtra.attachment" :limit="3" :fileSize="10" :disabled="isViewMode" />
              </el-form-item>
            </el-form>
            <dimension-score-panel
              ref="aestheticPanel"
              :dimension="'aesthetic'"
              :title="'美育'"
              :icon="'el-icon-picture-outline'"
              :color="'#9b59b6'"
              :score-data="formData.aestheticScore"
              :detail-items="formData.aestheticDetails"
              :config-items="configItems.aesthetic"
              :is-view-mode="isViewMode"
              @score-change="handleScoreChange"
              @detail-change="handleDetailChange"
            />
          </el-tab-pane>

          <!-- 劳育 -->
          <el-tab-pane label="劳育" name="labor">
            <!-- 内联表单：劳育 -->
            <el-form :inline="true" class="inline-extra-form" v-if="!isViewMode">
              <el-form-item label="事项">
                <el-input v-model="formData.laborExtra.activityName" placeholder="活动/事项名称" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="日期">
                <el-date-picker v-model="formData.laborExtra.date" type="date" placeholder="选择日期" :disabled="isViewMode" style="width: 180px" />
              </el-form-item>
              <el-form-item label="组织">
                <el-input v-model="formData.laborExtra.organization" placeholder="组织/主办方" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="地点">
                <el-input v-model="formData.laborExtra.location" placeholder="地点" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="备注">
                <el-input v-model="formData.laborExtra.description" placeholder="备注说明" :disabled="isViewMode" />
              </el-form-item>
              <el-form-item label="附件">
                <FileUpload v-model="formData.laborExtra.attachment" :limit="3" :fileSize="10" :disabled="isViewMode" />
              </el-form-item>
            </el-form>
            <dimension-score-panel
              ref="laborPanel"
              :dimension="'labor'"
              :title="'劳育'"
              :icon="'el-icon-s-tools'"
              :color="'#f39c12'"
              :score-data="formData.laborScore"
              :detail-items="formData.laborDetails"
              :config-items="configItems.labor"
              :is-view-mode="isViewMode"
              @score-change="handleScoreChange"
              @detail-change="handleDetailChange"
            />
          </el-tab-pane>
        </el-tabs>

        <!-- 综合成绩汇总 -->
        <el-card shadow="never" class="summary-card">
          <div slot="header" class="section-header">
            <i class="el-icon-data-analysis"></i>
            <span>综合成绩汇总</span>
          </div>

          <el-row :gutter="20" class="score-summary">
            <el-col :span="4" v-for="(item, key) in scoreSummary" :key="key">
              <div class="score-item" :style="{ borderColor: item.color, cursor: 'pointer' }" @click="activeTab = key">
                <div class="score-label">{{ item.label }}</div>
                <div class="score-value" :style="{ color: item.color }">
                  {{ item.score.toFixed(2) }}
                </div>
                <div class="score-rank" v-if="item.rank">
                  排名: {{ item.rank }}
                </div>
              </div>
            </el-col>
            <el-col :span="4">
              <div class="score-item total-score">
                <div class="score-label">综合成绩</div>
                <div class="score-value">{{ totalScore.toFixed(2) }}</div>
                <div class="score-rank" v-if="totalRank">
                  总排名: {{ totalRank }}
                </div>
              </div>
            </el-col>
          </el-row>
        </el-card>

        <!-- 操作按钮 -->
        <div class="form-actions" v-if="!isViewMode">
          <el-button @click="handleReset">重置</el-button>
          <el-button type="info" @click="handleSaveDraft">保存草稿</el-button>
          <el-button type="primary" @click="handleSubmit">提交审核</el-button>
          <el-button type="success" @click="handleCalculateScore">计算成绩</el-button>
        </div>
      </el-form>
    </el-card>

    <!-- 成绩趋势图表 -->
    <score-trend-chart
      v-if="showTrendChart"
      :student-id="formData.studentId"
      :academic-year="formData.academicYear"
      class="trend-chart-section"
    />
  </div>
</template>

<script>
import DimensionScorePanel from './components/DimensionScorePanel.vue'
import ScoreTrendChart from './components/ScoreTrendChart.vue'
import FileUpload from '@/components/FileUpload/index.vue'
import {
  getSemesterScoreDetail,
  addSemesterScoreDetail,
  updateSemesterScoreDetail,
  getEvaluationItemConfig
} from '@/api/evaluation/semesterScore'
import { parseTime } from '@/utils/ruoyi'

export default {
  name: 'EnhancedSubmissionForm',
  components: {
    DimensionScorePanel,
    ScoreTrendChart,
    FileUpload
  },
  props: {
    // 表单模式：add-新增, edit-编辑, view-查看
    mode: {
      type: String,
      default: 'add'
    },
    // 学生ID（编辑和查看模式需要）
    studentId: {
      type: String,
      default: null
    },
    // 记录ID（编辑和查看模式需要）
    recordId: {
      type: String,
      default: null
    }
  },
  data() {
    return {
      activeTab: 'moral',
      formData: {
        studentId: '',
        studentName: '',
        academicYear: '',
        semester: null,
        className: '',
        majorName: '',
        // 各维度成绩
        moralScore: 0,
        intellectualScore: 0,
        physicalScore: 0,
        aestheticScore: 0,
        laborScore: 0,
        // 各维度详细项目得分
        moralDetails: [],
        intellectualDetails: [],
        physicalDetails: [],
        aestheticDetails: [],
        laborDetails: [],
        // 各维度内联表单信息
        moralExtra: { activityName: '', date: '', organization: '', location: '', description: '', attachment: '' },
        intellectualExtra: { activityName: '', date: '', organization: '', location: '', description: '', attachment: '' },
        physicalExtra: { activityName: '', date: '', organization: '', location: '', description: '', attachment: '' },
        aestheticExtra: { activityName: '', date: '', organization: '', location: '', description: '', attachment: '' },
        laborExtra: { activityName: '', date: '', organization: '', location: '', description: '', attachment: '' },
        // 排名信息
        classRank: null,
        majorRank: null,
        comprehensiveScore: 0
      },
      // ✅ 新增：学年选项
      academicYearOptions: [],

      // ✅ 新增：学期选项
      semesterOptions: [
        { label: '第一学期', value: 1 },
        { label: '第二学期', value: 2 }
      ],

      // 配置项目
      configItems: {
        moral: [],
        intellectual: [],
        physical: [],
        aesthetic: [],
        labor: []
      },
      // 表单验证规则
      rules: {
        academicYear: [
          { required: true, message: '请选择学年', trigger: 'change' },
          { pattern: /^\d{4}-\d{4}$/, message: '格式应为 2024-2025', trigger: 'change' }
        ],
        semester: [
          { required: true, message: '请选择学期', trigger: 'change' }
        ],
        className: [
          { required: true, message: '请输入班级名称', trigger: 'blur' }
        ]
      },
      showTrendChart: false
    }
  },
  computed: {
    isViewMode() {
      return this.mode === 'view'
    },
    // 成绩汇总
    scoreSummary() {
      return {
        moral: {
          label: '德育',
          score: this.formData.moralScore,
          rank: this.formData.moralRank,
          color: '#e74c3c'
        },
        intellectual: {
          label: '智育',
          score: this.formData.intellectualScore,
          rank: this.formData.intellectualRank,
          color: '#3498db'
        },
        physical: {
          label: '体育',
          score: this.formData.physicalScore,
          rank: this.formData.physicalRank,
          color: '#27ae60'
        },
        aesthetic: {
          label: '美育',
          score: this.formData.aestheticScore,
          rank: this.formData.aestheticRank,
          color: '#9b59b6'
        },
        labor: {
          label: '劳育',
          score: this.formData.laborScore,
          rank: this.formData.laborRank,
          color: '#f39c12'
        }
      }
    },
    // 总成绩
    totalScore() {
      return this.formData.comprehensiveScore || 0
    },
    // 总排名
    totalRank() {
      return this.formData.classRank
    }
  },
  created() {
    this.academicYearOptions = this.generateAcademicYears()
    this.initForm()
    this.loadConfigItems()
  },
  methods: {
    // 初始化表单
    async initForm() {
      if (this.mode === 'edit' || this.mode === 'view') {
        if (this.recordId) {
          await this.loadFormData()
        }
      }
      // 获取当前用户信息
      this.getCurrentUserInfo()
    },
    generateAcademicYears() {
      const years = [];
      const currentYear = new Date().getFullYear();
      for (let i = 0; i < 5; i++) {
        const start = currentYear - i;
        const end = start + 1;
        years.push(`${start}-${end}`);
      }
      return years;
    },

    // 加载表单数据
    async loadFormData() {
      try {
        const response = await getSemesterScoreDetail(this.recordId)
        if (response.code === 200) {
          this.formData = { ...this.formData, ...response.data }
          // 解析各维度详细项目得分（后端字段为独立JSON字符串）
          const d = response.data || {}
          try { this.formData.moralDetails = d.moralDetails ? JSON.parse(d.moralDetails) : [] } catch (e) { this.formData.moralDetails = [] }
          try { this.formData.intellectualDetails = d.intellectualDetails ? JSON.parse(d.intellectualDetails) : [] } catch (e) { this.formData.intellectualDetails = [] }
          try { this.formData.physicalDetails = d.physicalDetails ? JSON.parse(d.physicalDetails) : [] } catch (e) { this.formData.physicalDetails = [] }
          try { this.formData.aestheticDetails = d.aestheticDetails ? JSON.parse(d.aestheticDetails) : [] } catch (e) { this.formData.aestheticDetails = [] }
          try { this.formData.laborDetails = d.laborDetails ? JSON.parse(d.laborDetails) : [] } catch (e) { this.formData.laborDetails = [] }
          // 显示趋势图
          this.showTrendChart = true
        }
      } catch (error) {
        this.$modal.msgError('加载数据失败')
      }
    },

    // 加载配置项目
    async loadConfigItems() {
      try {
        const dimensions = ['moral', 'intellectual', 'physical', 'aesthetic', 'labor']
        for (const dimension of dimensions) {
          const response = await getEvaluationItemConfig({ dimensionType: dimension, status: '1' })
          if (response.code === 200) {
            this.configItems[dimension] = response.rows || []
          }
        }
      } catch (error) {
        this.$modal.msgError('加载配置项目失败')
      }
    },

    // 获取当前用户信息
    getCurrentUserInfo() {
      // 使用 Vuex getters 获取当前用户名与昵称
      const userName = this.$store.getters.name
      const nickName = this.$store.getters.nickName || this.$store.getters.name
      if (userName) {
        this.formData.studentId = userName
      }
      if (nickName) {
        this.formData.studentName = nickName
      }
    },

    // 处理分数变化
    handleScoreChange(dimension, score) {
      this.formData[dimension + 'Score'] = score
    },

    // 处理详细项目变化
    handleDetailChange(dimension, details) {
      this.formData[dimension + 'Details'] = details
    },

    // 成绩计算 - 改为本地计算
    async handleCalculateScore() {
      try {
        this.$modal.loading('正在计算综合成绩...')

        // 本地计算综合成绩（各维度成绩的加权平均）
        const totalScore = (
          this.formData.moralScore * 0.2 +
          this.formData.intellectualScore * 0.3 +
          this.formData.physicalScore * 0.2 +
          this.formData.aestheticScore * 0.15 +
          this.formData.laborScore * 0.15
        ).toFixed(2)

        this.formData.comprehensiveScore = parseFloat(totalScore)

        // 注意：班级排名和专业排名需要后端批量计算，这里暂时不设置
        // 可以在提交后由后端批量计算排名
        this.formData.classRank = null
        this.formData.majorRank = null

        this.$modal.msgSuccess('成绩计算完成')
      } catch (error) {
        this.$modal.msgError('成绩计算失败')
      } finally {
        this.$modal.closeLoading()
      }
    },

    // 保存草稿
    async handleSaveDraft() {
      try {
        await this.validateForm()
        const formData = this.buildSubmitData()
        formData.status = 0 // 草稿
        let response
        if (this.mode === 'add') {
          response = await addSemesterScoreDetail(formData)
        } else {
          response = await updateSemesterScoreDetail(formData)
        }
        if (response.code === 200) {
          this.$modal.msgSuccess('草稿保存成功')
          this.$emit('success', response.data)
        }
      } catch (error) {
        // 验证失败或其他错误
      }
    },

    // 提交审核
    async handleSubmit() {
      try {
        await this.validateForm()
        // 自定义加分项校验：加分项必须上传证明材料
        const dimensions = ['moral','intellectual','physical','aesthetic','labor']
        const missingProof = dimensions.some(dim => {
          const items = this.formData[dim + 'Details'] || []
          return items.some(d => d.type === 'custom' && d.score > 0 && (!d.attachment || d.attachment.length === 0))
        })
        if (missingProof) {
          this.$modal.msgError('自定义加分项需上传证明材料后才能提交')
          return
        }
        const formData = this.buildSubmitData()
        formData.status = 1 // 已提交
        formData.submitTime = parseTime(new Date(), '{y}-{m}-{d} {h}:{i}:{s}')
        let response
        if (this.mode === 'add') {
          response = await addSemesterScoreDetail(formData)
        } else {
          response = await updateSemesterScoreDetail(formData)
        }
        if (response.code === 200) {
          this.$modal.msgSuccess('提交成功，等待审核')
          this.$emit('success', response.data)
        }
      } catch (error) {
        // 验证失败或其他错误
      }
    },

    // 表单验证
    validateForm() {
      return new Promise((resolve, reject) => {
        this.$refs.submissionForm.validate((valid) => {
          if (valid) {
            resolve()
          } else {
            this.$modal.msgError('请完善表单信息')
            reject()
          }
        })
      })
    },

    // 构建提交数据
    buildSubmitData() {
      return {
        ...this.formData,
        // 维度详细项目得分分别映射到后端字段
        moralDetails: JSON.stringify(this.formData.moralDetails || []),
        intellectualDetails: JSON.stringify(this.formData.intellectualDetails || []),
        physicalDetails: JSON.stringify(this.formData.physicalDetails || []),
        aestheticDetails: JSON.stringify(this.formData.aestheticDetails || []),
        laborDetails: JSON.stringify(this.formData.laborDetails || []),
        // 各维度内联表单信息（可选）
        moralExtra: JSON.stringify(this.formData.moralExtra || {}),
        intellectualExtra: JSON.stringify(this.formData.intellectualExtra || {}),
        physicalExtra: JSON.stringify(this.formData.physicalExtra || {}),
        aestheticExtra: JSON.stringify(this.formData.aestheticExtra || {}),
        laborExtra: JSON.stringify(this.formData.laborExtra || {}),
        // 综合成绩映射到后端 totalScore
        totalScore: this.formData.comprehensiveScore || 0
      }
    },

    // 重置表单
    handleReset() {
      this.$refs.submissionForm.resetFields()
      // 重置各维度详细数据
      Object.keys(this.configItems).forEach(dimension => {
        this.formData[dimension + 'Details'] = []
        this.formData[dimension + 'Score'] = 0
      })
      this.formData.comprehensiveScore = 0
    }
  }
}
</script>

<style lang="scss" scoped>
.enhanced-submission-form {
  .form-card {
    margin-bottom: 20px;

    .card-header {
      h3 {
        margin: 0;
        color: #303133;
        font-size: 18px;

        i {
          margin-right: 8px;
          color: #409EFF;
        }
      }

      .subtitle {
        color: #909399;
        font-size: 12px;
        margin-left: 26px;
      }
    }
  }

  .section-card {
    margin-bottom: 20px;
    border: 1px solid #EBEEF5;

    .section-header {
      display: flex;
      align-items: center;
      font-weight: 600;
      color: #303133;

      i {
        margin-right: 8px;
        color: #409EFF;
      }
    }
  }

  .dimension-tabs {
    margin: 20px 0;

    ::v-deep .el-tabs__header {
      margin-bottom: 20px;
    }

    ::v-deep .el-tabs__item {
      font-weight: 600;

      &.is-active {
        color: #409EFF;
      }
    }
  }

  .summary-card {
    margin: 20px 0;

    .score-summary {
      .score-item {
        text-align: center;
        padding: 20px;
        border: 2px solid #E4E7ED;
        border-radius: 8px;
        transition: all 0.3s;

        &:hover {
          box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
        }

        &.total-score {
          border-color: #409EFF;
          background: linear-gradient(135deg, #409EFF 0%, #67C23A 100%);
          color: white;

          .score-label, .score-value, .score-rank {
            color: white;
          }
        }

        .score-label {
          font-size: 14px;
          color: #606266;
          margin-bottom: 8px;
        }

        .score-value {
          font-size: 24px;
          font-weight: bold;
          margin-bottom: 4px;
        }

        .score-rank {
          font-size: 12px;
          color: #909399;
        }
      }
    }
  }

  .form-actions {
    text-align: center;
    padding: 20px 0;
    border-top: 1px solid #EBEEF5;
    margin-top: 20px;

    .el-button {
      margin: 0 10px;
      min-width: 100px;
    }
  }

  .trend-chart-section {
    margin-top: 20px;
  }
}
</style>
