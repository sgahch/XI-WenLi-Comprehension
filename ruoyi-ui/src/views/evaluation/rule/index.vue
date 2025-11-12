<template>
  <div class="app-container">
    <!-- 查询表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" inline v-show="showSearch" label-width="70px">
      <el-form-item label="维度" prop="dimension">
        <el-input v-model="queryParams.dimension" placeholder="moral / intellectual 等" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item label="学院ID" prop="collegeId">
        <el-input v-model="queryParams.collegeId" placeholder="学院ID或空表示通用" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item label="大类" prop="category">
        <el-input v-model="queryParams.category" placeholder="如竞赛、实践" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item label="项目" prop="itemName">
        <el-input v-model="queryParams.itemName" placeholder="项目名称" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item label="等级" prop="level">
        <el-input v-model="queryParams.level" placeholder="国家级、省级等" clearable @keyup.enter.native="handleQuery"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 工具栏 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['evaluation:rule:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['evaluation:rule:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['evaluation:rule:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['evaluation:rule:export']">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"/>
    </el-row>

    <!-- 表格 -->
    <el-table v-loading="loading" :data="ruleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="规则ID" prop="id" align="center"/>
      <el-table-column label="维度" prop="dimension" align="center"/>
      <el-table-column label="学院ID" prop="collegeId" align="center"/>
      <el-table-column label="大类" prop="category" align="center"/>
      <el-table-column label="项目" prop="itemName" align="center"/>
      <el-table-column label="等级" prop="level" align="center"/>
      <el-table-column label="分数" prop="score" align="center"/>
      <el-table-column label="状态" prop="isEnabled" align="center"/>
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['evaluation:rule:edit']">编辑</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['evaluation:rule:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>

    <!-- 弹窗 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="维度" prop="dimension"><el-input v-model="form.dimension"/></el-form-item>
        <el-form-item label="大类" prop="category"><el-input v-model="form.category"/></el-form-item>
        <el-form-item label="项目" prop="itemName"><el-input v-model="form.itemName"/></el-form-item>
        <el-form-item label="等级" prop="level"><el-input v-model="form.level"/></el-form-item>
        <el-form-item label="分数" prop="score"><el-input v-model="form.score"/></el-form-item>
        <el-form-item label="状态" prop="isEnabled"><el-input v-model="form.isEnabled"/></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRule, getRule, delRule, addRule, updateRule } from "@/api/evaluation/rule"

export default {
  name: "Rule",
  data() {
    return {
      loading: false,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      ruleList: [],
      title: "",
      open: false,
      queryParams: { pageNum: 1, pageSize: 10 },
      form: {},
      rules: {
        dimension: [{ required: true, message: "请输入维度", trigger: "blur" }],
        category: [{ required: true, message: "请输入大类", trigger: "blur" }],
        itemName: [{ required: true, message: "请输入项目名称", trigger: "blur" }],
        score: [{ required: true, message: "请输入分数", trigger: "blur" }],
      }
    }
  },
  created() { this.getList() },
  methods: {
    getList() {
      this.loading = true
      listRule(this.queryParams).then(res => {
        this.ruleList = res.rows
        this.total = res.total
        this.loading = false
      })
    },
    reset() {
      this.form = {}
      this.resetForm("form")
    },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm("queryForm"); this.handleQuery() },
    handleSelectionChange(selection) {
      this.ids = selection.map(i => i.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() { this.reset(); this.open = true; this.title = "新增规则" },
    handleUpdate(row) {
      const id = row.id || this.ids[0]
      getRule(id).then(res => {
        this.form = res.data
        this.open = true
        this.title = "编辑规则"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const action = this.form.id ? updateRule : addRule
        action(this.form).then(() => {
          this.$modal.msgSuccess("操作成功")
          this.open = false
          this.getList()
        })
      })
    },
    cancel() {
      this.open = false
      this.reset()
    },
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm(`确认删除规则编号为 "${ids}" 吗？`).then(() => delRule(ids)).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      })
    },
    handleExport() {
      this.download('evaluation/rule/export', this.queryParams, `rule_${Date.now()}.xlsx`)
    }
  }
}
</script>
