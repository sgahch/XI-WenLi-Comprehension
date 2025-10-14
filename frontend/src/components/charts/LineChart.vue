<template>
  <div class="chart-container">
    <v-chart class="chart" :option="chartOption" autoresize />
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import VChart from "vue-echarts";
import { use } from "echarts/core";
import { CanvasRenderer } from "echarts/renderers";
import { LineChart } from "echarts/charts";
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent,
} from "echarts/components";

use([
  CanvasRenderer,
  LineChart,
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  GridComponent,
]);

const chartOption = ref({
  tooltip: { trigger: "axis" },
  xAxis: { type: "category", data: ["1月", "2月", "3月", "4月", "5月"] },
  yAxis: { type: "value" },
  series: [
    {
      name: "学生人数",
      type: "line",
      smooth: true,
      data: [50, 80, 120, 150, 200],
      areaStyle: {},
    },
  ],
});
</script>

<style scoped>
.chart-container {
  width: 100%;
  height: 300px;
}

.chart {
  height: 100%;
  width: 100%;
}
</style>
