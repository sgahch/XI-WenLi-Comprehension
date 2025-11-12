<template>
  <div class="achievement-dimension">
    <!-- 添加成果按钮 -->
    <div class="add-achievement-section" v-if="!isViewMode">
      <el-button
        type="primary"
        icon="el-icon-plus"
        @click="showAddForm"
        class="add-btn"
      >
        添加{{ dimensionName }}成果
      </el-button>
      <p class="add-tip">点击添加按钮，记录您在{{ dimensionName }}方面的成果</p>
    </div>

    <!-- 添加成果表单（内联显示） -->
    <el-card
      v-if="showForm && !isViewMode"
      shadow="hover"
      class="achievement-form-card"
    >
      <div slot="header" class="form-header">
        <div class="form-title">
          <i class="el-icon-edit"></i>
          <span>添加{{ dimensionName }}成果</span>
        </div>
        <div class="form-actions">
          <el-button
            type="text"
            icon="el-icon-close"
            @click="cancelAdd"
            class="cancel-btn"
          >
            取消
          </el-button>
        </div>
      </div>

      <div class="form-content">
        <el-form :model="currentAchievement" label-width="100px">
          <!-- 项目选择 -->
          <el-form-item label="项目选择" class="rule-selector">
            <el-cascader
              v-model="currentAchievement.selectedRule"
              :options="ruleOptions"
              :props="cascaderProps"
              placeholder="请选择项目类别和等级"
              style="width: 100%"
              @change="handleCurrentRuleChange"
              clearable
              filterable
            />
          </el-form-item>

          <!-- 分数显示 -->
          <el-form-item label="得分" class="score-display">
            <el-input-number
              v-model="currentAchievement.score"
              :disabled="true"
              :precision="2"
              :min="0"
              style="width: 150px"
            />
            <span class="score-unit">分</span>
          </el-form-item>

          <!-- 备注说明 -->
          <el-form-item label="备注说明" class="remark-input">
            <el-input
              v-model="currentAchievement.remark"
              type="textarea"
              :rows="3"
              placeholder="请描述具体的成果内容、获得时间、参与情况等"
              maxlength="500"
              show-word-limit
            />
          </el-form-item>

          <!-- 附件上传 -->
          <el-form-item
            label="附件上传"
            class="attachment-upload"
            :class="{ 'required-attachment': currentAchievement.requireAttachment }"
          >
            <div class="upload-section">
              <file-upload
                v-model="currentAchievement.attachments"
                :limit="5"
                :file-size="10"
                :file-type="currentAchievement.attachmentTypes || ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']"
              />
              <div class="upload-tips">
                <p v-if="currentAchievement.requireAttachment" class="required-tip">
                  <i class="el-icon-warning"></i>
                  此项目必须上传相关证明材料
                </p>
                <p class="format-tip">
                  支持格式：{{ getFileTypeText(currentAchievement.attachmentTypes) }}，单个文件不超过10MB
                </p>
              </div>
            </div>
          </el-form-item>

          <!-- 表单操作按钮 -->
          <el-form-item class="form-buttons">
            <el-button
              type="primary"
              @click="confirmAdd"
              :disabled="!canSave || isProcessing"
              :loading="isProcessing"
            >
              <i class="el-icon-check"></i>
              保存成果
            </el-button>
            <el-button @click="cancelAdd" :disabled="isProcessing">
              <i class="el-icon-close"></i>
              取消
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <!-- 成果卡片列表 -->
    <div class="achievements-list">
      <transition-group name="achievement-card" tag="div">
        <el-card
          v-for="(achievement, index) in localAchievements"
          :key="achievement.key"
          shadow="hover"
          class="achievement-card"
        >
          <div slot="header" class="card-header">
            <div class="card-title">
              <i class="el-icon-trophy"></i>
              <span>{{ dimensionName }}成果 #{{ index + 1 }}</span>
            </div>
            <div class="card-actions" v-if="!isViewMode">
              <el-button
                type="text"
                icon="el-icon-edit"
                @click="editAchievement(index)"
                class="edit-btn"
              >
                编辑
              </el-button>
              <el-button
                type="text"
                icon="el-icon-delete"
                @click="removeAchievement(index)"
                class="delete-btn"
              >
                删除
              </el-button>
            </div>
          </div>

          <div class="card-content">
            <!-- 项目信息 -->
            <div class="achievement-info">
              <div class="info-item">
                <label>项目：</label>
                <span>{{ getAchievementRuleName(achievement) }}</span>
              </div>
              <div class="info-item">
                <label>得分：</label>
                <span class="score-value">{{ achievement.score }}分</span>
              </div>
              <div class="info-item" v-if="achievement.remark">
                <label>备注：</label>
                <span>{{ achievement.remark }}</span>
              </div>
              <div class="info-item" v-if="achievement.attachments && achievement.attachments.length > 0">
                <label>附件：</label>
                <span>{{ achievement.attachments.length }}个文件</span>
              </div>
            </div>
          </div>
        </el-card>
      </transition-group>
    </div>

    <!-- 空状态 -->
    <div v-if="localAchievements.length === 0" class="empty-state">
      <div class="empty-content">
        <i class="el-icon-document-add empty-icon"></i>
        <h3>暂无{{ dimensionName }}成果</h3>
        <p v-if="!isViewMode">点击上方"添加{{ dimensionName }}成果"按钮开始记录</p>
        <p v-else>该维度暂未填报任何成果</p>
      </div>
    </div>
  </div>
</template>

<script>
import FileUpload from '@/components/FileUpload/index.vue'

export default {
  name: 'AchievementDimension',
  components: {
    FileUpload
  },
  computed: {
    // 是否可以保存
    canSave() {
      const hasRule = this.currentAchievement.selectedRule && this.currentAchievement.selectedRule.length > 0
      const hasScore = this.currentAchievement.score > 0
      return hasRule && hasScore
    }
  },
  props: {
    // 维度标识
    dimension: {
      type: String,
      required: true
    },
    // 维度名称
    dimensionName: {
      type: String,
      required: true
    },
    // 成果数据
    achievements: {
      type: Array,
      default: () => []
    },
    // 规则选项（级联数据）
    ruleOptions: {
      type: Array,
      default: () => []
    },
    // 是否为查看模式
    isViewMode: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      // 本地成果数据
      localAchievements: [],
      // 级联选择器配置
      cascaderProps: {
        value: 'value',
        label: 'label',
        children: 'children',
        emitPath: true,
        checkStrictly: false
      },
      // 成果计数器（用于生成唯一key）
      achievementCounter: 0,
      // 表单显示状态
      showForm: false,
      // 当前编辑的成果
      currentAchievement: {
        key: null,
        ruleId: null,
        selectedRule: [],
        score: 0,
        remark: '',
        attachments: [],
        requireAttachment: false,
        attachmentTypes: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        ruleData: null
      },
      // 是否为编辑模式
      isEditing: false,
      editingIndex: -1,
      // 防止循环更新的标志位
      isInternalUpdate: false,
      // 防止重复处理的标志位
      isProcessing: false,
      // 暂停自动保存标志位
      suspendAutoSave: false
    }
  },
  created() {
    // 组件创建时生成防抖函数
    this.debouncedEmitAndSave = this.debounce(this.doEmitAndSave, 400)
  },

  watch: {
    // 监听外部传入的成果数据变化
    achievements: {
      handler(newVal) {
        if (!this.isInternalUpdate) {
          this.localAchievements = this.cloneAchievements(newVal)
        }
      },
      immediate: true,
      deep: true
    },

    // 监听本地成果数据变化，向外发送事件（使用防抖优化）
    localAchievements: {
      handler() {
        // 如果暂停自动保存，则跳过
        if (this.suspendAutoSave) return
        // 使用防抖函数，避免频繁触发
        this.debouncedEmitAndSave()
      },
      deep: true
    },

    // 监听当前编辑的成果变化，自动保存草稿
    currentAchievement: {
      handler(newVal) {
        if (this.showForm && newVal) {
          this.saveDraftToLocalStorage()
        }
      },
      deep: true
    }
  },
  mounted() {
    // 恢复localStorage中的草稿数据
    this.loadDraftFromLocalStorage()
  },
  methods: {
    // 克隆成果数据
    cloneAchievements(achievements) {
      return achievements.map((achievement, index) => {
        // 确保 attachmentTypes 是数组
        let attachmentTypes = achievement.attachmentTypes || ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
        if (typeof attachmentTypes === 'string') {
          attachmentTypes = attachmentTypes.split(',').map(t => t.trim().toLowerCase())
        }
        if (!Array.isArray(attachmentTypes)) {
          attachmentTypes = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
        }

        return {
          ...achievement,
          key: achievement.key || `${this.dimension}_${Date.now()}_${index}`,
          selectedRule: achievement.selectedRule || [],
          score: achievement.score || 0,
          remark: achievement.remark || '',
          attachments: achievement.attachments || [],
          requireAttachment: achievement.requireAttachment || false,
          attachmentTypes: attachmentTypes
        }
      })
    },

    // 显示添加表单
    showAddForm() {
      this.resetCurrentAchievement()
      this.isEditing = false
      this.editingIndex = -1
      this.showForm = true
    },

    // 取消添加/编辑
    cancelAdd() {
      this.showForm = false
      this.resetCurrentAchievement()
      this.isEditing = false
      this.editingIndex = -1
    },

    // 防抖函数实现
    debounce(fn, delay = 300) {
      let timer = null
      return function(...args) {
        clearTimeout(timer)
        timer = setTimeout(() => fn.apply(this, args), delay)
      }
    },

    // 执行emit和保存操作
    doEmitAndSave() {
      this.isInternalUpdate = true
      this.$nextTick(() => {
        this.$emit('achievement-change', this.dimension, this.localAchievements)
        this.$emit('score-change', this.dimension)
        this.isInternalUpdate = false
      })
      // 保存草稿（不需要等待DOM更新）
      this.saveDraftToLocalStorage()
    },

    // 确认添加/保存
    async confirmAdd() {
      if (!this.canSave) {
        this.$message.warning('请完善成果信息')
        return
      }

      // 防止重复点击
      if (this.isProcessing) {
        this.$message.warning('请勿重复点击，系统正在处理中...')
        return
      }

      this.isProcessing = true

      try {
        if (this.isEditing) {
          // 编辑模式：添加防御性检查
          if (!this.localAchievements || !Array.isArray(this.localAchievements)) {
            throw new Error('成果数组未初始化')
          }
          
          if (this.editingIndex < 0 || this.editingIndex >= this.localAchievements.length) {
            throw new Error('编辑索引无效')
          }
          
          const targetAchievement = this.localAchievements[this.editingIndex]
          if (!targetAchievement || typeof targetAchievement !== 'object') {
            throw new Error('目标成果对象无效')
          }
      
          // 使用Object.assign就地更新，避免替换整个对象引用
          Object.assign(targetAchievement, {
            ...this.currentAchievement,
            key: this.currentAchievement.key || targetAchievement.key || `${this.dimension}_${Date.now()}_${this.achievementCounter++}`
          })
          this.$message.success('成果更新成功')
        } else {
          // 添加模式：添加新成果
          if (!this.localAchievements || !Array.isArray(this.localAchievements)) {
            this.localAchievements = []
          }
          
          const newAchievement = {
            ...this.currentAchievement,
            key: `${this.dimension || 'unknown'}_${Date.now()}_${this.achievementCounter++}`
          }
          
          // 暂时禁用自动保存，避免频繁触发
          this.suspendAutoSave = true
          this.localAchievements.push(newAchievement)
          
          // 等待Vue完成DOM更新后恢复并手动触发一次保存
          await this.$nextTick()
          this.suspendAutoSave = false
          this.doEmitAndSave()
          
          this.$message.success('成果添加成功')
        }

        // 延迟关闭弹窗，避免信息闪烁
        setTimeout(() => this.cancelAdd(), 200)
      } catch (err) {
        console.error('保存成果出错：', err)
        this.$message.error(`保存时出现错误：${err.message || '请稍后再试'}`)
      } finally {
        // 立即重置状态，避免界面卡死
        this.isProcessing = false
      }
    },

    // 编辑成果
    editAchievement(index) {
      const achievement = this.localAchievements[index]
      this.currentAchievement = { ...achievement }
      this.isEditing = true
      this.editingIndex = index
      this.showForm = true
    },

    // 重置当前成果对象
    resetCurrentAchievement() {
      this.currentAchievement = {
        key: null,
        ruleId: null,
        selectedRule: [],
        score: 0,
        remark: '',
        attachments: [],
        requireAttachment: false,
        attachmentTypes: ['PDF', 'JPG', 'PNG', 'DOC', 'DOCX'],
        ruleData: null
      }
    },

    // 处理当前成果规则选择变化
    handleCurrentRuleChange(selectedPath) {
      console.log('[AchievementDimension] 规则选择变化, selectedPath:', selectedPath)

      if (!selectedPath || selectedPath.length === 0) {
        // 清空选择
        this.currentAchievement.ruleId = null
        this.currentAchievement.score = 0
        this.currentAchievement.requireAttachment = false
        this.currentAchievement.attachmentTypes = ['PDF', 'JPG', 'PNG', 'DOC', 'DOCX']
        this.currentAchievement.ruleData = null
        this.currentAchievement.category = ''
        this.currentAchievement.itemName = ''
        this.currentAchievement.level = ''
        console.log('[AchievementDimension] 清空规则选择')
        return
      }

      // 从 selectedPath 提取 category 和 itemName
      const category = selectedPath[0] || ''
      const itemName = selectedPath[1] || ''
      console.log('[AchievementDimension] 提取的 category:', category)
      console.log('[AchievementDimension] 提取的 itemName:', itemName)

      // 根据选择路径找到对应的规则数据
      const ruleData = this.findRuleData(selectedPath)
      console.log('[AchievementDimension] 找到的ruleData:', ruleData)

      if (ruleData) {
        // 解析ruleId
        let parsedRuleId = null
        if (ruleData.ruleId) {
          parsedRuleId = ruleData.ruleId
        } else if (ruleData.value && typeof ruleData.value === 'string') {
          const parts = ruleData.value.split("_")
          const lastPart = parts[parts.length - 1]
          parsedRuleId = parseInt(lastPart)
        }

        // 使用解析出来的数值ruleId，而不是完整的ID字符串
        this.currentAchievement.ruleId = parsedRuleId || null
        this.currentAchievement.score = ruleData.score || 0
        this.currentAchievement.requireAttachment = ruleData.requireAttachment || false

        // 确保 attachmentTypes 是数组
        let attachmentTypes = ruleData.attachmentTypes || ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
        if (typeof attachmentTypes === 'string') {
          attachmentTypes = attachmentTypes.split(',').map(t => t.trim().toLowerCase())
        }
        this.currentAchievement.attachmentTypes = Array.isArray(attachmentTypes) ? attachmentTypes : ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']

        this.currentAchievement.ruleData = ruleData.ruleData || ruleData

        // 🔥 关键修复：保存 category 和 itemName
        this.currentAchievement.category = category
        this.currentAchievement.itemName = itemName
        this.currentAchievement.level = ruleData.ruleData?.level || ruleData.label || ''

        console.log('[AchievementDimension] 设置成果数据:')
        console.log('  - ruleId:', this.currentAchievement.ruleId)
        console.log('  - score:', this.currentAchievement.score)
        console.log('  - requireAttachment:', this.currentAchievement.requireAttachment)
        console.log('  - category:', this.currentAchievement.category)
        console.log('  - itemName:', this.currentAchievement.itemName)
        console.log('  - canSave:', this.canSave)
      } else {
        console.warn('[AchievementDimension] 未找到ruleData，selectedPath:', selectedPath)
      }
    },

    // 获取成果规则名称
    getAchievementRuleName(achievement) {
      if (!achievement.selectedRule || achievement.selectedRule.length === 0) {
        return '未选择项目'
      }

      const ruleData = this.findRuleData(achievement.selectedRule)
      return ruleData ? ruleData.label : '未知项目'
    },

    // 添加成果（保留原方法以兼容）
    addAchievement() {
      this.showAddForm()
    },

    // 删除成果
    removeAchievement(index) {
      this.$confirm('确定要删除这个成果吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.localAchievements.splice(index, 1)
        this.$message.success('删除成功')
      }).catch(() => {
        // 用户取消删除
      })
    },

    // 处理规则选择变化
     // 处理规则选择变化
     handleRuleChange(index, selectedPath) {
       const achievement = this.localAchievements[index]

       if (!selectedPath || selectedPath.length === 0) {
         // 清空选择
         achievement.ruleId = null
         achievement.score = 0
         achievement.requireAttachment = false
         achievement.attachmentTypes = ['PDF', 'JPG', 'PNG', 'DOC', 'DOCX']
         achievement.ruleData = null
         achievement.category = ''
         achievement.itemName = ''
         achievement.level = ''
         return
       }

       console.log('[AchievementDimension] handleRuleChange - selectedPath:', selectedPath)

       // 从 selectedPath 提取 category 和 itemName
       // selectedPath 格式: [category, itemName, ruleId]
       const category = selectedPath[0] || ''
       const itemName = selectedPath[1] || ''

       console.log('[AchievementDimension] 提取的 category:', category)
       console.log('[AchievementDimension] 提取的 itemName:', itemName)

       // 根据选择路径找到对应的规则数据
       const ruleData = this.findRuleData(selectedPath)
       console.log('[AchievementDimension] 找到的 ruleData:', ruleData)

       if (ruleData) {
         // 使用解析出来的数值ruleId，而不是完整的ID字符串
         achievement.ruleId = ruleData.ruleId || parseInt(ruleData.value.split("_").pop()) || null
         achievement.score = ruleData.score || 0
         achievement.requireAttachment = ruleData.requireAttachment || false

         // 确保 attachmentTypes 是数组
         let attachmentTypes = ruleData.attachmentTypes || ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
         if (typeof attachmentTypes === 'string') {
           attachmentTypes = attachmentTypes.split(',').map(t => t.trim().toLowerCase())
         }
         achievement.attachmentTypes = Array.isArray(attachmentTypes) ? attachmentTypes : ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']

         achievement.ruleData = ruleData.ruleData || ruleData

         // 🔥 关键修复：保存 category 和 itemName
         achievement.category = category
         achievement.itemName = itemName
         achievement.level = ruleData.ruleData?.level || ruleData.label || ''

         console.log('[AchievementDimension] 最终的 achievement 对象:', achievement)
       }
     },

    // 根据选择路径查找规则数据
    findRuleData(selectedPath) {
      let current = this.ruleOptions

      for (let i = 0; i < selectedPath.length; i++) {
        const value = selectedPath[i]
        const found = current.find(item => item.value === value)

        if (!found) {
          return null
        }

        if (i === selectedPath.length - 1) {
          // 最后一级，返回规则数据
          return found
        } else {
          // 继续向下查找
          current = found.children || []
        }
      }

      return null
    },

    // 获取文件类型文本
    getFileTypeText(types) {
      // 类型检查：确保 types 是数组
      if (!types) {
        return 'PDF、JPG、JPEG、PNG、DOC、DOCX'
      }

      // 如果 types 是字符串，先转换为数组
      if (typeof types === 'string') {
        types = types.split(',').map(t => t.trim())
      }

      // 如果不是数组或数组为空，返回默认值
      if (!Array.isArray(types) || types.length === 0) {
        return 'PDF、JPG、JPEG、PNG、DOC、DOCX'
      }

      return types.map(type => type.toUpperCase()).join('、')
    },

    // 验证成果数据
    validateAchievements() {
      const errors = []

      this.localAchievements.forEach((achievement, index) => {
        // 检查是否选择了规则
        if (!achievement.ruleId) {
          errors.push(`第${index + 1}个成果未选择项目`)
        }

        // 检查必须上传附件的规则
        if (achievement.requireAttachment && (!achievement.attachments || achievement.attachments.length === 0)) {
          errors.push(`第${index + 1}个成果需要上传附件`)
        }
      })

      return {
        valid: errors.length === 0,
        errors: errors
      }
    },

    // 保存草稿到localStorage（按用户+维度隔离）
    saveDraftToLocalStorage() {
      try {
        const userKey = (this.$store && this.$store.getters) ? (this.$store.getters.userId || this.$store.getters.name || 'anon') : 'anon'
        const draftKey = `evaluationDraft_${userKey}_${this.dimension}`
        const draftData = {
          localAchievements: this.localAchievements,
          currentAchievement: this.currentAchievement,
          showForm: this.showForm,
          isEditing: this.isEditing,
          editingIndex: this.editingIndex,
          timestamp: Date.now()
        }
        localStorage.setItem(draftKey, JSON.stringify(draftData))
      } catch (error) {
        console.warn('保存草稿失败:', error)
      }
    },

    // 从localStorage加载草稿（按用户+维度隔离）
    loadDraftFromLocalStorage() {
      try {
        const userKey = (this.$store && this.$store.getters) ? (this.$store.getters.userId || this.$store.getters.name || 'anon') : 'anon'
        const draftKey = `evaluationDraft_${userKey}_${this.dimension}`
        const draftData = localStorage.getItem(draftKey)

        if (draftData) {
          const parsed = JSON.parse(draftData)
          
          // 检查草稿是否过期（24小时）, 无时间戳视为过期
          const timestamp = parsed.timestamp || 0
          const isExpired = Date.now() - timestamp > 24 * 60 * 60 * 1000

          if (!isExpired && parsed.localAchievements) {
            // 恢复成果数据
            this.localAchievements = this.cloneAchievements(parsed.localAchievements)

            // 恢复表单状态，但需要验证编辑索引的有效性
            if (parsed.showForm && parsed.currentAchievement) {
              // 确保 attachmentTypes 是数组
              let attachmentTypes = parsed.currentAchievement.attachmentTypes || ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
              if (typeof attachmentTypes === 'string') {
                attachmentTypes = attachmentTypes.split(',').map(t => t.trim().toLowerCase())
              }
              if (!Array.isArray(attachmentTypes)) {
                attachmentTypes = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']
              }

              this.currentAchievement = {
                ...parsed.currentAchievement,
                attachmentTypes: attachmentTypes
              }
              this.showForm = parsed.showForm
              this.isEditing = parsed.isEditing || false
              
              // 验证编辑索引的有效性
              if (this.isEditing && parsed.editingIndex !== undefined && parsed.editingIndex !== null) {
                const editingIndex = parsed.editingIndex
                // 检查索引是否在有效范围内
                if (editingIndex >= 0 && editingIndex < this.localAchievements.length) {
                  this.editingIndex = editingIndex
                } else {
                  // 编辑索引无效，重置为添加模式
                  console.warn(`草稿中的编辑索引${editingIndex}无效，当前成果数量：${this.localAchievements.length}，已重置为添加模式`)
                  this.isEditing = false
                  this.editingIndex = -1
                }
              } else {
                this.editingIndex = parsed.editingIndex || -1
              }
            }

            console.log(`已恢复${this.dimensionName}维度的草稿数据`)
          } else if (isExpired) {
            // 清除过期草稿
            localStorage.removeItem(draftKey)
          }
        }
      } catch (error) {
        console.warn('加载草稿失败:', error)
      }
    },

    // 清除草稿（按用户+维度隔离）
    clearDraftFromLocalStorage() {
      try {
        const userKey = (this.$store && this.$store.getters) ? (this.$store.getters.userId || this.$store.getters.name || 'anon') : 'anon'
        const draftKey = `evaluationDraft_${userKey}_${this.dimension}`
        localStorage.removeItem(draftKey)
      } catch (error) {
        console.warn('清除草稿失败:', error)
      }
    },

    // 提交审核成功后的回调
    onSubmitSuccess() {
      // 提交成功后清除草稿
      this.clearDraftFromLocalStorage()
      this.$message.success('提交成功，草稿已清除')
    }
  }
}
</script>

<style lang="scss" scoped>
.achievement-dimension {
  .add-achievement-section {
    text-align: center;
    padding: 30px 20px;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    border-radius: 8px;
    margin-bottom: 20px;

    .add-btn {
      font-size: 16px;
      padding: 12px 30px;
      border-radius: 25px;
      box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);

      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(64, 158, 255, 0.4);
      }
    }

    .add-tip {
      margin: 15px 0 0 0;
      color: #606266;
      font-size: 14px;
    }
  }

  // 添加表单样式
  .achievement-form-card {
    margin-bottom: 20px;
    border: 2px dashed #409EFF;

    .form-header {
      display: flex;
      justify-content: space-between;
      align-items: center;

      .form-title {
        display: flex;
        align-items: center;
        font-weight: 600;
        color: #409EFF;

        i {
          margin-right: 8px;
          font-size: 16px;
        }
      }

      .cancel-btn {
        color: #909399;

        &:hover {
          color: #f56c6c;
        }
      }
    }

    .form-content {
      .form-buttons {
        text-align: center;
        margin-top: 20px;

        .el-button {
          margin: 0 10px;
        }
      }
    }
  }

  .achievements-list {
    .achievement-card {
      margin-bottom: 20px;
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.3s ease;

      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
      }

      .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 20px;
        margin: -20px -20px 20px -20px;

        .card-title {
          display: flex;
          align-items: center;
          font-weight: 600;
          font-size: 16px;

          i {
            margin-right: 8px;
            font-size: 18px;
          }
        }

        .delete-btn {
          color: white;

          &:hover {
            color: #f56c6c;
          }
        }
      }

      .card-content {
        .el-form-item {
          margin-bottom: 20px;

          &.rule-selector {
            ::v-deep .el-cascader {
              .el-input__inner {
                border-radius: 6px;
              }
            }
          }

          &.score-display {
            display: flex;
            align-items: center;

            .score-unit {
              margin-left: 10px;
              color: #409EFF;
              font-weight: 600;
            }
          }

          &.required-attachment {
            .el-form-item__label::before {
              content: '*';
              color: #f56c6c;
              margin-right: 4px;
            }
          }
        }

        .upload-section {
          .upload-tips {
            margin-top: 10px;

            .required-tip {
              color: #f56c6c;
              font-size: 13px;
              margin: 5px 0;

              i {
                margin-right: 4px;
              }
            }

            .format-tip {
              color: #909399;
              font-size: 12px;
              margin: 5px 0 0 0;
            }
          }
        }
      }
    }
  }

  .empty-state {
    text-align: center;
    padding: 60px 20px;

    .empty-content {
      .empty-icon {
        font-size: 64px;
        color: #dcdfe6;
        margin-bottom: 20px;
      }

      h3 {
        color: #909399;
        font-weight: 400;
        margin: 0 0 10px 0;
      }

      p {
        color: #c0c4cc;
        margin: 0;
        font-size: 14px;
      }
    }
  }
}

// 动画效果
.achievement-card-enter-active,
.achievement-card-leave-active {
  transition: all 0.3s ease;
}

.achievement-card-enter {
  opacity: 0;
  transform: translateY(30px);
}

.achievement-card-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

// 响应式设计
@media (max-width: 768px) {
  .achievement-dimension {
    .add-achievement-section {
      padding: 20px 15px;

      .add-btn {
        width: 100%;
        font-size: 14px;
        padding: 10px 20px;
      }
    }

    .achievements-list {
      .achievement-card {
        .card-header {
          padding: 12px 15px;
          margin: -15px -15px 15px -15px;

          .card-title {
            font-size: 14px;
          }
        }

        .card-content {
          .achievement-info {
            .info-item {
              display: flex;
              margin-bottom: 12px;
              align-items: flex-start;

              label {
                min-width: 60px;
                color: #606266;
                font-weight: 500;
                margin-right: 10px;
              }

              span {
                flex: 1;
                color: #303133;

                &.score-value {
                  color: #409EFF;
                  font-weight: 600;
                }
              }
            }
          }

          .score-display {
            flex-direction: column;
            align-items: flex-start;

            .score-unit {
              margin-left: 0;
              margin-top: 5px;
            }
          }
        }
      }
    }
  }
}
</style>
