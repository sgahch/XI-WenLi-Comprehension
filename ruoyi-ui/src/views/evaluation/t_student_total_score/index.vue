<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生ID" prop="studentId">
        <el-input
          v-model="queryParams.studentId"
          placeholder="请输入学生ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="测评体系ID" prop="systemId">
        <el-input
          v-model="queryParams.systemId"
          placeholder="请输入测评体系ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="总分" prop="totalScore">
        <el-input
          v-model="queryParams.totalScore"
          placeholder="请输入总分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="思想品德分" prop="moralScore">
        <el-input
          v-model="queryParams.moralScore"
          placeholder="请输入思想品德分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学习成绩分" prop="studyScore">
        <el-input
          v-model="queryParams.studyScore"
          placeholder="请输入学习成绩分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="社会实践分" prop="practiceScore">
        <el-input
          v-model="queryParams.practiceScore"
          placeholder="请输入社会实践分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创新创业分" prop="innovationScore">
        <el-input
          v-model="queryParams.innovationScore"
          placeholder="请输入创新创业分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="其他加分" prop="otherScore">
        <el-input
          v-model="queryParams.otherScore"
          placeholder="请输入其他加分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="排名" prop="ranking">
        <el-input
          v-model="queryParams.ranking"
          placeholder="请输入排名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学年" prop="academicYear">
        <el-input
          v-model="queryParams.academicYear"
          placeholder="请输入学年"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学期" prop="semester">
        <el-input
          v-model="queryParams.semester"
          placeholder="请输入学期"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="计算时间" prop="calculateTime">
        <el-date-picker clearable
          v-model="queryParams.calculateTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择计算时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="发布时间" prop="publishTime">
        <el-date-picker clearable
          v-model="queryParams.publishTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择发布时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['evaluation:t_student_total_score:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['evaluation:t_student_total_score:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['evaluation:t_student_total_score:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['evaluation:t_student_total_score:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="t_student_total_scoreList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="总成绩ID" align="center" prop="id" />
      <el-table-column label="学生ID" align="center" prop="studentId" />
      <el-table-column label="测评体系ID" align="center" prop="systemId" />
      <el-table-column label="总分" align="center" prop="totalScore" />
      <el-table-column label="思想品德分" align="center" prop="moralScore" />
      <el-table-column label="学习成绩分" align="center" prop="studyScore" />
      <el-table-column label="社会实践分" align="center" prop="practiceScore" />
      <el-table-column label="创新创业分" align="center" prop="innovationScore" />
      <el-table-column label="其他加分" align="center" prop="otherScore" />
      <el-table-column label="排名" align="center" prop="ranking" />
      <el-table-column label="学年" align="center" prop="academicYear" />
      <el-table-column label="学期" align="center" prop="semester" />
      <el-table-column label="状态：0-计算中，1-已完成，2-已公示" align="center" prop="status" />
      <el-table-column label="计算时间" align="center" prop="calculateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.calculateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="发布时间" align="center" prop="publishTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['evaluation:t_student_total_score:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['evaluation:t_student_total_score:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改学生总成绩对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学生ID" prop="studentId">
          <el-input v-model="form.studentId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="测评体系ID" prop="systemId">
          <el-input v-model="form.systemId" placeholder="请输入测评体系ID" />
        </el-form-item>
        <el-form-item label="总分" prop="totalScore">
          <el-input v-model="form.totalScore" placeholder="请输入总分" />
        </el-form-item>
        <el-form-item label="思想品德分" prop="moralScore">
          <el-input v-model="form.moralScore" placeholder="请输入思想品德分" />
        </el-form-item>
        <el-form-item label="学习成绩分" prop="studyScore">
          <el-input v-model="form.studyScore" placeholder="请输入学习成绩分" />
        </el-form-item>
        <el-form-item label="社会实践分" prop="practiceScore">
          <el-input v-model="form.practiceScore" placeholder="请输入社会实践分" />
        </el-form-item>
        <el-form-item label="创新创业分" prop="innovationScore">
          <el-input v-model="form.innovationScore" placeholder="请输入创新创业分" />
        </el-form-item>
        <el-form-item label="其他加分" prop="otherScore">
          <el-input v-model="form.otherScore" placeholder="请输入其他加分" />
        </el-form-item>
        <el-form-item label="排名" prop="ranking">
          <el-input v-model="form.ranking" placeholder="请输入排名" />
        </el-form-item>
        <el-form-item label="学年" prop="academicYear">
          <el-input v-model="form.academicYear" placeholder="请输入学年" />
        </el-form-item>
        <el-form-item label="学期" prop="semester">
          <el-input v-model="form.semester" placeholder="请输入学期" />
        </el-form-item>
        <el-form-item label="计算时间" prop="calculateTime">
          <el-date-picker clearable
            v-model="form.calculateTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择计算时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="发布时间" prop="publishTime">
          <el-date-picker clearable
            v-model="form.publishTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择发布时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listT_student_total_score, getT_student_total_score, delT_student_total_score, addT_student_total_score, updateT_student_total_score } from "@/api/evaluation/t_student_total_score"

export default {
  name: "T_student_total_score",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 学生总成绩表格数据
      t_student_total_scoreList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentId: null,
        systemId: null,
        totalScore: null,
        moralScore: null,
        studyScore: null,
        practiceScore: null,
        innovationScore: null,
        otherScore: null,
        ranking: null,
        academicYear: null,
        semester: null,
        status: null,
        calculateTime: null,
        publishTime: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        studentId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        systemId: [
          { required: true, message: "测评体系ID不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询学生总成绩列表 */
    getList() {
      this.loading = true
      listT_student_total_score(this.queryParams).then(response => {
        this.t_student_total_scoreList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        studentId: null,
        systemId: null,
        totalScore: null,
        moralScore: null,
        studyScore: null,
        practiceScore: null,
        innovationScore: null,
        otherScore: null,
        ranking: null,
        academicYear: null,
        semester: null,
        status: null,
        calculateTime: null,
        publishTime: null,
        createTime: null,
        updateTime: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加学生总成绩"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getT_student_total_score(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学生总成绩"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateT_student_total_score(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addT_student_total_score(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除学生总成绩编号为"' + ids + '"的数据项？').then(function() {
        return delT_student_total_score(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('evaluation/t_student_total_score/export', {
        ...this.queryParams
      }, `t_student_total_score_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
