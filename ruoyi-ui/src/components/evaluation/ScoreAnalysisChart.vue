<template>
  <div class="score-analysis-chart">
    <!-- 图表控制面板 -->
    <div class="chart-controls">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-select v-model="chartType" placeholder="选择图表类型" @change="handleChartTypeChange">
            <el-option label="趋势分析" value="trend" />
            <el-option label="维度对比" value="dimension" />
            <el-option label="排名分布" value="ranking" />
            <el-option label="成绩分布" value="distribution" />
          </el-select>
        </el-col>
        <el-col :span="6">
          <el-select v-model="timeRange" placeholder="选择时间范围" @change="handleTimeRangeChange">
            <el-option label="最近一学期" value="1" />
            <el-option label="最近一学年" value="2" />
            <el-option label="最近两学年" value="4" />
            <el-option label="全部" value="all" />
          </el-select>
        </el-col>
        <el-col :span="6">
          <el-select v-model="selectedDimension" placeholder="选择维度" @change="handleDimensionChange" v-if="chartType === 'trend'">
            <el-option label="综合成绩" value="comprehensive" />
            <el-option label="德育成绩" value="moral" />
            <el-option label="智育成绩" value="intellectual" />
            <el-option label="体育成绩" value="physical" />
            <el-option label="美育成绩" value="aesthetic" />
            <el-option label="劳育成绩" value="labor" />
          </el-select>
        </el-col>
        <el-col :span="6">
          <el-button type="primary" icon="el-icon-refresh" @click="refreshChart">刷新</el-button>
          <el-button type="success" icon="el-icon-download" @click="exportChart">导出</el-button>
        </el-col>
      </el-row>
    </div>

    <!-- 图表容器 -->
    <div class="chart-container">
      <div ref="chartRef" class="chart" v-loading="loading"></div>
    </div>

    <!-- 统计信息面板 -->
    <div class="statistics-panel" v-if="statisticsData">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-statistic title="平均成绩" :value="statisticsData.averageScore" :precision="2" suffix="分" />
        </el-col>
        <el-col :span="6">
          <el-statistic title="最高成绩" :value="statisticsData.maxScore" :precision="2" suffix="分" />
        </el-col>
        <el-col :span="6">
          <el-statistic title="最低成绩" :value="statisticsData.minScore" :precision="2" suffix="分" />
        </el-col>
        <el-col :span="6">
          <el-statistic title="及格率" :value="statisticsData.passRate" :precision="1" suffix="%" />
        </el-col>
      </el-row>
    </div>

    <!-- 详细数据表格 -->
    <div class="data-table" v-if="showDataTable">
      <el-table :data="tableData" stripe style="width: 100%" max-height="400">
        <el-table-column prop="period" label="学期" width="120" />
        <el-table-column prop="comprehensiveScore" label="综合成绩" width="100" />
        <el-table-column prop="moralScore" label="德育" width="80" />
        <el-table-column prop="intellectualScore" label="智育" width="80" />
        <el-table-column prop="physicalScore" label="体育" width="80" />
        <el-table-column prop="aestheticScore" label="美育" width="80" />
        <el-table-column prop="laborScore" label="劳育" width="80" />
        <el-table-column prop="classRanking" label="班级排名" width="100" />
        <el-table-column prop="majorRanking" label="专业排名" width="100" />
        <el-table-column prop="trend" label="趋势" width="100">
          <template v-slot:default="scope">
            <el-tag :type="getTrendType(scope.row.trend)" size="small">
              {{ getTrendText(scope.row.trend) }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts';
import { getStudentScoreTrend, getClassScoreStatistics, getMajorScoreStatistics } from '@/api/evaluation/semesterScore';

export default {
  name: 'ScoreAnalysisChart',
  props: {
    studentId: { type: String, default: '' },
    classId: { type: [String, Number], default: null },
    majorId: { type: [String, Number], default: null },
    showDataTable: { type: Boolean, default: true }
  },
  data() {
    return {
      chartInstance: null,
      loading: false,
      chartType: 'trend',
      timeRange: '2',
      selectedDimension: 'comprehensive',
      statisticsData: null,
      tableData: [],
      chartData: {
        trend: [],
        dimension: [],
        ranking: [],
        distribution: []
      }
    };
  },
  watch: {
    // 监听关键props变化，重新加载数据
    studentId(newVal) { if (newVal) this.loadChartData(); },
    classId(newVal) { if (newVal) this.loadChartData(); },
    majorId(newVal) { if (newVal) this.loadChartData(); }
  },
  mounted() {
    this.$nextTick(() => {
      this.initChart();
      this.loadChartData();
    });
    window.addEventListener('resize', this.handleResize);
  },
  beforeDestroy() {
    if (this.chartInstance) {
      this.chartInstance.dispose();
    }
    window.removeEventListener('resize', this.handleResize);
  },
  methods: {
    // 初始化图表
    initChart() {
      if (!this.$refs.chartRef) return;
      this.chartInstance = echarts.init(this.$refs.chartRef);
    },
    // 处理窗口大小变化
    handleResize() {
      if (this.chartInstance) {
        this.chartInstance.resize();
      }
    },
    // 加载数据总入口
    loadChartData() {
      switch (this.chartType) {
        case 'trend': this.loadTrendData(); break;
        case 'dimension': this.loadDimensionData(); break;
        case 'ranking': this.loadRankingData(); break;
        case 'distribution': this.loadDistributionData(); break;
      }
    },
    // 加载趋势分析数据
    async loadTrendData() {
      if (!this.studentId) return;
      this.loading = true;
      try {
        const params = { studentId: this.studentId, timeRange: this.timeRange, dimension: this.selectedDimension };
        const response = await getStudentScoreTrend(params);
        if (response.code === 200) {
          this.chartData.trend = response.data || [];
          this.updateTrendChart();
          this.updateStatistics();
          this.updateTableData();
        }
      } catch (error) {
        this.$message.error('加载趋势数据失败：' + (error.message || ''));
      } finally {
        this.loading = false;
      }
    },
    // 加载维度对比数据
    async loadDimensionData() {
      this.loading = true;
      try {
        // 使用模拟数据
        this.chartData.dimension = [
          { name: '德育', value: 85.5, average: 82.3 }, { name: '智育', value: 92.0, average: 88.7 },
          { name: '体育', value: 78.5, average: 80.1 }, { name: '美育', value: 88.0, average: 85.2 },
          { name: '劳育', value: 90.5, average: 87.8 }
        ];
        this.updateDimensionChart();
      } catch (error) {
        this.$message.error('加载维度数据失败：' + (error.message || ''));
      } finally {
        this.loading = false;
      }
    },
    // 加载排名分布数据
    async loadRankingData() {
      this.loading = true;
      try {
        let response;
        if (this.classId) {
          response = await getClassScoreStatistics({ classId: this.classId, timeRange: this.timeRange });
        } else if (this.majorId) {
          response = await getMajorScoreStatistics({ majorId: this.majorId, timeRange: this.timeRange });
        }
        if (response && response.code === 200) {
          this.chartData.ranking = response.data.rankingDistribution || [];
          this.updateRankingChart();
        }
      } catch (error) {
        this.$message.error('加载排名数据失败：' + (error.message || ''));
      } finally {
        this.loading = false;
      }
    },
    // 加载成绩分布数据
    async loadDistributionData() {
      this.loading = true;
      try {
        // 模拟数据
        this.chartData.distribution = [
          { range: '90-100', count: 12, percentage: 15.0 }, { range: '80-89', count: 28, percentage: 35.0 },
          { range: '70-79', count: 25, percentage: 31.3 }, { range: '60-69', count: 10, percentage: 12.5 },
          { range: '0-59', count: 5, percentage: 6.3 }
        ];
        this.updateDistributionChart();
      } catch (error) {
        this.$message.error('加载分布数据失败：' + (error.message || ''));
      } finally {
        this.loading = false;
      }
    },
    // ... (所有 updateChart 方法都保持不变, 这里省略以减少篇幅)
    updateTrendChart() {
      if (!this.chartInstance || !this.chartData.trend.length) return
      const data = this.chartData.trend
      const option = {
        title: { text: '成绩趋势分析', left: 'center' },
        tooltip: { trigger: 'axis', axisPointer: { type: 'cross' }},
        legend: { data: ['个人成绩', '班级平均'], top: 30 },
        grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
        xAxis: { type: 'category', data: data.map(item => item.period), axisLabel: { rotate: 45 }},
        yAxis: { type: 'value', min: 0, max: 100, axisLabel: { formatter: '{value}分' }},
        series: [
          { name: '个人成绩', type: 'line', data: data.map(item => item.score), smooth: true, itemStyle: { color: '#409EFF' }, markPoint: { data: [{ type: 'max', name: '最高分' }, { type: 'min', name: '最低分' }]}},
          { name: '班级平均', type: 'line', data: data.map(item => item.average), smooth: true, lineStyle: { type: 'dashed' }, itemStyle: { color: '#67C23A' }}
        ]
      };
      this.chartInstance.setOption(option);
    },
    updateDimensionChart() {
      if (!this.chartInstance || !this.chartData.dimension.length) return
      const data = this.chartData.dimension
      const option = {
        title: { text: '各维度成绩对比', left: 'center' },
        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' }},
        legend: { data: ['个人成绩', '班级平均'], top: 30 },
        grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
        xAxis: { type: 'category', data: data.map(item => item.name) },
        yAxis: { type: 'value', min: 0, max: 100, axisLabel: { formatter: '{value}分' }},
        series: [
          { name: '个人成绩', type: 'bar', data: data.map(item => item.value), itemStyle: { color: '#409EFF' }},
          { name: '班级平均', type: 'bar', data: data.map(item => item.average), itemStyle: { color: '#67C23A' }}
        ]
      };
      this.chartInstance.setOption(option);
    },
    updateRankingChart() {
      if (!this.chartInstance || !this.chartData.ranking.length) return
      const data = this.chartData.ranking
      const categories = Object.keys(data)
      const values = Object.values(data)
      const option = {
        title: { text: '排名分布统计', left: 'center' },
        tooltip: { trigger: 'item', formatter: '{a} <br/>{b}: {c}人 ({d}%)' },
        legend: { orient: 'vertical', left: 'left', top: 50 },
        series: [{ name: '排名分布', type: 'pie', radius: ['40%', '70%'], center: ['60%', '60%'], avoidLabelOverlap: false, label: { show: false, position: 'center' }, emphasis: { label: { show: true, fontSize: '18', fontWeight: 'bold' }}, labelLine: { show: false }, data: categories.map((key, index) => ({ name: key, value: values[index] }))}]
      };
      this.chartInstance.setOption(option);
    },
    updateDistributionChart() {
      if (!this.chartInstance || !this.chartData.distribution.length) return
      const data = this.chartData.distribution
      const counts = data.map(item => item.count)
      const percentages = data.map(item => item.percentage)
      const option = {
        title: { text: '成绩分布统计', left: 'center' },
        tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' }, formatter: (params) => `${params[0].name}<br/>人数: ${counts[params[0].dataIndex]}人<br/>占比: ${percentages[params[0].dataIndex]}%` },
        grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
        xAxis: { type: 'category', data: data.map(item => item.range), axisLabel: { interval: 0 }},
        yAxis: [{ type: 'value', name: '人数', position: 'left', axisLabel: { formatter: '{value}人' }}, { type: 'value', name: '占比', position: 'right', axisLabel: { formatter: '{value}%' }}],
        series: [
          { name: '人数', type: 'bar', yAxisIndex: 0, data: counts, itemStyle: { color: '#409EFF' }},
          { name: '占比', type: 'line', yAxisIndex: 1, data: percentages, itemStyle: { color: '#F56C6C' }}
        ]
      };
      this.chartInstance.setOption(option);
    },
    // 更新统计信息
    updateStatistics() {
      if (!this.chartData.trend.length) return;
      const scores = this.chartData.trend.map(item => item.score).filter(s => s != null);
      if (scores.length === 0) return;
      const sum = scores.reduce((a, b) => a + b, 0);
      this.statisticsData = {
        averageScore: sum / scores.length,
        maxScore: Math.max(...scores),
        minScore: Math.min(...scores),
        passRate: (scores.filter(s => s >= 60).length / scores.length) * 100
      };
    },
    // 更新表格数据
    updateTableData() {
      if (!this.chartData.trend.length) return;
      this.tableData = this.chartData.trend.map((item, index, arr) => {
        const prevScore = index > 0 ? arr[index - 1].score : null;
        let trend = 0;
        if (prevScore != null && item.score != null) {
          trend = item.score - prevScore;
        }
        return { ...item, comprehensiveScore: item.score, trend };
      });
    },
    // ... (所有 getTrend 和 handle*Change 方法都保持不变)
    getTrendType(trend) { return trend > 0 ? 'success' : trend < 0 ? 'danger' : 'info'; },
    getTrendText(trend) { return trend > 0 ? `↑${trend.toFixed(1)}` : trend < 0 ? `↓${Math.abs(trend).toFixed(1)}` : '→0.0'; },
    handleChartTypeChange() { this.loadChartData(); },
    handleTimeRangeChange() { this.loadChartData(); },
    handleDimensionChange() { if (this.chartType === 'trend') this.loadTrendData(); },
    refreshChart() { this.loadChartData(); },
    exportChart() {
      if (!this.chartInstance) return;
      const url = this.chartInstance.getDataURL({ type: 'png', pixelRatio: 2, backgroundColor: '#fff' });
      const link = document.createElement('a');
      link.href = url;
      link.download = `成绩分析图表_${new Date().getTime()}.png`;
      link.click();
    }
  }
};
</script>

<style scoped>
.score-analysis-chart {
  width: 100%;
  background: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.chart-controls {
  margin-bottom: 20px;
  padding: 15px;
  background: #f5f7fa;
  border-radius: 6px;
}
.chart-container { margin-bottom: 20px; }
.chart { width: 100%; height: 400px; }
.statistics-panel {
  margin-bottom: 20px;
  padding: 15px;
  background: #f0f9ff;
  border-radius: 6px;
  border-left: 4px solid #409EFF;
}
.data-table { margin-top: 20px; }
.el-statistic { text-align: center; } /* 辅助样式 */
</style>
