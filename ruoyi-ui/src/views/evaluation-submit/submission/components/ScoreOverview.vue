<template>
  <div class="score-overview">
    <el-card shadow="always" class="overview-card">
      <div slot="header" class="card-header">
        <div class="header-content">
          <i class="el-icon-data-analysis"></i>
          <span>分数总览</span>
        </div>
      </div>

      <!-- 总分显示 -->
      <div class="total-score-section">
        <div class="total-score">
          <span class="score-label">总分</span>
          <span class="score-value">{{ totalScore.toFixed(2) }}</span>
          <span class="score-unit">分</span>
        </div>
        <div class="score-progress">
          <el-progress
            :percentage="getScorePercentage(totalScore)"
            :color="getScoreColor(totalScore)"
            :stroke-width="8"
            :show-text="false"
          />
        </div>
      </div>

      <!-- 各维度分数 -->
      <div class="dimension-scores">
        <div 
          v-for="(scoreData, dimension) in scores" 
          :key="dimension"
          class="dimension-item"
        >
          <div class="dimension-header">
            <div class="dimension-info">
              <span class="dimension-name">{{ scoreData.name }}</span>
              <span class="dimension-score">{{ scoreData.score.toFixed(2) }}分</span>
            </div>
            <div class="dimension-indicator" :style="{ backgroundColor: scoreData.color }"></div>
          </div>
          
          <div class="dimension-progress">
            <el-progress
              :percentage="getScorePercentage(scoreData.score)"
              :color="scoreData.color"
              :stroke-width="6"
              :show-text="false"
            />
          </div>
        </div>
      </div>

      <!-- 分数统计 -->
      <div class="score-statistics">
        <div class="stat-item">
          <span class="stat-label">最高单项</span>
          <span class="stat-value">{{ getHighestScore().toFixed(2) }}分</span>
        </div>
        <div class="stat-item">
          <span class="stat-label">平均分</span>
          <span class="stat-value">{{ getAverageScore().toFixed(2) }}分</span>
        </div>
        <div class="stat-item">
          <span class="stat-label">已填维度</span>
          <span class="stat-value">{{ getFilledDimensions() }}/5</span>
        </div>
      </div>

      <!-- 分数等级 -->
      <div class="score-grade">
        <div class="grade-info">
          <span class="grade-label">当前等级</span>
          <span class="grade-value" :class="getGradeClass()">{{ getScoreGrade() }}</span>
        </div>
        <div class="grade-description">
          {{ getGradeDescription() }}
        </div>
      </div>

      <!-- 提升建议 -->
      <div class="improvement-suggestions" v-if="getImprovementSuggestions().length > 0">
        <div class="suggestions-header">
          <i class="el-icon-lightbulb"></i>
          <span>提升建议</span>
        </div>
        <ul class="suggestions-list">
          <li 
            v-for="(suggestion, index) in getImprovementSuggestions()" 
            :key="index"
            class="suggestion-item"
          >
            {{ suggestion }}
          </li>
        </ul>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'ScoreOverview',
  props: {
    // 各维度分数数据
    scores: {
      type: Object,
      default: () => ({
        moral: { name: '德育', score: 0, color: '#e74c3c' },
        intellectual: { name: '智育', score: 0, color: '#3498db' },
        physical: { name: '体育', score: 0, color: '#27ae60' },
        aesthetic: { name: '美育', score: 0, color: '#9b59b6' },
        labor: { name: '劳育', score: 0, color: '#f39c12' }
      })
    },
    // 总分
    totalScore: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      // 分数等级配置
      gradeConfig: [
        { min: 90, grade: '优秀', class: 'excellent', description: '表现卓越，全面发展' },
        { min: 80, grade: '良好', class: 'good', description: '表现良好，继续保持' },
        { min: 70, grade: '中等', class: 'average', description: '表现一般，有提升空间' },
        { min: 60, grade: '及格', class: 'pass', description: '达到基本要求' },
        { min: 0, grade: '待提升', class: 'poor', description: '需要努力提升' }
      ]
    }
  },
  methods: {
    // 获取分数百分比（用于进度条）
    getScorePercentage(score) {
      // 假设满分为100分
      const maxScore = 100
      return Math.min((score / maxScore) * 100, 100)
    },

    // 获取分数对应的颜色
    getScoreColor(score) {
      if (score >= 90) return '#67c23a'
      if (score >= 80) return '#409eff'
      if (score >= 70) return '#e6a23c'
      if (score >= 60) return '#f56c6c'
      return '#909399'
    },

    // 获取最高单项分数
    getHighestScore() {
      const scores = Object.values(this.scores).map(item => item.score)
      return Math.max(...scores, 0)
    },

    // 获取平均分
    getAverageScore() {
      const scores = Object.values(this.scores).map(item => item.score)
      const total = scores.reduce((sum, score) => sum + score, 0)
      return scores.length > 0 ? total / scores.length : 0
    },

    // 获取已填写的维度数量
    getFilledDimensions() {
      return Object.values(this.scores).filter(item => item.score > 0).length
    },

    // 获取分数等级
    getScoreGrade() {
      for (const config of this.gradeConfig) {
        if (this.totalScore >= config.min) {
          return config.grade
        }
      }
      return '待提升'
    },

    // 获取等级样式类
    getGradeClass() {
      for (const config of this.gradeConfig) {
        if (this.totalScore >= config.min) {
          return config.class
        }
      }
      return 'poor'
    },

    // 获取等级描述
    getGradeDescription() {
      for (const config of this.gradeConfig) {
        if (this.totalScore >= config.min) {
          return config.description
        }
      }
      return '需要努力提升'
    },

    // 获取提升建议
    getImprovementSuggestions() {
      const suggestions = []
      
      // 检查各维度分数，给出建议
      Object.entries(this.scores).forEach(([dimension, data]) => {
        if (data.score === 0) {
          suggestions.push(`建议在${data.name}方面添加相关成果`)
        } else if (data.score < 15) {
          suggestions.push(`${data.name}分数较低，可以寻找更多相关活动参与`)
        }
      })

      // 总分建议
      if (this.totalScore < 60) {
        suggestions.push('总分偏低，建议积极参与各类活动提升综合素质')
      } else if (this.totalScore < 80) {
        suggestions.push('继续努力，争取在薄弱维度上有所突破')
      }

      // 平衡发展建议
      const scores = Object.values(this.scores).map(item => item.score)
      const maxScore = Math.max(...scores)
      const minScore = Math.min(...scores.filter(s => s > 0))
      
      if (maxScore - minScore > 20) {
        suggestions.push('建议注重全面发展，平衡各维度表现')
      }

      return suggestions.slice(0, 3) // 最多显示3条建议
    }
  }
}
</script>

<style lang="scss" scoped>
.score-overview {
  .overview-card {
    border-radius: 12px;
    overflow: hidden;
    
    .card-header {
      .header-content {
        display: flex;
        align-items: center;
        font-weight: 600;
        font-size: 16px;
        color: #303133;
        
        i {
          margin-right: 8px;
          font-size: 18px;
          color: #409EFF;
        }
      }
    }
  }

  .total-score-section {
    text-align: center;
    padding: 20px 0;
    border-bottom: 1px solid #f0f0f0;
    margin-bottom: 20px;
    
    .total-score {
      margin-bottom: 15px;
      
      .score-label {
        display: block;
        font-size: 14px;
        color: #909399;
        margin-bottom: 5px;
      }
      
      .score-value {
        font-size: 36px;
        font-weight: 700;
        color: #303133;
        margin-right: 5px;
      }
      
      .score-unit {
        font-size: 16px;
        color: #606266;
      }
    }
  }

  .dimension-scores {
    margin-bottom: 20px;
    
    .dimension-item {
      margin-bottom: 15px;
      
      &:last-child {
        margin-bottom: 0;
      }
      
      .dimension-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 8px;
        
        .dimension-info {
          display: flex;
          justify-content: space-between;
          align-items: center;
          flex: 1;
          
          .dimension-name {
            font-size: 14px;
            color: #606266;
          }
          
          .dimension-score {
            font-size: 14px;
            font-weight: 600;
            color: #303133;
          }
        }
        
        .dimension-indicator {
          width: 12px;
          height: 12px;
          border-radius: 50%;
          margin-left: 10px;
        }
      }
    }
  }

  .score-statistics {
    padding: 15px 0;
    border-top: 1px solid #f0f0f0;
    border-bottom: 1px solid #f0f0f0;
    margin-bottom: 20px;
    
    .stat-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
      
      &:last-child {
        margin-bottom: 0;
      }
      
      .stat-label {
        font-size: 13px;
        color: #909399;
      }
      
      .stat-value {
        font-size: 13px;
        font-weight: 600;
        color: #303133;
      }
    }
  }

  .score-grade {
    text-align: center;
    margin-bottom: 20px;
    
    .grade-info {
      margin-bottom: 8px;
      
      .grade-label {
        font-size: 14px;
        color: #909399;
        margin-right: 10px;
      }
      
      .grade-value {
        font-size: 18px;
        font-weight: 600;
        padding: 4px 12px;
        border-radius: 15px;
        
        &.excellent {
          color: #67c23a;
          background-color: rgba(103, 194, 58, 0.1);
        }
        
        &.good {
          color: #409eff;
          background-color: rgba(64, 158, 255, 0.1);
        }
        
        &.average {
          color: #e6a23c;
          background-color: rgba(230, 162, 60, 0.1);
        }
        
        &.pass {
          color: #f56c6c;
          background-color: rgba(245, 108, 108, 0.1);
        }
        
        &.poor {
          color: #909399;
          background-color: rgba(144, 147, 153, 0.1);
        }
      }
    }
    
    .grade-description {
      font-size: 12px;
      color: #c0c4cc;
    }
  }

  .improvement-suggestions {
    .suggestions-header {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
      font-size: 14px;
      font-weight: 600;
      color: #606266;
      
      i {
        margin-right: 6px;
        color: #f39c12;
      }
    }
    
    .suggestions-list {
      margin: 0;
      padding: 0;
      list-style: none;
      
      .suggestion-item {
        font-size: 12px;
        color: #909399;
        line-height: 1.5;
        margin-bottom: 6px;
        padding-left: 12px;
        position: relative;
        
        &:last-child {
          margin-bottom: 0;
        }
        
        &::before {
          content: '•';
          color: #f39c12;
          position: absolute;
          left: 0;
        }
      }
    }
  }
}

// 响应式设计
@media (max-width: 768px) {
  .score-overview {
    .total-score-section {
      padding: 15px 0;
      
      .total-score {
        .score-value {
          font-size: 28px;
        }
      }
    }
    
    .dimension-scores {
      .dimension-item {
        .dimension-header {
          .dimension-info {
            .dimension-name,
            .dimension-score {
              font-size: 13px;
            }
          }
        }
      }
    }
  }
}
</style>