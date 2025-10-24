<template>
  <div class="dimension-score-panel">
    <el-card shadow="never" class="panel-card">
      <div slot="header" class="panel-header">
        <div class="header-left">
          <i :class="icon" :style="{ color: color }"></i>
          <span class="title">{{ title }}评分</span>
          <span class="subtitle">{{ title }} Assessment</span>
        </div>
        <div class="header-right">
          <div class="total-score" :style="{ color: color }">
            <span class="label">总分：</span>
            <span class="value">{{ totalScore.toFixed(2) }}</span>
          </div>
        </div>
      </div>

      <div class="panel-content">
        <!-- 评分项目列表 -->
        <div class="score-items">
          <div
            v-for="(item, index) in configItems"
            :key="item.id"
            class="score-item"
          >
            <div class="item-header">
              <div class="item-info">
                <span class="item-name">{{ item.itemName }}</span>
                <span class="item-code">{{ item.itemCode }}</span>
                <el-tooltip v-if="item.description" :content="item.description" placement="top">
                  <i class="el-icon-question"></i>
                </el-tooltip>
              </div>
              <div class="item-score-info">
                <span class="score-range">{{ item.minScore }} - {{ item.maxScore }}分</span>
                <span class="weight" v-if="item.weight">
                  权重: {{ (item.weight * 100).toFixed(1) }}%
                </span>
              </div>
            </div>

            <div class="item-content">
              <!-- 评分类型：数值输入 -->
              <div v-if="item.scoreType === 'number'" class="score-input-section">
                <el-input-number
                  v-model="detailScores[item.id]"
                  :min="item.minScore"
                  :max="item.maxScore"
                  :precision="2"
                  :step="0.1"
                  :disabled="isViewMode"
                  @change="handleScoreChange(item.id, $event)"
                  class="score-input"
                />
                <span class="unit">分</span>
              </div>

              <!-- 评分类型：选择 -->
              <div v-else-if="item.scoreType === 'select'" class="score-select-section">
                <el-select
                  v-model="detailScores[item.id]"
                  :disabled="isViewMode"
                  @change="handleScoreChange(item.id, $event)"
                  placeholder="请选择"
                  style="width: 200px"
                >
                  <el-option
                    v-for="option in parseScoreOptions(item.scoreOptions)"
                    :key="option.value"
                    :label="option.label"
                    :value="option.value"
                  />
                </el-select>
              </div>

              <!-- 评分类型：等级 -->
              <div v-else-if="item.scoreType === 'grade'" class="score-grade-section">
                <el-radio-group
                  v-model="detailScores[item.id]"
                  :disabled="isViewMode"
                  @change="handleScoreChange(item.id, $event)"
                >
                  <el-radio
                    v-for="option in parseScoreOptions(item.scoreOptions)"
                    :key="option.value"
                    :label="option.value"
                    class="grade-radio"
                  >
                    {{ option.label }}
                  </el-radio>
                </el-radio-group>
              </div>

              <!-- 评分类型：布尔 -->
              <div v-else-if="item.scoreType === 'boolean'" class="score-boolean-section">
                <el-switch
                  v-model="detailScores[item.id]"
                  :disabled="isViewMode"
                  :active-value="item.maxScore"
                  :inactive-value="item.minScore"
                  :active-text="`是 (${item.maxScore}分)`"
                  :inactive-text="`否 (${item.minScore}分)`"
                  @change="handleScoreChange(item.id, $event)"
                />
              </div>

              <!-- 附加说明输入 -->
              <div v-if="!isViewMode || detailRemarks[item.id]" class="remark-section">
                <el-input
                  v-model="detailRemarks[item.id]"
                  type="textarea"
                  :rows="2"
                  :disabled="isViewMode"
                  placeholder="请输入相关说明或证明材料..."
                  maxlength="500"
                  show-word-limit
                  @input="handleRemarkChange(item.id, $event)"
                />
              </div>
            </div>

            <!-- 必填标识 -->
            <div v-if="item.isRequired" class="required-mark">
              <el-tag type="danger" size="mini">必填</el-tag>
            </div>
          </div>
        </div>

        <!-- 自定义加分项 -->
        <div class="custom-items" v-if="!isViewMode">
          <div class="section-title">
            <span>自定义加分项</span>
            <el-button
              type="text"
              icon="el-icon-plus"
              @click="addCustomItem"
              :disabled="isViewMode"
            >
              添加
            </el-button>
          </div>

          <div
            v-for="(customItem, index) in customItems"
            :key="'custom-' + index"
            class="custom-item"
          >
            <el-row :gutter="10">
              <el-col :span="8">
                <el-input
                  v-model="customItem.name"
                  placeholder="加分项名称"
                  :disabled="isViewMode"
                  @input="handleCustomItemChange"
                />
              </el-col>
              <el-col :span="4">
                <el-input-number
                  v-model="customItem.score"
                  :min="0"
                  :max="20"
                  :precision="2"
                  :disabled="isViewMode"
                  @change="handleCustomItemChange"
                />
              </el-col>
              <el-col :span="8">
                <el-input
                  v-model="customItem.remark"
                  placeholder="说明"
                  :disabled="isViewMode"
                  @input="handleCustomItemChange"
                />
              </el-col>
              <el-col :span="4">
                <el-button
                  type="text"
                  icon="el-icon-delete"
                  @click="removeCustomItem(index)"
                  :disabled="isViewMode"
                />
              </el-col>
            </el-row>
            <!-- 附件上传 -->
            <el-row :gutter="10" style="margin-top:8px">
              <el-col :span="24">
                <FileUpload
                  v-model="customItem.attachment"
                  :limit="3"
                  :fileSize="10"
                  :disabled="isViewMode"
                  :fileType="['doc','docx','xls','xlsx','ppt','pptx','txt','pdf','jpg','jpeg','png']"
                />
              </el-col>
            </el-row>
          </div>
        </div>

        <!-- 维度总分统计 -->
        <div class="score-summary">
          <el-row :gutter="20">
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">基础分：</span>
                <span class="value">{{ baseScore.toFixed(2) }}</span>
              </div>
            </el-col>
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">加分：</span>
                <span class="value bonus">+{{ bonusScore.toFixed(2) }}</span>
              </div>
            </el-col>
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">扣分：</span>
                <span class="value penalty">{{ penaltyScore.toFixed(2) }}</span>
              </div>
            </el-col>
            <el-col :span="6">
              <div class="summary-item total">
                <span class="label">总分：</span>
                <span class="value" :style="{ color: color }">{{ totalScore.toFixed(2) }}</span>
              </div>
            </el-col>
          </el-row>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import FileUpload from '@/components/FileUpload/index.vue'
export default {
  name: 'DimensionScorePanel',
  components: { FileUpload },
  props: {
    dimension: { type: String, required: true },
    title: { type: String, required: true },
    icon: { type: String, default: 'el-icon-star-on' },
    color: { type: String, default: '#409EFF' },
    scoreData: { type: Number, default: 0 },
    detailItems: { type: Array, default: () => [] },
    configItems: { type: Array, default: () => [] },
    isViewMode: { type: Boolean, default: false }
  },
  data() {
    return {
      detailScores: {},
      detailRemarks: {},
      customItems: [],
      isInitialized: false, // 标记是否已初始化
      lastDetailItems: [] // 保存上次的detailItems用于比较
    }
  },
  computed: {
    baseScore() {
      return this.configItems.reduce((sum, item) => {
        const score = this.detailScores[item.id] || 0
        return item.scoreType !== 'bonus' ? sum + score * (item.weight || 1) : sum
      }, 0)
    },
    bonusScore() {
      let total = 0
      this.configItems.forEach(item => {
        if (item.scoreType === 'bonus') {
          const score = this.detailScores[item.id] || 0
          total += score * (item.weight || 1)
        }
      })
      this.customItems.forEach(item => {
        if (item.score > 0) total += item.score
      })
      return total
    },
    penaltyScore() {
      return this.customItems.reduce((sum, item) => item.score < 0 ? sum + item.score : sum, 0)
    },
    totalScore() {
      return Math.max(0, this.baseScore + this.bonusScore + this.penaltyScore)
    }
  },
  watch: {
    detailItems: {
      handler(val) {
        // 只在初始化时或者detailItems真正变化时才重新初始化
        // 避免因为父组件的configItems变化导致不必要的重置
        if (!this.isInitialized || this.shouldReinitialize(val)) {
          this.initDetailData(val)
          this.isInitialized = true
        }
      },
      immediate: true,
      deep: true
    },
    totalScore(val) {
      this.$emit('score-change', this.dimension, val)
    }
  },
  methods: {
    // 判断是否需要重新初始化数据
    shouldReinitialize(newItems) {
      if (!newItems || !this.lastDetailItems) return true
      
      // 比较配置项数量和内容，只有真正变化时才重新初始化
      const newConfigItems = newItems.filter(item => item.type !== 'custom')
      const oldConfigItems = this.lastDetailItems.filter(item => item.type !== 'custom')
      
      if (newConfigItems.length !== oldConfigItems.length) return true
      
      // 检查配置项是否有实质性变化
      for (let i = 0; i < newConfigItems.length; i++) {
        const newItem = newConfigItems[i]
        const oldItem = oldConfigItems[i]
        if (newItem.itemId !== oldItem.itemId || newItem.itemName !== oldItem.itemName) {
          return true
        }
      }
      
      return false
    },
    
    initDetailData(items) {
      // 保存当前的customItems，避免被覆盖
      const currentCustomItems = [...this.customItems]
      
      this.detailScores = {}
      this.detailRemarks = {}
      
      // 只重置customItems如果这是真正的初始化
      if (!this.isInitialized) {
        this.$set(this, 'customItems', [])
      }

      if (!items) {
        this.lastDetailItems = []
        return
      }
      
      items.forEach(item => {
        if (item.type === 'custom') {
          // 只在初始化时添加custom项，避免重复添加
          if (!this.isInitialized) {
            this.customItems.push({ ...item })
          }
        } else if (item.itemId) {
          this.$set(this.detailScores, item.itemId, item.score || 0)
          this.$set(this.detailRemarks, item.itemId, item.remark || '')
        }
      })
      
      // 如果不是初始化，恢复customItems
      if (this.isInitialized && currentCustomItems.length > 0) {
        this.$set(this, 'customItems', currentCustomItems)
      }
      
      this.lastDetailItems = items ? [...items] : []
    },
    handleScoreChange(id, score) {
      this.$set(this.detailScores, id, score || 0)
      this.emitDetailChange()
    },
    handleRemarkChange(id, remark) {
      this.$set(this.detailRemarks, id, remark || '')
      this.emitDetailChange()
    },
    addCustomItem() {
      console.log('添加自定义加分项被点击', this.isViewMode, this.customItems.length)
      const newItem = { 
        name: '', 
        score: 0, 
        remark: '', 
        attachment: '' 
      }
      this.customItems.push(newItem)
      // 强制触发响应式更新
      this.$forceUpdate()
      console.log('添加后的customItems:', this.customItems)
      this.handleCustomItemChange()
    },
    removeCustomItem(i) {
      this.customItems.splice(i, 1)
      this.$forceUpdate()
      this.handleCustomItemChange()
    },
    handleCustomItemChange() {
      this.emitDetailChange()
    },
    emitDetailChange() {
      const details = [
        ...this.configItems.map(item => ({
          itemId: item.id,
          itemCode: item.itemCode,
          itemName: item.itemName,
          score: this.detailScores[item.id] || 0,
          remark: this.detailRemarks[item.id] || '',
          type: 'config'
        })),
        ...this.customItems.filter(i => i.name && i.score !== 0).map(i => ({
          ...i,
          type: 'custom'
        }))
      ]
      this.$emit('detail-change', this.dimension, details)
    },
    parseScoreOptions(str) {
      if (!str) return []
      try {
        if (str.startsWith('[') || str.startsWith('{')) return JSON.parse(str)
        return str.split(',').map(s => {
          const [label, val] = s.split(':')
          return { label: label.trim(), value: parseFloat(val) }
        })
      } catch (e) {
        console.warn('解析评分选项失败:', e)
        return []
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.dimension-score-panel {
  .panel-card {
    border-radius: 8px;
    overflow: hidden;
  }
}
</style>
