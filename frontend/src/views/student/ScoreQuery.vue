<template>
  <div class="score-query">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2>成绩查询</h2>
      <p>查看您的综合测评成绩和历史记录</p>
    </div>

    <!-- 学期选择器 -->
    <div class="semester-selector">
      <el-select
        v-model="selectedSemester"
        placeholder="请选择测评学期"
        style="width: 200px"
      >
        <el-option
          v-for="semester in availableSemesters"
          :key="semester.value"
          :label="semester.label"
          :value="semester.value"
        ></el-option>
      </el-select>
      <el-button type="primary" @click="fetchScoreData" :loading="loading">
        查询成绩
      </el-button>
      <el-button @click="exportScoreReport" v-if="currentScoreData.score > 0">
        导出成绩报告
      </el-button>
    </div>

    <!-- 当前学期成绩概览 -->
    <el-card class="score-overview-card" v-if="currentScoreData.score > 0">
      <template #header>
        <div class="card-header">
          <span>{{ getSemesterLabel(selectedSemester) }} 综合测评成绩</span>
          <el-tag type="success" class="total-score-tag">
            总得分: {{ currentScoreData.score }}
          </el-tag>
        </div>
      </template>

      <!-- 成绩分布图表 -->
      <div class="score-chart-container">
        <div class="chart-title">成绩构成分析</div>
        <div
          id="scoreDistributionChart"
          style="width: 100%; height: 300px"
        ></div>
      </div>

      <!-- 详细成绩表格 -->
      <el-divider>详细成绩</el-divider>
      <el-table :data="currentScoreData.detailItems" style="width: 100%" border>
        <el-table-column
          prop="category"
          label="测评模块"
          width="120px"
        ></el-table-column>
        <el-table-column prop="name" label="项目名称"></el-table-column>
        <el-table-column
          prop="score"
          label="得分"
          width="80px"
        ></el-table-column>
        <el-table-column
          prop="maxScore"
          label="满分"
          width="80px"
        ></el-table-column>
        <el-table-column
          prop="percentage"
          label="得分率"
          width="100px"
        ></el-table-column>
        <el-table-column prop="reviewStatus" label="审核状态" width="100px">
          <template #default="{ row }">
            <el-tag :type="getStatusTagType(row.reviewStatus)">{{
              getStatusText(row.reviewStatus)
            }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="reviewer"
          label="审核人"
          width="120px"
        ></el-table-column>
        <el-table-column
          prop="reviewComment"
          label="审核意见"
          width="180px"
        ></el-table-column>
      </el-table>

      <!-- 排名信息 -->
      <div class="ranking-info" v-if="currentScoreData.rankingInfo">
        <el-divider>排名信息</el-divider>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="班级排名"
            >{{ currentScoreData.rankingInfo.classRank }}/{{
              currentScoreData.rankingInfo.classTotal
            }}</el-descriptions-item
          >
          <el-descriptions-item label="专业排名"
            >{{ currentScoreData.rankingInfo.majorRank }}/{{
              currentScoreData.rankingInfo.majorTotal
            }}</el-descriptions-item
          >
          <el-descriptions-item label="年级排名"
            >{{ currentScoreData.rankingInfo.gradeRank }}/{{
              currentScoreData.rankingInfo.gradeTotal
            }}</el-descriptions-item
          >
          <el-descriptions-item label="院系排名"
            >{{ currentScoreData.rankingInfo.departmentRank }}/{{
              currentScoreData.rankingInfo.departmentTotal
            }}</el-descriptions-item
          >
        </el-descriptions>
      </div>
    </el-card>

    <!-- 成绩申诉按钮 -->
    <div class="appeal-section" v-if="currentScoreData.score > 0 && canAppeal">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>成绩申诉</span>
          </div>
        </template>
        <el-form :model="appealForm" :rules="appealRules" ref="appealFormRef">
          <el-form-item label="申诉项目" prop="appealItem">
            <el-select
              v-model="appealForm.appealItem"
              placeholder="请选择申诉项目"
            >
              <el-option
                v-for="item in appealableItems"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="申诉理由" prop="reason">
            <el-input
              v-model="appealForm.reason"
              type="textarea"
              :rows="4"
              placeholder="请详细描述您的申诉理由"
            ></el-input>
          </el-form-item>
          <el-form-item label="证明材料">
            <el-upload
              class="upload-demo"
              :action="uploadUrl"
              :before-upload="beforeAvatarUpload"
              :on-success="handleAvatarSuccess"
              :limit="1"
              :show-file-list="true"
            >
              <el-button type="primary">点击上传</el-button>
              <template #tip>
                <div class="el-upload__tip">
                  只能上传jpg/png文件，且不超过500kb
                </div>
              </template>
            </el-upload>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              @click="submitAppeal"
              :loading="submittingAppeal"
              >提交申诉</el-button
            >
            <el-button @click="cancelAppeal">取消</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>

    <!-- 历史成绩记录 -->
    <el-card class="history-scores-card">
      <template #header>
        <div class="card-header">
          <span>历史成绩记录</span>
        </div>
      </template>

      <el-table
        :data="historyScores"
        style="width: 100%"
        border
        v-loading="loadingHistory"
        element-loading-text="加载中..."
      >
        <el-table-column
          prop="semester"
          label="测评学期"
          width="150px"
        ></el-table-column>
        <el-table-column
          prop="score"
          label="总得分"
          width="100px"
        ></el-table-column>
        <el-table-column prop="status" label="状态" width="100px">
          <template #default="{ row }">
            <el-tag :type="getStatusTagType(row.status)">{{
              getStatusText(row.status)
            }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="publishTime"
          label="发布时间"
          width="180px"
        ></el-table-column>
        <el-table-column label="操作" width="120px" fixed="right">
          <template #default="{ row }">
            <el-button
              type="text"
              size="small"
              @click="viewHistoryDetail(row.semester)"
            >
              查看详情
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination" v-if="historyScores.length > 0">
        <el-pagination
          v-model:current-page="historyCurrentPage"
          v-model:page-size="historyPageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="historyTotal"
          @size-change="handleHistorySizeChange"
          @current-change="handleHistoryCurrentChange"
        />
      </div>

      <!-- 无数据提示 -->
      <div v-else-if="!loadingHistory" class="no-data">暂无历史成绩记录</div>
    </el-card>

    <!-- 查看历史成绩详情弹窗 -->
    <el-dialog
      v-model="showHistoryDetail"
      title="历史成绩详情"
      width="800px"
      :before-close="handleHistoryDetailClose"
    >
      <div class="history-detail-content">
        <div class="detail-header">
          <span>{{ selectedHistorySemester }} 综合测评成绩</span>
          <el-tag type="success" class="total-score-tag">
            总得分: {{ selectedHistoryScore }}
          </el-tag>
        </div>

        <!-- 历史成绩详情表格 -->
        <el-table
          :data="selectedHistoryScoreDetails"
          style="width: 100%"
          border
        >
          <el-table-column
            prop="category"
            label="测评模块"
            width="120px"
          ></el-table-column>
          <el-table-column prop="name" label="项目名称"></el-table-column>
          <el-table-column
            prop="score"
            label="得分"
            width="80px"
          ></el-table-column>
          <el-table-column
            prop="maxScore"
            label="满分"
            width="80px"
          ></el-table-column>
          <el-table-column
            prop="percentage"
            label="得分率"
            width="100px"
          ></el-table-column>
          <el-table-column prop="reviewStatus" label="审核状态" width="100px">
            <template #default="{ row }">
              <el-tag :type="getStatusTagType(row.reviewStatus)">{{
                getStatusText(row.reviewStatus)
              }}</el-tag>
            </template>
          </el-table-column>
        </el-table>

        <!-- 历史排名信息 -->
        <div class="ranking-info" v-if="selectedHistoryRankingInfo">
          <el-divider>历史排名信息</el-divider>
          <el-descriptions :column="2" border>
            <el-descriptions-item label="班级排名"
              >{{ selectedHistoryRankingInfo.classRank }}/{{
                selectedHistoryRankingInfo.classTotal
              }}</el-descriptions-item
            >
            <el-descriptions-item label="专业排名"
              >{{ selectedHistoryRankingInfo.majorRank }}/{{
                selectedHistoryRankingInfo.majorTotal
              }}</el-descriptions-item
            >
            <el-descriptions-item label="年级排名"
              >{{ selectedHistoryRankingInfo.gradeRank }}/{{
                selectedHistoryRankingInfo.gradeTotal
              }}</el-descriptions-item
            >
            <el-descriptions-item label="院系排名"
              >{{ selectedHistoryRankingInfo.departmentRank }}/{{
                selectedHistoryRankingInfo.departmentTotal
              }}</el-descriptions-item
            >
          </el-descriptions>
        </div>
      </div>

      <!-- 弹窗底部按钮 -->
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="handleHistoryDetailClose">关闭</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, nextTick, watch } from "vue";
import { useUserStore } from "../../store";
import { ElMessage } from "element-plus";
import * as echarts from "echarts";
import { evaluationAPI } from "../../api";

const userStore = useUserStore();

// 图表实例
let scoreChart = null;

// 可用学期列表
const availableSemesters = ref([
  { label: "2024-2025春季学期", value: "2024-spring" },
  { label: "2023-2024秋季学期", value: "2023-autumn" },
  { label: "2023-2024春季学期", value: "2023-spring" },
  { label: "2022-2023秋季学期", value: "2022-autumn" },
]);

// 选中的学期
const selectedSemester = ref("2024-spring");

// 加载状态
const loading = ref(false);
const loadingHistory = ref(false);
const submittingAppeal = ref(false);

// 当前学期成绩数据
const currentScoreData = reactive({
  score: 0,
  semester: "",
  publishTime: "",
  status: "",
  detailItems: [],
  rankingInfo: null,
});

// 历史成绩数据
const historyScores = ref([]);
const historyTotal = ref(0);
const historyCurrentPage = ref(1);
const historyPageSize = ref(10);

// 成绩申诉相关
const canAppeal = computed(() => {
  // 这里应该根据后端返回的申诉期限和状态判断
  return currentScoreData.status === "published" && true;
});

// 可申诉的项目
const appealableItems = computed(() => {
  return currentScoreData.detailItems.filter(
    (item) => item.reviewStatus === "approved"
  );
});

// 申诉表单
const appealForm = reactive({
  appealItem: "",
  reason: "",
  proofFile: "",
});

// 申诉表单规则
const appealRules = {
  appealItem: [
    { required: true, message: "请选择申诉项目", trigger: "change" },
  ],
  reason: [
    { required: true, message: "请填写申诉理由", trigger: "blur" },
    {
      min: 10,
      max: 500,
      message: "申诉理由长度在10到500个字符之间",
      trigger: "blur",
    },
  ],
};

// 表单引用
const appealFormRef = ref(null);

// 文件上传相关
const uploadUrl = "/api/file/upload";

// 历史成绩详情弹窗
const showHistoryDetail = ref(false);
const selectedHistorySemester = ref("");
const selectedHistoryScore = ref(0);
const selectedHistoryScoreDetails = ref([]);
const selectedHistoryRankingInfo = ref(null);

// 获取学期标签
const getSemesterLabel = (value) => {
  const semester = availableSemesters.value.find((s) => s.value === value);
  return semester ? semester.label : value;
};

// 获取状态文本
const getStatusText = (status) => {
  const statusMap = {
    unpublished: "未发布",
    published: "已发布",
    reviewed: "已审核",
    approved: "已通过",
    rejected: "已驳回",
    appealed: "申诉中",
  };
  return statusMap[status] || status;
};

// 获取状态标签类型
const getStatusTagType = (status) => {
  const typeMap = {
    unpublished: "default",
    published: "success",
    reviewed: "primary",
    approved: "success",
    rejected: "danger",
    appealed: "warning",
  };
  return typeMap[status] || "default";
};

// 获取成绩数据
const fetchScoreData = async () => {
  try {
    loading.value = true;
    // axios拦截器已经处理了ResponseResult，直接返回data部分
    const scoreData = await evaluationAPI.getMyScore();

    if (scoreData) {
      // 使用真实的API数据
      currentScoreData.semester = selectedSemester.value;
      currentScoreData.score = scoreData.totalScore || 0;
      currentScoreData.publishTime = scoreData.publishTime || "未发布";
      currentScoreData.ranking = scoreData.ranking || 0;
      currentScoreData.details = [
        { name: "思想品德", score: scoreData.moralScore || 0, fullScore: 100 },
        { name: "学习成绩", score: scoreData.studyScore || 0, fullScore: 100 },
        {
          name: "社会实践",
          score: scoreData.practiceScore || 0,
          fullScore: 100,
        },
        {
          name: "创新创业",
          score: scoreData.innovationScore || 0,
          fullScore: 100,
        },
        { name: "其他加分", score: scoreData.otherScore || 0, fullScore: 100 },
      ];
      ElMessage.success("获取成绩成功");
    } else {
      ElMessage.error("未找到成绩数据");
    }
  } catch (error) {
    console.error("获取成绩失败:", error);
    ElMessage.error("获取成绩数据失败，请重试");
  } finally {
    loading.value = false;
  }
};

// 填充模拟数据（实际项目中应该删除这部分，直接使用API返回数据）
const fillMockData = () => {
  currentScoreData.semester = selectedSemester.value;
  currentScoreData.score = 89.5;
  currentScoreData.publishTime = "2024-06-15 10:30:00";
  currentScoreData.status = "published";
  currentScoreData.detailItems = [
    {
      id: "m1",
      category: "思想道德",
      name: "思想表现",
      score: 18.5,
      maxScore: 20,
      percentage: "92.5%",
      reviewStatus: "approved",
      reviewer: "张老师",
      reviewComment: "表现良好",
    },
    {
      id: "m2",
      category: "思想道德",
      name: "政治学习",
      score: 9.2,
      maxScore: 10,
      percentage: "92.0%",
      reviewStatus: "approved",
      reviewer: "张老师",
      reviewComment: "积极参与",
    },
    {
      id: "m3",
      category: "思想道德",
      name: "志愿服务",
      score: 8.8,
      maxScore: 10,
      percentage: "88.0%",
      reviewStatus: "approved",
      reviewer: "张老师",
      reviewComment: "表现突出",
    },
    {
      id: "a1",
      category: "学业成绩",
      name: "课程成绩",
      score: 38.2,
      maxScore: 40,
      percentage: "95.5%",
      reviewStatus: "approved",
      reviewer: "李老师",
      reviewComment: "成绩优秀",
    },
    {
      id: "a2",
      category: "学业成绩",
      name: "科研项目",
      score: 7.5,
      maxScore: 10,
      percentage: "75.0%",
      reviewStatus: "approved",
      reviewer: "李老师",
      reviewComment: "有一定参与",
    },
    {
      id: "a3",
      category: "学业成绩",
      name: "学术竞赛",
      score: 9.0,
      maxScore: 10,
      percentage: "90.0%",
      reviewStatus: "approved",
      reviewer: "李老师",
      reviewComment: "表现优秀",
    },
    {
      id: "s1",
      category: "社会实践",
      name: "社会实践",
      score: 13.2,
      maxScore: 15,
      percentage: "88.0%",
      reviewStatus: "approved",
      reviewer: "王老师",
      reviewComment: "实践表现良好",
    },
    {
      id: "s2",
      category: "社会实践",
      name: "学生工作",
      score: 8.5,
      maxScore: 10,
      percentage: "85.0%",
      reviewStatus: "approved",
      reviewer: "王老师",
      reviewComment: "工作认真负责",
    },
    {
      id: "s3",
      category: "社会实践",
      name: "文体活动",
      score: 6.6,
      maxScore: 10,
      percentage: "66.0%",
      reviewStatus: "approved",
      reviewer: "王老师",
      reviewComment: "有一定参与",
    },
  ];
  currentScoreData.rankingInfo = {
    classRank: 3,
    classTotal: 45,
    majorRank: 12,
    majorTotal: 156,
    gradeRank: 45,
    gradeTotal: 520,
    departmentRank: 128,
    departmentTotal: 1850,
  };

  // 渲染图表
  nextTick(() => {
    renderScoreChart();
  });
};

// 渲染成绩分布图表
const renderScoreChart = () => {
  if (!scoreChart) {
    scoreChart = echarts.init(
      document.getElementById("scoreDistributionChart")
    );
  }

  // 按类别分组计算总分
  const categoryScores = {};
  currentScoreData.detailItems.forEach((item) => {
    if (!categoryScores[item.category]) {
      categoryScores[item.category] = {
        score: 0,
        maxScore: 0,
      };
    }
    categoryScores[item.category].score += item.score;
    categoryScores[item.category].maxScore += item.maxScore;
  });

  // 准备图表数据
  const categories = Object.keys(categoryScores);
  const scoreData = categories.map((cat) => categoryScores[cat].score);
  const maxScoreData = categories.map((cat) => categoryScores[cat].maxScore);

  // 设置图表配置
  const option = {
    tooltip: {
      trigger: "axis",
      axisPointer: {
        type: "shadow",
      },
      formatter: function (params) {
        let result = params[0].name + "<br/>";
        params.forEach((param) => {
          result +=
            param.marker + param.seriesName + ": " + param.value + "<br/>";
        });
        return result;
      },
    },
    legend: {
      data: ["得分", "满分"],
    },
    grid: {
      left: "3%",
      right: "4%",
      bottom: "3%",
      containLabel: true,
    },
    xAxis: {
      type: "value",
    },
    yAxis: {
      type: "category",
      data: categories,
    },
    series: [
      {
        name: "得分",
        type: "bar",
        stack: "total",
        emphasis: {
          focus: "series",
        },
        data: scoreData,
        itemStyle: {
          color: "#409EFF",
        },
      },
      {
        name: "满分",
        type: "bar",
        stack: "total",
        emphasis: {
          focus: "series",
        },
        data: maxScoreData.map((max, index) => max - scoreData[index]),
        itemStyle: {
          color: "#E4E7ED",
        },
      },
    ],
  };

  scoreChart.setOption(option);

  // 响应式调整图表大小
  window.addEventListener("resize", handleResize);
};

// 处理窗口大小变化
const handleResize = () => {
  if (scoreChart) {
    scoreChart.resize();
  }
};

// 导出成绩报告
const exportScoreReport = async () => {
  try {
    const res = await evaluationAPI.exportScoreReport(selectedSemester.value);
    if (res.code === 200) {
      // 创建下载链接
      const link = document.createElement("a");
      link.href = res.data.fileUrl;
      link.download = `成绩报告-${getSemesterLabel(
        selectedSemester.value
      )}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      ElMessage.success("成绩报告导出成功");
    } else {
      ElMessage.error(res.message || "导出成绩报告失败");
    }
  } catch (error) {
    ElMessage.error("导出成绩报告失败，请重试");
  }
};

// 提交申诉
const submitAppeal = async () => {
  try {
    // 验证表单
    await appealFormRef.value.validate();

    submittingAppeal.value = true;
    const res = await evaluationAPI.submitScoreAppeal({
      semester: selectedSemester.value,
      itemId: appealForm.appealItem,
      reason: appealForm.reason,
      proofFileId: appealForm.proofFile || "",
    });

    if (res.code === 200) {
      ElMessage.success("申诉提交成功");
      cancelAppeal();
    } else {
      ElMessage.error(res.message || "申诉提交失败");
    }
  } catch (error) {
    if (error.name !== "Error") {
      ElMessage.error("请检查输入信息是否正确");
    } else {
      ElMessage.error("申诉提交失败，请重试");
    }
  } finally {
    submittingAppeal.value = false;
  }
};

// 取消申诉
const cancelAppeal = () => {
  appealFormRef.value.resetFields();
  appealForm.proofFile = "";
};

// 上传前检查
const beforeAvatarUpload = (file) => {
  const isJPG = file.type === "image/jpeg" || file.type === "image/png";
  const isLt500k = file.size / 1024 < 500;

  if (!isJPG) {
    ElMessage.error("只能上传jpg/png格式的图片!");
  }
  if (!isLt500k) {
    ElMessage.error("上传图片大小不能超过500KB!");
  }

  return isJPG && isLt500k;
};

// 上传成功处理
const handleAvatarSuccess = (res) => {
  if (res.code === 200) {
    appealForm.proofFile = res.data.fileId;
    ElMessage.success("文件上传成功");
  } else {
    ElMessage.error("文件上传失败");
  }
};

// 获取历史成绩
const fetchHistoryScores = async () => {
  try {
    loadingHistory.value = true;
    const res = await evaluationAPI.getMyScoreHistory({
      params: {
        page: historyCurrentPage.value,
        pageSize: historyPageSize.value,
      },
    });

    if (res.code === 200) {
      // 填充模拟数据，实际应该使用res.data
      fillMockHistoryData();
    } else {
      ElMessage.error(res.message || "获取历史成绩失败");
    }
  } catch (error) {
    ElMessage.error("获取历史成绩失败，请重试");
  } finally {
    loadingHistory.value = false;
  }
};

// 填充模拟历史成绩数据（实际项目中应该删除这部分）
const fillMockHistoryData = () => {
  historyScores.value = [
    {
      semester: "2023-2024秋季学期",
      score: 87.2,
      status: "published",
      publishTime: "2024-02-20 14:20:00",
    },
    {
      semester: "2023-2024春季学期",
      score: 85.8,
      status: "published",
      publishTime: "2023-07-10 09:15:00",
    },
    {
      semester: "2022-2023秋季学期",
      score: 82.5,
      status: "published",
      publishTime: "2023-01-18 16:40:00",
    },
  ];
  historyTotal.value = historyScores.value.length;
};

// 查看历史成绩详情
const viewHistoryDetail = (semester) => {
  selectedHistorySemester.value = semester;

  // 根据学期获取模拟的详细数据
  if (semester === "2023-2024秋季学期") {
    selectedHistoryScore.value = 87.2;
    selectedHistoryScoreDetails.value = [
      {
        category: "思想道德",
        name: "思想表现",
        score: 18.0,
        maxScore: 20,
        percentage: "90.0%",
        reviewStatus: "approved",
      },
      {
        category: "思想道德",
        name: "政治学习",
        score: 9.0,
        maxScore: 10,
        percentage: "90.0%",
        reviewStatus: "approved",
      },
      {
        category: "思想道德",
        name: "志愿服务",
        score: 8.5,
        maxScore: 10,
        percentage: "85.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "课程成绩",
        score: 37.5,
        maxScore: 40,
        percentage: "93.8%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "科研项目",
        score: 6.5,
        maxScore: 10,
        percentage: "65.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "学术竞赛",
        score: 8.0,
        maxScore: 10,
        percentage: "80.0%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "社会实践",
        score: 12.8,
        maxScore: 15,
        percentage: "85.3%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "学生工作",
        score: 8.2,
        maxScore: 10,
        percentage: "82.0%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "文体活动",
        score: 6.7,
        maxScore: 10,
        percentage: "67.0%",
        reviewStatus: "approved",
      },
    ];
    selectedHistoryRankingInfo.value = {
      classRank: 4,
      classTotal: 45,
      majorRank: 15,
      majorTotal: 156,
      gradeRank: 52,
      gradeTotal: 520,
      departmentRank: 145,
      departmentTotal: 1850,
    };
  } else if (semester === "2023-2024春季学期") {
    selectedHistoryScore.value = 85.8;
    selectedHistoryScoreDetails.value = [
      {
        category: "思想道德",
        name: "思想表现",
        score: 17.5,
        maxScore: 20,
        percentage: "87.5%",
        reviewStatus: "approved",
      },
      {
        category: "思想道德",
        name: "政治学习",
        score: 8.8,
        maxScore: 10,
        percentage: "88.0%",
        reviewStatus: "approved",
      },
      {
        category: "思想道德",
        name: "志愿服务",
        score: 8.2,
        maxScore: 10,
        percentage: "82.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "课程成绩",
        score: 36.8,
        maxScore: 40,
        percentage: "92.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "科研项目",
        score: 6.0,
        maxScore: 10,
        percentage: "60.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "学术竞赛",
        score: 7.5,
        maxScore: 10,
        percentage: "75.0%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "社会实践",
        score: 12.5,
        maxScore: 15,
        percentage: "83.3%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "学生工作",
        score: 8.0,
        maxScore: 10,
        percentage: "80.0%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "文体活动",
        score: 6.5,
        maxScore: 10,
        percentage: "65.0%",
        reviewStatus: "approved",
      },
    ];
    selectedHistoryRankingInfo.value = {
      classRank: 6,
      classTotal: 45,
      majorRank: 20,
      majorTotal: 156,
      gradeRank: 65,
      gradeTotal: 520,
      departmentRank: 175,
      departmentTotal: 1850,
    };
  } else if (semester === "2022-2023秋季学期") {
    selectedHistoryScore.value = 82.5;
    selectedHistoryScoreDetails.value = [
      {
        category: "思想道德",
        name: "思想表现",
        score: 17.0,
        maxScore: 20,
        percentage: "85.0%",
        reviewStatus: "approved",
      },
      {
        category: "思想道德",
        name: "政治学习",
        score: 8.5,
        maxScore: 10,
        percentage: "85.0%",
        reviewStatus: "approved",
      },
      {
        category: "思想道德",
        name: "志愿服务",
        score: 7.8,
        maxScore: 10,
        percentage: "78.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "课程成绩",
        score: 35.5,
        maxScore: 40,
        percentage: "88.8%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "科研项目",
        score: 5.5,
        maxScore: 10,
        percentage: "55.0%",
        reviewStatus: "approved",
      },
      {
        category: "学业成绩",
        name: "学术竞赛",
        score: 7.0,
        maxScore: 10,
        percentage: "70.0%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "社会实践",
        score: 11.8,
        maxScore: 15,
        percentage: "78.7%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "学生工作",
        score: 7.5,
        maxScore: 10,
        percentage: "75.0%",
        reviewStatus: "approved",
      },
      {
        category: "社会实践",
        name: "文体活动",
        score: 6.2,
        maxScore: 10,
        percentage: "62.0%",
        reviewStatus: "approved",
      },
    ];
    selectedHistoryRankingInfo.value = {
      classRank: 8,
      classTotal: 45,
      majorRank: 25,
      majorTotal: 156,
      gradeRank: 78,
      gradeTotal: 520,
      departmentRank: 210,
      departmentTotal: 1850,
    };
  }

  showHistoryDetail.value = true;
};

// 处理历史详情弹窗关闭
const handleHistoryDetailClose = () => {
  showHistoryDetail.value = false;
};

// 分页处理
const handleHistorySizeChange = (size) => {
  historyPageSize.value = size;
  fetchHistoryScores();
};

const handleHistoryCurrentChange = (current) => {
  historyCurrentPage.value = current;
  fetchHistoryScores();
};

// 监听组件销毁
import { onUnmounted } from "vue";

onUnmounted(() => {
  window.removeEventListener("resize", handleResize);
  if (scoreChart) {
    scoreChart.dispose();
    scoreChart = null;
  }
});

// 页面挂载时加载数据
onMounted(() => {
  fetchScoreData();
  fetchHistoryScores();
});
</script>

<style scoped>
.score-query {
  width: 100%;
  padding: 20px;
}

/* 页面标题 */
.page-header {
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0 0 5px 0;
  color: #303133;
}

.page-header p {
  margin: 0;
  color: #909399;
}

/* 学期选择器 */
.semester-selector {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 20px;
}

/* 成绩概览卡片 */
.score-overview-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.total-score-tag {
  font-size: 16px;
  padding: 4px 12px;
}

/* 成绩图表容器 */
.score-chart-container {
  margin: 20px 0;
}

.chart-title {
  font-size: 14px;
  color: #606266;
  margin-bottom: 10px;
  text-align: center;
}

/* 排名信息 */
.ranking-info {
  margin-top: 20px;
}

/* 申诉区域 */
.appeal-section {
  margin-bottom: 20px;
}

/* 历史成绩卡片 */
.history-scores-card {
  margin-bottom: 20px;
}

/* 分页样式 */
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

/* 无数据提示 */
.no-data {
  text-align: center;
  color: #909399;
  padding: 40px 0;
}

/* 历史详情弹窗内容 */
.history-detail-content {
  max-height: 600px;
  overflow-y: auto;
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .score-query {
    padding: 10px;
  }

  .semester-selector {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .semester-selector .el-select,
  .semester-selector .el-button {
    width: 100%;
  }

  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
  }

  .el-descriptions {
    font-size: 12px;
  }

  .pagination {
    justify-content: center;
  }
}
</style>
