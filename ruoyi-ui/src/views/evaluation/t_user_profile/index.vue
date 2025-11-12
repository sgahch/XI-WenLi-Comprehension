<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关联sys_user表的用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入关联sys_user表的用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学号" prop="studentId">
        <el-input
          v-model="queryParams.studentId"
          placeholder="请输入学号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="学院名称" prop="college">
        <el-input
          v-model="queryParams.college"
          placeholder="请输入学院名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="专业" prop="major">
        <el-input
          v-model="queryParams.major"
          placeholder="请输入专业"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="年级" prop="grade">
        <el-input
          v-model="queryParams.grade"
          placeholder="请输入年级"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="班级名称" prop="className">
        <el-input
          v-model="queryParams.className"
          placeholder="请输入班级名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item label="性别" prop="gender">
        <el-select
          v-model="queryParams.gender"
          placeholder="请选择性别"
          clearable
          >
          <el-option label="男" value="0"/>
          <el-option label="女" value="1"/>
        </el-select>
      </el-form-item>

      <el-form-item label="出生日期" prop="birthDate">
        <el-date-picker clearable
          v-model="queryParams.birthDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择出生日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="入学日期" prop="enrollmentDate">
        <el-date-picker clearable
          v-model="queryParams.enrollmentDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择入学日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="宿舍" prop="dormitory">
        <el-input
          v-model="queryParams.dormitory"
          placeholder="请输入宿舍"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="家庭地址" prop="homeAddress">
        <el-input
          v-model="queryParams.homeAddress"
          placeholder="请输入家庭地址"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="紧急联系人" prop="emergencyContact">
        <el-input
          v-model="queryParams.emergencyContact"
          placeholder="请输入紧急联系人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="紧急联系电话" prop="emergencyPhone">
        <el-input
          v-model="queryParams.emergencyPhone"
          placeholder="请输入紧急联系电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间" prop="createTime">
        <el-date-picker clearable
          v-model="queryParams.createTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-date-picker clearable
          v-model="queryParams.updateTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择更新时间">
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
          v-hasPermi="['evaluation:t_user_profile:add']"
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
          v-hasPermi="['evaluation:t_user_profile:edit']"
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
          v-hasPermi="['evaluation:t_user_profile:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['evaluation:t_user_profile:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="t_user_profileList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="档案ID" align="center" prop="id" />
      <el-table-column label="关联sys_user表的用户ID" align="center" prop="userId" />
      <el-table-column label="学号" align="center" prop="studentId" />
      <el-table-column label="学院名称" align="center" prop="college" />
      <el-table-column label="专业" align="center" prop="major" />
      <el-table-column label="年级" align="center" prop="grade" />
      <el-table-column label="班级名称" align="center" prop="className" />
      <el-table-column label="性别：0-男，1-女，2-未知" align="center" prop="gender" />
      <el-table-column label="出生日期" align="center" prop="birthDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.birthDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="政治面貌" align="center" prop="politicalStatus" />
      <el-table-column label="入学日期" align="center" prop="enrollmentDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.enrollmentDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="宿舍" align="center" prop="dormitory" />
      <el-table-column label="家庭地址" align="center" prop="homeAddress" />
      <el-table-column label="紧急联系人" align="center" prop="emergencyContact" />
      <el-table-column label="紧急联系电话" align="center" prop="emergencyPhone" />
      <el-table-column label="状态：0-禁用，1-启用" align="center" prop="status" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['evaluation:t_user_profile:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['evaluation:t_user_profile:remove']"
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

    <!-- 添加或修改学生档案管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联sys_user表的用户ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入关联sys_user表的用户ID" />
        </el-form-item>
        <el-form-item label="学号" prop="studentId">
          <el-input v-model="form.studentId" placeholder="请输入学号" />
        </el-form-item>
        <el-form-item label="所属班级" prop="deptId">
          <treeselect
            v-model="form.deptId"
            :options="deptOptions"
            :show-count="true"
            placeholder="请选择所属班级（将自动填充学院、专业、班级信息）"
            @input="handleDeptChange"
          />
        </el-form-item>
        <el-form-item label="学院名称" prop="college">
          <el-input v-model="form.college" placeholder="自动填充" disabled />
        </el-form-item>
        <el-form-item label="专业" prop="major">
          <el-input v-model="form.major" placeholder="自动填充" disabled />
        </el-form-item>
        <el-form-item label="年级" prop="grade">
          <el-input v-model="form.grade" placeholder="请输入年级（如2024级）" />
        </el-form-item>
        <el-form-item label="班级名称" prop="className">
          <el-input v-model="form.className" placeholder="自动填充" disabled />
        </el-form-item>
        <el-form-item label="性别" prop="gender">
          <el-select v-model="form.gender" placeholder="请选择性别" clearable>
            <el-option label="男" value="0" />
            <el-option label="女" value="1" />
            <el-option label="未知" value="2" />
          </el-select>
        </el-form-item>

        <el-form-item label="出生日期" prop="birthDate">
          <el-date-picker clearable
            v-model="form.birthDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择出生日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="入学日期" prop="enrollmentDate">
          <el-date-picker clearable
            v-model="form.enrollmentDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择入学日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="宿舍" prop="dormitory">
          <el-input v-model="form.dormitory" placeholder="请输入宿舍" />
        </el-form-item>
        <el-form-item label="家庭地址" prop="homeAddress">
          <el-input v-model="form.homeAddress" placeholder="请输入家庭地址" />
        </el-form-item>
        <el-form-item label="紧急联系人" prop="emergencyContact">
          <el-input v-model="form.emergencyContact" placeholder="请输入紧急联系人" />
        </el-form-item>
        <el-form-item label="紧急联系电话" prop="emergencyPhone">
          <el-input v-model="form.emergencyPhone" placeholder="请输入紧急联系电话" />
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
import { listT_user_profile, getT_user_profile, delT_user_profile, addT_user_profile, updateT_user_profile } from "@/api/evaluation/t_user_profile"
import { deptTreeSelect } from "@/api/system/user"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"

export default {
  name: "T_user_profile",
  components: { Treeselect },
  data() {
    return {
      // 部门树选项
      deptOptions: undefined,
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
      // 学生档案管理表格数据
      t_user_profileList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        studentId: null,
        college: null,
        major: null,
        grade: null,
        className: null,
        gender: '0',
        birthDate: null,
        politicalStatus: "群众",
        enrollmentDate: null,
        dormitory: null,
        homeAddress: null,
        emergencyContact: null,
        emergencyPhone: null,
        status: 1,
        createTime: null,
        updateTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "关联sys_user表的用户ID不能为空", trigger: "blur" }
        ],
        studentId: [
          { required: true, message: "学号不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()  // 这是 Vue 的一个生命周期钩子。它会在页面刚刚被创建好、但还没显示出来的时候自动执行一次
    this.getDeptTree()  // 获取部门树数据
  },
  methods: {
    /** 查询学生档案管理列表 */
    getList() {
      this.loading = true // 显示加载动画
      listT_user_profile(this.queryParams).then(response => {
        this.t_user_profileList = response.rows
        this.total = response.total
        this.loading = false // 隐藏加载动画
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
        userId: null,
        studentId: null,
        deptId: null,
        college: null,
        major: null,
        grade: null,
        className: null,
        gender: null,
        birthDate: null,
        politicalStatus: null,
        enrollmentDate: null,
        dormitory: null,
        homeAddress: null,
        emergencyContact: null,
        emergencyPhone: null,
        status: null,
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
      this.title = "添加学生档案管理"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getT_user_profile(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学生档案管理"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateT_user_profile(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addT_user_profile(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除学生档案管理编号为"' + ids + '"的数据项？').then(function() {
        return delT_user_profile(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('evaluation/t_user_profile/export', {
        ...this.queryParams
      }, `t_user_profile_${new Date().getTime()}.xlsx`)
    },
    /** 查询部门下拉树结构 */
    getDeptTree() {
      deptTreeSelect().then(response => {
        this.deptOptions = response.data
      })
    },
    /** 部门选择变化时自动填充学院、专业、班级 */
    handleDeptChange(value) {
      if (!value) {
        this.form.college = null
        this.form.major = null
        this.form.className = null
        return
      }

      // 递归查找选中的部门节点
      const findDept = (depts, id) => {
        for (let dept of depts) {
          if (dept.id === id) {
            return dept
          }
          if (dept.children && dept.children.length > 0) {
            const found = findDept(dept.children, id)
            if (found) return found
          }
        }
        return null
      }

      const selectedDept = findDept(this.deptOptions, value)
      if (!selectedDept) return

      // 设置班级名称
      this.form.className = selectedDept.label

      // 解析ancestors获取学院和专业
      // ancestors格式: "0,100,101" -> [0, 100, 101]
      // 100是学院, 101是专业, selectedDept本身是班级
      if (selectedDept.ancestors) {
        const ancestorIds = selectedDept.ancestors.split(',').filter(id => id !== '0')

        if (ancestorIds.length >= 1) {
          // 查找学院（第一级）
          const collegeDept = findDept(this.deptOptions, parseInt(ancestorIds[0]))
          if (collegeDept) {
            this.form.college = collegeDept.label
          }
        }

        if (ancestorIds.length >= 2) {
          // 查找专业（第二级）
          const majorDept = findDept(this.deptOptions, parseInt(ancestorIds[1]))
          if (majorDept) {
            this.form.major = majorDept.label
          }
        }
      }
    }
  }
}
</script>
