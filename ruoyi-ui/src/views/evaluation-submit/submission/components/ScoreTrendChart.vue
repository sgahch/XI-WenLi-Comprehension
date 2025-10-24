<template>
  <div class="score-trend-chart">
    <el-card shadow="never" class="chart-card">
      <div slot="header" class="chart-header">
        <div class="header-left">
          <i class="el-icon-data-line"></i>
          <span class="title">成绩趋势分析</span>
          <span class="subtitle">Score Trend Analysis</span>
        </div>
        <div class="header-right">
          <el-select 
            v-model="selectedDimension" 
            @change="handleDimensionChange"
            size="small"
            style="width: 120px"
          >
            <el-option label="综合成绩" value="comprehensive" />
            <el-option label="德育" value="moral" />
            <el-option label="智育" value="intellectual" />
            <el-option label="体育" value="physical" />
            <el-option label="美育" value="aesthetic" />
            <el-option label="劳育" value="labor" />
          </el-select>
        </div>
      </div>

      <div class="chart-content">
        <!-- 趋势统计卡片 -->
        <el-row :gutter="20" class="trend-stats">
          <el-col :span="6">
            <div class="stat-card">
              <div class="stat-icon" style="background: #409EFF;">
                <i class="el-icon-trend-charts"></i>
              </div>
              <div class="stat-content">
                <div class="stat-value">{{ trendStats.average.toFixed(2) }}</div>
                <div class="stat-label">平均分</div>
              </div>
            </div>
          </el-col>
          <el-col :span="6">
            <div class="stat-card">
              <div class="stat-icon" style="background: #67C23A;">
                <i class="el-icon-top"></i>
              </div>
              <div class="stat-content">
                <div class="stat-value">{{ trendStats.highest.toFixed(2) }}</div>
                <div class="stat-label">最高分</div>
              </div>
            </div>
          </el-col>
          <el-col :span="6">
            <div class="stat-card">
              <div class="stat-icon" style="background: #E6A23C;">
                <i class="el-icon-bottom"></i>
              </div>
              <div class="stat-content">
                <div class="stat-value">{{ trendStats.lowest.toFixed(2) }}</div>
                <div class="stat-label">最低分</div>
              </div>
            </div>
          </el-col>
          <el-col :span="6">
            <div class="stat-card">
              <div class="stat-icon" :style="{ background: trendStats.improvement >= 0 ? '#67C23A' : '#F56C6C' }">
                <i :class="trendStats.improvement >= 0 ? 'el-icon-arrow-up' : 'el-icon-arrow-down'"></i>
              </div>
              <div class="stat-content">
                <div class="stat-value" :style="{ color: trendStats.improvement >= 0 ? '#67C23A' : '#F56C6C' }">
                  {{ trendStats.improvement >= 0 ? '+' : '' }}{{ trendStats.improvement.toFixed(2) }}
                </div>
                <div class="stat-label">变化幅度</div>
              </div>
            </div>
          </el-col>
        </el-row>

        <!-- 图表容器 -->
        <div class="chart-container">
          <div ref="trendChart" class="trend-chart" style="width: 100%; height: 400px;"></div>
        </div>

        <!-- 详细数据表格 -->
        <div class="trend-table" v-if="showDetailTable">
          <el-table :data="trendData" border size="small">
            <el-table-column prop="period" label="学期" width="120" align="center" />
            <el-table-column prop="comprehensiveScore" label="综合成绩" width="100" align="center">
              <template slot-scope="scope">
                <span :style="{ color: getScoreColor(scope.row.comprehensiveScore) }">
                  {{ scope.row.comprehensiveScore.toFixed(2) }}
                </span>
              </template>
            </el-table-column>
            <el-table-column prop="moralScore" label="德育" width="80" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.moralScore.toFixed(2) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="intellectualScore" label="智育" width="80" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.intellectualScore.toFixed(2) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="physicalScore" label="体育" width="80" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.physicalScore.toFixed(2) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="aestheticScore" label="美育" width="80" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.aestheticScore.toFixed(2) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="laborScore" label="劳育" width="80" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.laborScore.toFixed(2) }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="classRank" label="班级排名" width="100" align="center">
              <template slot-scope="scope">
                <el-tag :type="getRankTagType(scope.row.classRank)" size="mini">
                  {{ scope.row.classRank || '-' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="majorRank" label="专业排名" width="100" align="center">
              <template slot-scope="scope">
                <el-tag :type="getRankTagType(scope.row.majorRank)" size="mini">
                  {{ scope.row.majorRank || '-' }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </div>

        <!-- 操作按钮 -->
        <div class="chart-actions">
          <el-button 
            type="text" 
            @click="showDetailTable = !showDetailTable"
            icon="el-icon-view"
          >
            {{ showDetailTable ? '隐藏' : '显示' }}详细数据
          </el-button>
          <el-button 
            type="text" 
            @click="exportChart"
            icon="el-icon-download"
          >
            导出图表
          </el-button>
          <el-button 
            type="text" 
            @click="refreshData"
            icon="el-icon-refresh"
          >
            刷新数据
          </el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getStudentScoreTrend } from '@/api/evaluation/semesterScore'

export default {
  name: 'ScoreTrendChart',
  props: {
    // 学生ID
    studentId: {
      type: String,
      required: true
    },
    // 学年
    academicYear: {
      type: String,
      default: ''
    },
    // 图表高度
    height: {
      type: String,
      default: '400px'
    }
  },
  data() {
    return {
      // 选中的维度
      selectedDimension: 'comprehensive',
      // 趋势数据
      trendData: [],
      // 图表实例
      chartInstance: null,
      // 是否显示详细表格
      showDetailTable: false,
      // 加载状态
      loading: false
    }
  },
  computed: {
    // 趋势统计
    trendStats() {
      if (!this.trendData || this.trendData.length === 0) {
        return {
          average: 0,
          highest: 0,
          lowest: 0,
          improvement: 0
        }
      }

      const scores = this.trendData.map(item => {
        switch (this.selectedDimension) {
          case 'moral': return item.moralScore
          case 'intellectual': return item.intellectualScore
          case 'physical': return item.physicalScore
          case 'aesthetic': return item.aestheticScore
          case 'labor': return item.laborScore
          default: return item.comprehensiveScore
        }
      })

      const average = scores.reduce((sum, score) => sum + score, 0) / scores.length
      const highest = Math.max(...scores)
      const lowest = Math.min(...scores)
      const improvement = scores.length > 1 ? scores[scores.length - 1] - scores[0] : 0

      return {
        average,
        highest,
        lowest,
        improvement
      }
    },

    // 图表配置
    chartOptions() {
      if (!this.trendData || this.trendData.length === 0) {
        return {}
      }

      const xAxisData = this.trendData.map(item => item.period)
      const seriesData = []

      if (this.selectedDimension === 'comprehensive') {
        // 综合成绩显示所有维度
        const dimensions = [
          { key: 'comprehensiveScore', name: '综合成绩', color: '#409EFF' },
          { key: 'moralScore', name: '德育', color: '#e74c3c' },
          { key: 'intellectualScore', name: '智育', color: '#3498db' },
          { key: 'physicalScore', name: '体育', color: '#27ae60' },
          { key: 'aestheticScore', name: '美育', color: '#9b59b6' },
          { key: 'laborScore', name: '劳育', color: '#f39c12' }
        ]

        dimensions.forEach(dim => {
          seriesData.push({
            name: dim.name,
            type: 'line',
            data: this.trendData.map(item => item[dim.key]),
            smooth: true,
            symbol: 'circle',
            symbolSize: 6,
            lineStyle: {
              width: dim.key === 'comprehensiveScore' ? 3 : 2,
              color: dim.color
            },
            itemStyle: {
              color: dim.color
            },
            emphasis: {
              focus: 'series'
            }
          })
        })
      } else {
        // 单个维度显示
        const dimensionConfig = {
          moral: { name: '德育', color: '#e74c3c' },
          intellectual: { name: '智育', color: '#3498db' },
          physical: { name: '体育', color: '#27ae60' },
          aesthetic: { name: '美育', color: '#9b59b6' },
          labor: { name: '劳育', color: '#f39c12' }
        }

        const config = dimensionConfig[this.selectedDimension]
        seriesData.push({
          name: config.name,
          type: 'line',
          data: this.trendData.map(item => item[this.selectedDimension + 'Score']),
          smooth: true,
          symbol: 'circle',
          symbolSize: 8,
          lineStyle: {
            width: 3,
            color: config.color
          },
          itemStyle: {
            color: config.color
          },
          areaStyle: {
            color: {
              type: 'linear',
              x: 0,
              y: 0,
              x2: 0,
              y2: 1,
              colorStops: [{
                offset: 0, color: config.color + '40'
              }, {
                offset: 1, color: config.color + '10'
              }]
            }
          }
        })
      }

      return {
        title: {
          text: this.selectedDimension === 'comprehensive' ? '综合成绩趋势' : `${this.getDimensionName()}成绩趋势`,
          left: 'center',
          textStyle: {
            fontSize: 16,
            fontWeight: 'bold'
          }
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross',
            label: {
              backgroundColor: '#6a7985'
            }
          },
          formatter: function(params) {
            let html = `<div style="margin-bottom: 5px;">${params[0].axisValue}</div>`
            params.forEach(param => {
              html += `<div style="margin-bottom: 2px;">
                <span style="display:inline-block;margin-right:5px;border-radius:10px;width:10px;height:10px;background-color:${param.color};"></span>
                ${param.seriesName}: <strong>${param.value.toFixed(2)}</strong>
              </div>`
            })
            return html
          }
        },
        legend: {
          data: seriesData.map(s => s.name),
          top: 30,
          type: 'scroll'
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          top: '15%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: xAxisData,
          axisLabel: {
            rotate: 45
          }
        },
        yAxis: {
          type: 'value',
          name: '分数',
          min: function(value) {
            return Math.max(0, value.min - 5)
          },
          max: function(value) {
            return Math.min(100, value.max + 5)
          }
        },
        series: seriesData,
        animation: true,
        animationDuration: 1000
      }
    }
  },
  mounted() {
    this.initChart()
    this.loadTrendData()
  },
  beforeDestroy() {
    if (this.chartInstance) {
      this.chartInstance.dispose()
    }
  },
  methods: {
    // 初始化图表
    initChart() {
      this.chartInstance = echarts.init(this.$refs.trendChart)
      
      // 监听窗口大小变化
      window.addEventListener('resize', this.handleResize)
    },

    // 加载趋势数据
    async loadTrendData() {
      if (!this.studentId) return

      this.loading = true
      try {
        const params = {
          studentId: this.studentId
        }
        if (this.academicYear) {
          params.academicYear = this.academicYear
        }

        const response = await getStudentScoreTrend(params)
        if (response.code === 200) {
          this.trendData = response.data || []
          this.updateChart()
        }
      } catch (error) {
        this.$modal.msgError('加载趋势数据失败')
      } finally {
        this.loading = false
      }
    },

    // 更新图表
    updateChart() {
      if (this.chartInstance && this.chartOptions) {
        this.chartInstance.setOption(this.chartOptions, true)
      }
    },

    // 处理维度变化
    handleDimensionChange() {
      this.updateChart()
    },

    // 处理窗口大小变化
    handleResize() {
      if (this.chartInstance) {
        this.chartInstance.resize()
      }
    },

    // 获取维度名称
    getDimensionName() {
      const names = {
        moral: '德育',
        intellectual: '智育',
        physical: '体育',
        aesthetic: '美育',
        labor: '劳育'
      }
      return names[this.selectedDimension] || '综合'
    },

    // 获取分数颜色
    getScoreColor(score) {
      if (score >= 90) return '#67C23A'
      if (score >= 80) return '#E6A23C'
      if (score >= 70) return '#F56C6C'
      return '#909399'
    },

    // 获取排名标签类型
    getRankTagType(rank) {
      if (!rank) return 'info'
      if (rank <= 3) return 'success'
      if (rank <= 10) return 'warning'
      return 'info'
    },

    // 导出图表
    exportChart() {
      if (this.chartInstance) {
        const url = this.chartInstance.getDataURL({
          type: 'png',
          pixelRatio: 2,
          backgroundColor: '#fff'
        })
        
        const link = document.createElement('a')
        link.href = url
        link.download = `成绩趋势图_${this.studentId}_${new Date().getTime()}.png`
        link.click()
      }
    },

    // 刷新数据
    refreshData() {
      this.loadTrendData()
    }
  }
}
</script>

<style lang="scss" scoped>
.score-trend-chart {
  .chart-card {
    .chart-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      .header-left {
        display: flex;
        align-items: center;
        
        i {
          font-size: 20px;
          color: #409EFF;
          margin-right: 8px;
        }
        
        .title {
          font-size: 16px;
          font-weight: 600;
          color: #303133;
          margin-right: 8px;
        }
        
        .subtitle {
          font-size: 12px;
          color: #909399;
        }
      }
    }
    
    .chart-content {
      .trend-stats {
        margin-bottom: 20px;
        
        .stat-card {
          display: flex;
          align-items: center;
          padding: 16px;
          background: #FAFAFA;
          border-radius: 8px;
          transition: all 0.3s;
          
          &:hover {
            background: #F5F7FA;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
          }
          
          .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            
            i {
              font-size: 20px;
              color: white;
            }
          }
          
          .stat-content {
            .stat-value {
              font-size: 20px;
              font-weight: bold;
              color: #303133;
              line-height: 1;
              margin-bottom: 4px;
            }
            
            .stat-label {
              font-size: 12px;
              color: #909399;
            }
          }
        }
      }
      
      .chart-container {
        margin: 20px 0;
        border: 1px solid #EBEEF5;
        border-radius: 6px;
        padding: 16px;
        
        .trend-chart {
          min-height: 400px;
        }
      }
      
      .trend-table {
        margin: 20px 0;
        
        ::v-deep .el-table {
          .el-table__header {
            th {
              background: #FAFAFA;
              color: #606266;
              font-weight: 600;
            }
          }
          
          .el-table__body {
            tr:hover > td {
              background: #F5F7FA;
            }
          }
        }
      }
      
      .chart-actions {
        text-align: center;
        padding: 16px 0;
        border-top: 1px solid #EBEEF5;
        
        .el-button {
          margin: 0 8px;
        }
      }
    }
  }
}
</style>