<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关联加分记录ID" prop="recordId">
        <el-input
          v-model="queryParams.recordId"
          placeholder="请输入关联加分记录ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学生ID" prop="studentId">
        <el-input
          v-model="queryParams.studentId"
          placeholder="请输入学生ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="处理人ID" prop="processBy">
        <el-input
          v-model="queryParams.processBy"
          placeholder="请输入处理人ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="处理时间" prop="processTime">
        <el-date-picker clearable
          v-model="queryParams.processTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择处理时间">
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
          v-hasPermi="['evaluation:t_appeal:add']"
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
          v-hasPermi="['evaluation:t_appeal:edit']"
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
          v-hasPermi="['evaluation:t_appeal:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['evaluation:t_appeal:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="t_appealList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="申诉ID" align="center" prop="id" />
      <el-table-column label="关联加分记录ID" align="center" prop="recordId" />
      <el-table-column label="学生ID" align="center" prop="studentId" />
      <el-table-column label="申诉理由" align="center" prop="appealReason" />
      <el-table-column label="状态：0-待处理，1-已同意，2-已拒绝" align="center" prop="status" />
      <el-table-column label="处理结果" align="center" prop="processResult" />
      <el-table-column label="处理人ID" align="center" prop="processBy" />
      <el-table-column label="处理时间" align="center" prop="processTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.processTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['evaluation:t_appeal:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['evaluation:t_appeal:remove']"
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

    <!-- 添加或修改申诉对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联加分记录ID" prop="recordId">
          <el-input v-model="form.recordId" placeholder="请输入关联加分记录ID" />
        </el-form-item>
        <el-form-item label="学生ID" prop="studentId">
          <el-input v-model="form.studentId" placeholder="请输入学生ID" />
        </el-form-item>
        <el-form-item label="申诉理由" prop="appealReason">
          <el-input v-model="form.appealReason" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="处理结果" prop="processResult">
          <el-input v-model="form.processResult" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="处理人ID" prop="processBy">
          <el-input v-model="form.processBy" placeholder="请输入处理人ID" />
        </el-form-item>
        <el-form-item label="处理时间" prop="processTime">
          <el-date-picker clearable
            v-model="form.processTime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择处理时间">
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
import { listT_appeal, getT_appeal, delT_appeal, addT_appeal, updateT_appeal } from "@/api/evaluation/t_appeal"

export default {
  name: "T_appeal",
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
      // 申诉表格数据
      t_appealList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        recordId: null,
        studentId: null,
        appealReason: null,
        status: null,
        processResult: null,
        processBy: null,
        processTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        recordId: [
          { required: true, message: "关联加分记录ID不能为空", trigger: "blur" }
        ],
        studentId: [
          { required: true, message: "学生ID不能为空", trigger: "blur" }
        ],
        appealReason: [
          { required: true, message: "申诉理由不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询申诉列表 */
    getList() {
      this.loading = true
      listT_appeal(this.queryParams).then(response => {
        this.t_appealList = response.rows
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
        recordId: null,
        studentId: null,
        appealReason: null,
        status: null,
        processResult: null,
        processBy: null,
        createTime: null,
        processTime: null
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
      this.title = "添加申诉"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getT_appeal(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改申诉"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateT_appeal(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addT_appeal(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除申诉编号为"' + ids + '"的数据项？').then(function() {
        return delT_appeal(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('evaluation/t_appeal/export', {
        ...this.queryParams
      }, `t_appeal_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
