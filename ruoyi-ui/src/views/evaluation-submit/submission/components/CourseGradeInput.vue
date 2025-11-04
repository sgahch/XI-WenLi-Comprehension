<template>
  <div class="course-grade-input">
    <!-- 添加课程按钮 -->
    <el-button
      v-if="!isViewMode"
      type="primary"
      icon="el-icon-plus"
      size="small"
      @click="handleAddCourse"
    >
      添加课程成绩
    </el-button>

    <!-- 课程成绩表格 -->
    <el-table
      v-if="courseList.length > 0"
      :data="courseList"
      border
      style="margin-top: 15px;"
    >
      <el-table-column label="序号" type="index" width="60" align="center" />
      
      <el-table-column label="课程名称" min-width="150">
        <template slot-scope="scope">
          <el-select
            v-if="!isViewMode && scope.row.editing"
            v-model="scope.row.ruleId"
            placeholder="请选择课程"
            filterable
            @change="handleCourseChange(scope.row)"
          >
            <el-option
              v-for="rule in courseOptions"
              :key="rule.id"
              :label="rule.itemName"
              :value="rule.id"
            >
              <span>{{ rule.itemName }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px; margin-left: 15px;">
                {{ rule.level }} ({{ rule.score }}分)
              </span>
            </el-option>
          </el-select>
          <span v-else>{{ scope.row.courseName }}</span>
        </template>
      </el-table-column>

      <el-table-column label="成绩" width="120" align="center">
        <template slot-scope="scope">
          <el-input-number
            v-if="!isViewMode && scope.row.editing"
            v-model="scope.row.grade"
            :min="0"
            :max="100"
            :precision="1"
            size="small"
            controls-position="right"
            @change="handleGradeChange(scope.row)"
          />
          <span v-else>{{ scope.row.grade }}</span>
        </template>
      </el-table-column>

      <el-table-column label="等级" width="120" align="center">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.level" :type="getLevelTagType(scope.row.level)" size="small">
            {{ scope.row.level }}
          </el-tag>
          <span v-else>—</span>
        </template>
      </el-table-column>

      <el-table-column label="加分" width="100" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.score > 0 ? 'success' : 'info'" size="medium">
            {{ scope.row.score || 0 }}分
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="备注" min-width="150">
        <template slot-scope="scope">
          <el-input
            v-if="!isViewMode && scope.row.editing"
            v-model="scope.row.remark"
            placeholder="选填"
            size="small"
            maxlength="100"
          />
          <span v-else>{{ scope.row.remark || '—' }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作" width="150" fixed="right" align="center">
        <template slot-scope="scope">
          <el-button
            v-if="!isViewMode && scope.row.editing"
            type="success"
            size="mini"
            icon="el-icon-check"
            @click="handleSaveCourse(scope.row, scope.$index)"
          >
            保存
          </el-button>
          <el-button
            v-if="!isViewMode && !scope.row.editing"
            type="text"
            size="small"
            icon="el-icon-edit"
            @click="handleEditCourse(scope.row)"
          >
            编辑
          </el-button>
          <el-button
            v-if="!isViewMode"
            type="text"
            size="small"
            icon="el-icon-delete"
            style="color: #F56C6C;"
            @click="handleDeleteCourse(scope.$index)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 空状态提示 -->
    <el-empty
      v-if="courseList.length === 0"
      description="暂无课程成绩，请点击上方按钮添加"
      :image-size="100"
    />

    <!-- 总分统计 -->
    <div v-if="courseList.length > 0" class="score-summary">
      <span>课程成绩总加分：</span>
      <el-tag type="success" size="medium" effect="dark">{{ totalScore.toFixed(2) }}分</el-tag>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CourseGradeInput',
  props: {
    // 成果列表（包含课程成绩）
    achievements: {
      type: Array,
      default: () => []
    },
    // 规则选项（所有智育规则）
    ruleOptions: {
      type: Array,
      default: () => []
    },
    // 是否查看模式
    isViewMode: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      courseList: [],
      isInternalUpdate: false // 标记是否是内部更新，避免循环
    }
  },
  computed: {
    // 过滤出课程成绩规则
    courseOptions() {
      return this.ruleOptions.filter(rule => rule.category === '课程成绩')
    },
    // 计算总分
    totalScore() {
      return this.courseList.reduce((sum, course) => sum + (parseFloat(course.score) || 0), 0)
    },
    // 生成 achievements 的指纹，用于检测真实变化
    achievementsFingerprint() {
      return this.achievements.map(a =>
        `${a.ruleId}-${a.grade}-${a.score}-${a.level}`
      ).join('|')
    }
  },
  watch: {
    // 监听指纹变化，而不是直接监听数组
    achievementsFingerprint: {
      handler(newFingerprint, oldFingerprint) {
        if (newFingerprint !== oldFingerprint) {
          console.log('[CourseGradeInput] 检测到 achievements 真实变化，重新加载')
          this.loadCourseList(this.achievements)
        }
      },
      immediate: true
    }
  },
  methods: {
    // 加载课程列表
    loadCourseList(achievements) {
      console.log('[CourseGradeInput] 重新加载课程列表')

      // 保存当前正在编辑的项
      const editingItems = this.courseList.filter(item => item.editing)

      // 过滤出课程成绩类型的成果
      const newCourses = achievements.filter(a => a.category === '课程成绩')

      // 更新课程列表
      this.courseList = newCourses.map(a => {
        // 检查是否是正在编辑的项
        const editingItem = editingItems.find(e =>
          (e.ruleId && e.ruleId === a.ruleId) ||
          (e.courseName && e.courseName === a.courseName)
        )

        return {
          ...a,
          editing: editingItem ? true : false,
          grade: a.grade || null
        }
      })

      // 添加新的正在编辑的项（ruleId为null的）
      editingItems.forEach(editingItem => {
        if (!editingItem.ruleId && !editingItem.courseName) {
          this.courseList.push(editingItem)
        }
      })

      console.log('[CourseGradeInput] 课程列表已更新，共', this.courseList.length, '项')
    },

    // 添加课程
    handleAddCourse() {
      this.courseList.push({
        ruleId: null,
        courseName: '',
        category: '课程成绩',
        grade: null,
        level: '',
        score: 0,
        remark: '',
        editing: true
      })
    },

    // 课程选择变更
    handleCourseChange(row) {
      const rule = this.ruleOptions.find(r => r.id === row.ruleId)
      if (rule) {
        row.courseName = rule.itemName
        row.itemName = rule.itemName // 用于提交
        row.category = rule.category
        row.courseCode = rule.courseCode || rule.itemCode || ''
        row.credit = rule.credit || 0
        row.gradePoint = rule.gradePoint || 0
        console.log('[CourseGradeInput] 选择课程:', rule)

        // 如果已经输入了成绩，自动计算加分
        if (row.grade !== null) {
          this.calculateScore(row)
        }
      }
      // 注意：不在这里调用emitChange，等用户点击保存按钮时再同步
    },

    // 成绩变更
    handleGradeChange(row) {
      console.log('[CourseGradeInput] 成绩变更:', row.grade)
      this.calculateScore(row)
      // 注意：不在这里调用emitChange，等用户点击保存按钮时再同步
    },

    // 计算加分
    calculateScore(row) {
      if (!row.ruleId || row.grade === null) {
        row.score = 0
        row.level = ''
        return
      }

      // 根据成绩匹配规则
      const matchedRule = this.findMatchingRule(row.courseName, row.grade)
      if (matchedRule) {
        row.score = matchedRule.score
        row.level = matchedRule.level
        row.ruleId = matchedRule.id // 更新为匹配的规则ID
        console.log('[CourseGradeInput] 匹配到规则:', matchedRule)
      } else {
        row.score = 0
        row.level = '未达标'
        console.log('[CourseGradeInput] 未匹配到规则，成绩未达标')
      }
    },

    // 查找匹配的规则
    findMatchingRule(courseName, grade) {
      // 获取该课程的所有等级规则
      const rules = this.courseOptions.filter(r => r.itemName === courseName)

      if (rules.length === 0) {
        console.warn('[CourseGradeInput] 未找到课程规则:', courseName)
        return null
      }

      // 按分数从高到低排序
      rules.sort((a, b) => {
        const aMin = this.extractMinGrade(a.level)
        const bMin = this.extractMinGrade(b.level)
        return bMin - aMin
      })

      // 找到第一个满足条件的规则
      for (const rule of rules) {
        const minGrade = this.extractMinGrade(rule.level)
        const maxGrade = this.extractMaxGrade(rule.level)

        if (maxGrade !== null) {
          // 有上限的区间，例如 "85-89分"
          if (grade >= minGrade && grade <= maxGrade) {
            console.log(`[CourseGradeInput] 匹配规则: ${courseName} ${grade}分 -> ${rule.level} (${rule.score}分)`)
            return rule
          }
        } else {
          // 无上限的区间，例如 "90分以上"
          if (grade >= minGrade) {
            console.log(`[CourseGradeInput] 匹配规则: ${courseName} ${grade}分 -> ${rule.level} (${rule.score}分)`)
            return rule
          }
        }
      }

      console.log(`[CourseGradeInput] 未匹配到规则: ${courseName} ${grade}分`)
      return null
    },

    // 从等级描述中提取最低分数
    extractMinGrade(level) {
      if (!level) return 0
      // 匹配 "90分以上"、"85-89分"、"80分及以上" 等格式
      const match = level.match(/(\d+)/)
      return match ? parseInt(match[1]) : 0
    },

    // 从等级描述中提取最高分数
    extractMaxGrade(level) {
      if (!level) return null
      // 匹配 "85-89分" 格式
      const match = level.match(/(\d+)-(\d+)/)
      return match ? parseInt(match[2]) : null
    },

    // 保存课程
    handleSaveCourse(row, index) {
      if (!row.ruleId) {
        this.$message.warning('请选择课程')
        return
      }
      if (row.grade === null || row.grade === '') {
        this.$message.warning('请输入成绩')
        return
      }

      row.editing = false
      this.emitChange()
      this.$message.success('保存成功')
    },

    // 编辑课程
    handleEditCourse(row) {
      row.editing = true
    },

    // 删除课程
    handleDeleteCourse(index) {
      this.$confirm('确定删除该课程成绩吗？', '提示', {
        type: 'warning'
      }).then(() => {
        this.courseList.splice(index, 1)
        this.emitChange()
        this.$message.success('删除成功')
      }).catch(() => {})
    },

    // 触发变更事件
    emitChange() {
      console.log('[CourseGradeInput] 触发变更事件, 课程列表:', this.courseList)
      this.$emit('achievement-change', 'intellectual', this.courseList)
      this.$emit('score-change', 'intellectual', this.totalScore)
    },

    // 获取等级标签类型
    getLevelTagType(level) {
      if (level.includes('90') || level.includes('以上')) {
        return 'success'
      } else if (level.includes('85') || level.includes('80')) {
        return 'warning'
      } else if (level === '未达标') {
        return 'info'
      }
      return ''
    }
  }
}
</script>

<style scoped>
.course-grade-input {
  padding: 15px;
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
</style>

