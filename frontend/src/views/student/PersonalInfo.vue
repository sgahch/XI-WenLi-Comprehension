<template>
  <div class="modern-personal-info">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-title">
          <h1 class="title">个人信息</h1>
          <p class="subtitle">管理您的个人信息和账户设置</p>
        </div>
        <div class="header-actions" v-if="!isEditing">
          <el-button 
            type="primary" 
            class="modern-button primary"
            @click="toggleEdit"
          >
            <el-icon><Edit /></el-icon>
            编辑信息
          </el-button>
        </div>
      </div>
    </div>

    <div class="content-grid">
      <!-- 基本信息卡片 -->
      <div class="info-section">
        <div class="modern-card glass-effect hover-lift">
          <div class="card-header">
            <div class="header-icon">
              <el-icon><User /></el-icon>
            </div>
            <div class="header-text">
              <h3 class="card-title">基本信息</h3>
              <p class="card-subtitle">个人资料和基本信息</p>
            </div>
          </div>
          
          <div class="card-content">
            <!-- 头像区域 -->
            <div class="avatar-section">
              <div class="avatar-container">
                <el-avatar 
                  :src="userInfo.avatar" 
                  class="user-avatar" 
                  :size="120"
                >
                  {{ userInfo.name?.[0] || 'U' }}
                </el-avatar>
                <div class="avatar-overlay" v-if="isEditing" @click="handleAvatarUpload">
                  <el-icon><Camera /></el-icon>
                  <span>更换头像</span>
                </div>
              </div>
              <input 
                ref="avatarInput" 
                type="file" 
                accept="image/*" 
                style="display: none" 
                @change="onAvatarChange"
              >
            </div>
            
            <!-- 表单区域 -->
            <div class="form-section">
              <el-form 
                ref="infoForm" 
                :model="userInfo" 
                :rules="infoRules" 
                label-width="120px"
                class="modern-form"
              >
                <div class="form-grid">
                  <el-form-item label="姓名" prop="name" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.name" 
                      :disabled="!isEditing" 
                      placeholder="请输入姓名"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><User /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="学号" prop="studentId" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.studentId" 
                      :disabled="!isEditing" 
                      placeholder="请输入学号"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><Postcard /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="性别" prop="gender" class="form-item-modern">
                    <el-select 
                      v-model="userInfo.gender" 
                      :disabled="!isEditing" 
                      placeholder="请选择性别"
                      class="modern-input"
                    >
                      <el-option label="男" value="male">
                        <span class="option-content">
                          <el-icon><Male /></el-icon>
                          男
                        </span>
                      </el-option>
                      <el-option label="女" value="female">
                        <span class="option-content">
                          <el-icon><Female /></el-icon>
                          女
                        </span>
                      </el-option>
                    </el-select>
                  </el-form-item>
                  
                  <el-form-item label="出生日期" prop="birthDate" class="form-item-modern">
                    <el-date-picker
                      v-model="userInfo.birthDate"
                      type="date"
                      :disabled="!isEditing"
                      placeholder="选择日期"
                      class="modern-input"
                      style="width: 100%;"
                    />
                  </el-form-item>
                  
                  <el-form-item label="学院" prop="college" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.college" 
                      :disabled="!isEditing" 
                      placeholder="请输入学院"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><School /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="专业" prop="major" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.major" 
                      :disabled="!isEditing" 
                      placeholder="请输入专业"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><Reading /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="班级" prop="className" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.className" 
                      :disabled="!isEditing" 
                      placeholder="请输入班级"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><Collection /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="年级" prop="grade" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.grade" 
                      :disabled="!isEditing" 
                      placeholder="请输入年级"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><Calendar /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="联系电话" prop="phone" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.phone" 
                      :disabled="!isEditing" 
                      placeholder="请输入联系电话"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><Phone /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                  
                  <el-form-item label="电子邮箱" prop="email" class="form-item-modern">
                    <el-input 
                      v-model="userInfo.email" 
                      :disabled="!isEditing" 
                      placeholder="请输入电子邮箱"
                      class="modern-input"
                    >
                      <template #prefix>
                        <el-icon><Message /></el-icon>
                      </template>
                    </el-input>
                  </el-form-item>
                </div>
                
                <el-form-item label="家庭地址" prop="address" class="form-item-modern full-width">
                  <el-input 
                    v-model="userInfo.address" 
                    :disabled="!isEditing" 
                    placeholder="请输入家庭地址"
                    class="modern-input"
                  >
                    <template #prefix>
                      <el-icon><Location /></el-icon>
                    </template>
                  </el-input>
                </el-form-item>
              </el-form>
            </div>
            
            <!-- 编辑操作按钮 -->
            <div class="edit-actions" v-if="isEditing">
              <el-button 
                type="primary" 
                class="modern-button primary"
                @click="handleSave"
                :loading="saving"
              >
                <el-icon><Check /></el-icon>
                保存修改
              </el-button>
              <el-button 
                class="modern-button secondary"
                @click="handleCancel"
              >
                <el-icon><Close /></el-icon>
                取消
              </el-button>
            </div>
          </div>
        </div>
      </div>

      <!-- 账户安全卡片 -->
      <div class="security-section">
        <div class="modern-card glass-effect hover-lift">
          <div class="card-header">
            <div class="header-icon security">
              <el-icon><Lock /></el-icon>
            </div>
            <div class="header-text">
              <h3 class="card-title">账户安全</h3>
              <p class="card-subtitle">管理您的账户安全设置</p>
            </div>
          </div>
          
          <div class="card-content">
            <div class="security-list">
              <div 
                v-for="item in securityItems" 
                :key="item.title"
                class="security-item"
              >
                <div class="security-info">
                  <div class="security-icon">
                    <el-icon>
                      <component :is="item.icon" />
                    </el-icon>
                  </div>
                  <div class="security-details">
                    <h4 class="security-title">{{ item.title }}</h4>
                    <p class="security-desc">{{ item.description }}</p>
                  </div>
                </div>
                <div class="security-status">
                  <el-tag 
                    :type="item.status === 'success' ? 'success' : 'warning'"
                    class="modern-tag"
                  >
                    {{ item.statusText }}
                  </el-tag>
                  <el-button 
                    type="text" 
                    class="security-action"
                    @click="handleSecurityAction(item)"
                  >
                    {{ item.action }}
                    <el-icon><ArrowRight /></el-icon>
                  </el-button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, nextTick } from 'vue'
import { useUserStore } from '../../store'
import { ElMessage, ElMessageBox } from 'element-plus'
import { userAPI } from '../../api'

const userStore = useUserStore()

// 用户信息数据
const userInfo = reactive({
  name: '',
  studentId: '',
  gender: '',
  birthDate: null,
  college: '',
  major: '',
  className: '',
  grade: '',
  phone: '',
  email: '',
  address: '',
  avatar: '',
  phoneVerified: false,
  emailVerified: false
})

// 原始用户信息（用于取消编辑）
const originalUserInfo = {}

// 编辑状态
const isEditing = ref(false)
const saving = ref(false)

// 账户安全项
const securityItems = ref([
  {
    title: '登录密码',
    description: '定期更换密码可以提高账户安全性',
    icon: 'Lock',
    status: 'success',
    statusText: '已设置',
    action: '修改密码'
  },
  {
    title: '手机验证',
    description: '验证手机号码用于找回密码和安全提醒',
    icon: 'Phone',
    status: computed(() => userInfo.phoneVerified ? 'success' : 'warning'),
    statusText: computed(() => userInfo.phoneVerified ? '已验证' : '未验证'),
    action: '验证手机'
  },
  {
    title: '邮箱验证',
    description: '验证邮箱地址用于接收重要通知',
    icon: 'Message',
    status: computed(() => userInfo.emailVerified ? 'success' : 'warning'),
    statusText: computed(() => userInfo.emailVerified ? '已验证' : '未验证'),
    action: '验证邮箱'
  }
])

// 表单验证规则
const infoRules = {
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' }
  ],
  studentId: [
    { required: true, message: '请输入学号', trigger: 'blur' }
  ],
  gender: [
    { required: true, message: '请选择性别', trigger: 'change' }
  ],
  birthDate: [
    { required: true, message: '请选择出生日期', trigger: 'change' }
  ],
  college: [
    { required: true, message: '请输入学院', trigger: 'blur' }
  ],
  major: [
    { required: true, message: '请输入专业', trigger: 'blur' }
  ],
  className: [
    { required: true, message: '请输入班级', trigger: 'blur' }
  ],
  grade: [
    { required: true, message: '请输入年级', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入联系电话', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入电子邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
  ],
  address: [
    { required: true, message: '请输入家庭地址', trigger: 'blur' }
  ]
}

// 表单引用
const infoForm = ref(null)
const avatarInput = ref(null)


// 切换编辑状态
const toggleEdit = () => {
  isEditing.value = true
  // 保存原始数据用于取消操作
  Object.assign(originalUserInfo, userInfo)
}

// 检查表单完整性
const checkFormCompleteness = () => {
  const requiredFields = [
    { key: 'name', label: '姓名' },
    { key: 'studentId', label: '学号' },
    { key: 'gender', label: '性别' },
    { key: 'birthDate', label: '出生日期' },
    { key: 'college', label: '学院' },
    { key: 'major', label: '专业' },
    { key: 'className', label: '班级' },
    { key: 'grade', label: '年级' },
    { key: 'phone', label: '联系电话' },
    { key: 'email', label: '电子邮箱' },
    { key: 'address', label: '家庭地址' }
  ]
  
  const missingFields = []
  requiredFields.forEach(field => {
    if (!userInfo[field.key] || userInfo[field.key].toString().trim() === '') {
      missingFields.push(field.label)
    }
  })
  
  if (missingFields.length > 0) {
    ElMessage.error(`请填写以下必填字段：${missingFields.join('、')}`)
    return false
  }
  
  // 检查邮箱格式
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(userInfo.email)) {
    ElMessage.error('请输入正确的邮箱地址')
    return false
  }
  
  // 检查手机号格式
  const phoneRegex = /^1[3-9]\d{9}$/
  if (!phoneRegex.test(userInfo.phone)) {
    ElMessage.error('请输入正确的手机号码')
    return false
  }
  
  // 检查出生日期
  if (!userInfo.birthDate) {
    ElMessage.error('请选择出生日期')
    return false
  }
  
  // 检查性别选择
  if (!userInfo.gender || (userInfo.gender !== 'male' && userInfo.gender !== 'female')) {
    ElMessage.error('请选择性别')
    return false
  }
  
  return true
}

// 格式化用户数据
const formatUserData = () => {
  // 确保日期是字符串格式
  if (userInfo.birthDate && userInfo.birthDate instanceof Date) {
    userInfo.birthDate = userInfo.birthDate.toISOString().split('T')[0]
  }
  
  // 去除字符串的首尾空格
  Object.keys(userInfo).forEach(key => {
    if (typeof userInfo[key] === 'string') {
      userInfo[key] = userInfo[key].trim()
    }
  })
}

// 处理头像上传
const handleAvatarUpload = () => {
  if (avatarInput.value) {
    avatarInput.value.click()
  }
}

// 头像文件变化处理
const onAvatarChange = async (event) => {
  const file = event.target.files[0]
  if (!file) return
  
  // 检查文件类型和大小
  const isImage = file.type.startsWith('image/')
  const isLt5M = file.size / 1024 / 1024 < 5
  
  if (!isImage) {
    ElMessage.error('请上传图片文件')
    return
  }
  if (!isLt5M) {
    ElMessage.error('图片大小不能超过 5MB')
    return
  }
  
  try {
    // 显示上传进度
    const loadingMessage = ElMessage({
      message: '正在上传头像...',
      type: 'info',
      duration: 0,
      showClose: false
    })
    
    // 调用头像上传API (axios拦截器已处理ResponseResult，直接返回data字段)
    const uploadResult = await userAPI.uploadAvatar(file)
    
    // 关闭加载提示
    loadingMessage.close()
    
    console.log('头像上传API返回值类型:', typeof uploadResult)
    console.log('头像上传API返回值内容:', uploadResult)
    
    // 确保获取到的是URL字符串
    const avatarUrl = uploadResult
    console.log('处理后的头像URL:', avatarUrl)
    console.log('头像URL类型:', typeof avatarUrl)
    
    userInfo.avatar = avatarUrl
    
    // 调用后端接口更新用户头像字段
    try {
      console.log('正在调用updateAvatar接口，参数:', { avatarUrl })
      console.log('参数中avatarUrl的值:', avatarUrl)
      console.log('参数中avatarUrl的类型:', typeof avatarUrl)
      await userAPI.updateAvatar({ avatarUrl })
      console.log('updateAvatar接口调用成功')
      
      // 更新store中的用户头像，同步左上角头像
      userStore.updateUserInfo({ avatar: avatarUrl })
      
      ElMessage.success('头像更新成功')
    } catch (updateError) {
      console.error('更新头像字段失败:', updateError)
      console.error('错误详情:', {
        message: updateError.message,
        response: updateError.response,
        stack: updateError.stack
      })
      ElMessage.warning('头像上传成功，但保存失败: ' + (updateError.message || '网络错误'))
    }
    
    // 清空input值，以便可以重复选择同一个文件
    event.target.value = ''
  } catch (error) {
    console.error('头像上传失败:', error)
    ElMessage.error('头像上传失败，请重试')
  }
}

// 保存修改
const handleSave = async () => {
  try {
    // 首先检查表单完整性
    if (!checkFormCompleteness()) {
      return
    }
    
    saving.value = true
    
    // 格式化数据
    formatUserData()
    
    // 验证表单
    const valid = await infoForm.value.validate()
    if (!valid) {
      ElMessage.error('请检查输入信息是否正确')
      return
    }
    
    // 调用API保存用户信息
    const saveData = prepareSaveData()
    console.log('发送给后端的数据:', saveData)
    
    // axios拦截器已处理ResponseResult，直接使用返回的数据
    await userAPI.updateUserInfo(saveData)
    
    // 更新成功
    ElMessage.success('保存成功')
    isEditing.value = false
    
    // 更新store中的用户信息
    userStore.updateUserInfo(userInfo)
  } catch (error) {
    console.error('保存用户信息失败:', error)
    
    // 处理表单验证失败
    if (error.errors && Array.isArray(error.errors)) {
      // Element Plus 表单验证失败
      const firstError = error.errors[0]
      ElMessage.error(firstError.message || '请检查输入信息是否正确')
    } else if (error.response) {
      // API 请求失败
      ElMessage.error(error.response.data?.message || '保存失败，请重试')
    } else {
      // 其他错误
      ElMessage.error('保存失败，请重试')
    }
  } finally {
    saving.value = false
  }
}

// 取消编辑
const handleCancel = () => {
  isEditing.value = false
  // 恢复原始数据
  Object.assign(userInfo, originalUserInfo)
}

// 处理账户安全操作
const handleSecurityAction = (row) => {
  switch (row.title) {
    case '登录密码':
      handleChangePassword()
      break
    case '手机验证':
      handleVerifyPhone()
      break
    case '邮箱验证':
      handleVerifyEmail()
      break
  }
}

// 修改密码
const handleChangePassword = () => {
  ElMessageBox.prompt(
    '请输入新密码',
    '修改密码',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      inputType: 'password',
      inputPattern: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/,
      inputErrorMessage: '密码长度至少8位，且包含字母和数字'
    }
  ).then(async ({ value }) => {
    // 调用修改密码API
    try {
      await userAPI.changePassword({ newPassword: value })
      ElMessage.success('密码修改成功，请重新登录')
      setTimeout(() => {
        userStore.logout()
        window.location.href = '/login'
      }, 1500)
    } catch (error) {
      ElMessage.error('密码修改失败，请重试')
    }
  }).catch(() => {
    // 取消操作
  })
}

// 手机验证
const handleVerifyPhone = () => {
  if (userInfo.phoneVerified) {
    ElMessage.info('您的手机号已验证')
  } else {
    ElMessageBox.confirm(
      '确定要发送验证码到您的手机吗？',
      '手机验证',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    ).then(() => {
      // 调用发送验证码API
      ElMessage.success('验证码已发送到您的手机')
      // 这里可以打开验证码输入弹窗
    }).catch(() => {
      // 取消操作
    })
  }
}

// 邮箱验证
const handleVerifyEmail = () => {
  if (userInfo.emailVerified) {
    ElMessage.info('您的邮箱已验证')
  } else {
    ElMessageBox.confirm(
      '确定要发送验证链接到您的邮箱吗？',
      '邮箱验证',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    ).then(() => {
      // 调用发送验证邮件API
      ElMessage.success('验证链接已发送到您的邮箱')
    }).catch(() => {
      // 取消操作
    })
  }
}

// 加载用户信息
const loadUserInfo = async () => {
  try {
    console.log('开始加载用户信息...')
    
    // 调用API获取详细用户信息
    console.log('正在调用 userAPI.getUserInfo()...')
    const res = await userAPI.getUserInfo()
    console.log('API返回的原始数据:', res)
    
    // 判断返回数据的格式
    let userData = null
    
    if (res && res.code === 200 && res.data) {
      // 格式1: { code: 200, data: {...} }
      console.log('检测到标准ResponseResult格式')
      userData = res.data
    } else if (res && res.realName) {
      // 格式2: 直接返回用户数据对象
      console.log('检测到直接返回用户数据格式')
      userData = res
    } else {
      console.error('API返回数据格式不正确:', res)
      return
    }
    
    if (userData) {
      console.log('后端返回的用户信息:', userData)
      console.log('具体字段值:')
      console.log('- userData.realName:', userData.realName)
      console.log('- userData.studentId:', userData.studentId)
      console.log('- userData.gender:', userData.gender)
      console.log('- userData.college:', userData.college)
      console.log('- userData.major:', userData.major)
      console.log('- userData.className:', userData.className)
      console.log('- userData.grade:', userData.grade)
      console.log('- userData.phone:', userData.phone)
      console.log('- userData.email:', userData.email)
      console.log('- userData.address:', userData.address)
      console.log('- userData.birthDate:', userData.birthDate)
      
      // 使用 Object.assign 清空并重新赋值所有字段
      const newData = {
        name: userData.realName || '',
        studentId: userData.studentId || '',
        gender: userData.gender || '',
        college: userData.college || '',
        major: userData.major || '',
        className: userData.className || '',
        grade: userData.grade || '',
        phone: userData.phone || '',
        email: userData.email || '',
        address: userData.address || '',
        avatar: userData.avatar || '',
        emailVerified: userData.emailVerified || false,
        phoneVerified: userData.phoneVerified || false,
        birthDate: userData.birthDate ? new Date(userData.birthDate) : null
      }
      
      console.log('即将赋值的新数据:', newData)
      Object.assign(userInfo, newData)
      
      console.log('赋值后的userInfo:', userInfo)
      console.log('更新后的userInfo:', {
        name: userInfo.name,
        studentId: userInfo.studentId,
        gender: userInfo.gender,
        birthDate: userInfo.birthDate,
        college: userInfo.college,
        major: userInfo.major,
        className: userInfo.className,
        grade: userInfo.grade,
        phone: userInfo.phone,
        email: userInfo.email,
        address: userInfo.address
      })
      
      // 更新store中的用户信息
      userStore.updateUserInfo(userData)
      
      // 强制触发响应式更新
      await nextTick()
      
      console.log('数据加载完成')
    }
  } catch (error) {
    console.error('加载用户信息失败:', error)
    console.error('错误详情:', error.message)
    console.error('错误堆栈:', error.stack)
  }
}

// 映射用户信息字段
const mapUserInfoFields = (data) => {
  if (!data) return
  
  // 字段映射关系
  const fieldMapping = {
    realName: 'name',          // 真实姓名 -> 姓名
    studentId: 'studentId',    // 学号
    gender: 'gender',          // 性别
    birthDate: 'birthDate',    // 出生日期
    college: 'college',        // 学院
    major: 'major',           // 专业
    className: 'className',    // 班级
    grade: 'grade',           // 年级
    phone: 'phone',           // 电话
    email: 'email',           // 邮箱
    address: 'address',       // 地址
    avatar: 'avatar',         // 头像
    emailVerified: 'emailVerified',  // 邮箱验证状态
    phoneVerified: 'phoneVerified'   // 手机验证状态
  }
  
  // 映射数据到userInfo
  Object.keys(fieldMapping).forEach(backendField => {
    const frontendField = fieldMapping[backendField]
    if (data.hasOwnProperty(backendField) && data[backendField] !== null && data[backendField] !== undefined) {
      userInfo[frontendField] = data[backendField]
    }
  })
  
  // 处理日期格式 - 2006-08-29T16:00:00 转换为 Date 对象
  if (userInfo.birthDate) {
    if (typeof userInfo.birthDate === 'string') {
      // 处理 ISO 格式的日期字符串
      userInfo.birthDate = new Date(userInfo.birthDate)
    }
  }
  
  // 确保所有字段都有默认值，避免 undefined
  const defaultValues = {
    name: '',
    studentId: '',
    gender: '',
    birthDate: null,
    college: '',
    major: '',
    className: '',
    grade: '',
    phone: '',
    email: '',
    address: '',
    avatar: '',
    emailVerified: false,
    phoneVerified: false
  }
  
  Object.keys(defaultValues).forEach(field => {
    if (!userInfo[field] && userInfo[field] !== false) {
      userInfo[field] = defaultValues[field]
    }
  })
  
  console.log('映射后的用户信息:', userInfo)
}

// 准备保存数据（映射到后端期望的字段名）
const prepareSaveData = () => {
  // 处理日期格式，确保符合后端LocalDateTime的期望格式
  let formattedBirthDate = null
  if (userInfo.birthDate) {
    if (userInfo.birthDate instanceof Date) {
      // 将Date对象转换为LocalDateTime格式 (yyyy-MM-ddTHH:mm:ss)
      const year = userInfo.birthDate.getFullYear()
      const month = String(userInfo.birthDate.getMonth() + 1).padStart(2, '0')
      const day = String(userInfo.birthDate.getDate()).padStart(2, '0')
      formattedBirthDate = `${year}-${month}-${day}T00:00:00`
    } else if (typeof userInfo.birthDate === 'string') {
      // 如果已经是字符串，确保格式正确
      formattedBirthDate = userInfo.birthDate.includes('T') 
        ? userInfo.birthDate 
        : `${userInfo.birthDate}T00:00:00`
    }
  }
  
  const saveData = {
    realName: userInfo.name,        // 姓名 -> 真实姓名
    studentId: userInfo.studentId,   // 学号
    gender: userInfo.gender,         // 性别
    birthDate: formattedBirthDate,   // 出生日期 - 格式化为LocalDateTime
    college: userInfo.college,       // 学院
    major: userInfo.major,          // 专业
    className: userInfo.className,   // 班级
    grade: userInfo.grade,          // 年级
    phone: userInfo.phone,          // 电话
    email: userInfo.email,          // 邮箱
    address: userInfo.address       // 地址
    // 注意：不再发送avatar字段，头像通过专门的上传接口处理
  }
  
  console.log('准备发送的数据:', saveData)
  console.log('格式化后的日期:', formattedBirthDate)
  
  return saveData
}

// 页面挂载时加载用户信息
onMounted(async () => {
  console.log('组件已挂载，开始加载用户信息...')
  await loadUserInfo()
  
  // 等待一小段时间后再次检查数据状态
  setTimeout(() => {
    console.log('最终的userInfo状态:', userInfo)
    console.log('各字段值:')
    console.log('- name:', userInfo.name)
    console.log('- studentId:', userInfo.studentId)
    console.log('- gender:', userInfo.gender)
    console.log('- college:', userInfo.college)
    console.log('- major:', userInfo.major)
    console.log('- className:', userInfo.className)
    console.log('- grade:', userInfo.grade)
    console.log('- phone:', userInfo.phone)
    console.log('- email:', userInfo.email)
    console.log('- address:', userInfo.address)
    console.log('- birthDate:', userInfo.birthDate)
  }, 1000)
})
</script>

<style scoped>
/* 现代化个人信息页面样式 */
.modern-personal-info {
  padding: var(--spacing-lg);
  background: var(--bg-secondary);
  min-height: calc(100vh - 64px);
}

/* 页面头部 */
.page-header {
  margin-bottom: var(--spacing-xl);
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
  padding: var(--spacing-xl);
  border-radius: var(--radius-large);
  color: white;
  position: relative;
  overflow: hidden;
}

.header-content::before {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
  border-radius: 50%;
  transform: translate(50%, -50%);
}

.header-title {
  z-index: 1;
}

.title {
  font-size: var(--font-size-xxxl);
  font-weight: var(--font-weight-bold);
  margin: 0 0 var(--spacing-sm) 0;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.subtitle {
  font-size: var(--font-size-lg);
  opacity: 0.9;
  margin: 0;
  font-weight: var(--font-weight-normal);
}

.header-actions {
  z-index: 1;
}

/* 内容网格 */
.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: var(--spacing-xl);
}

@media (max-width: 1200px) {
  .content-grid {
    grid-template-columns: 1fr;
  }
}

/* 现代化卡片 */
.modern-card {
  background: var(--bg-primary);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-light);
  border: 1px solid var(--border-light);
  transition: all var(--transition-base);
  position: relative;
  overflow: hidden;
}

.modern-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: var(--primary-gradient);
  opacity: 0;
  transition: opacity var(--transition-base);
}

.modern-card:hover::before {
  opacity: 1;
}

.card-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
  padding: var(--spacing-xl);
  border-bottom: 1px solid var(--border-light);
  background: linear-gradient(135deg, var(--bg-primary) 0%, var(--bg-tertiary) 100%);
}

.header-icon {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-base);
  background: var(--primary-gradient);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  box-shadow: var(--shadow-base);
}

.header-icon.security {
  background: linear-gradient(135deg, var(--warning-color) 0%, var(--warning-light) 100%);
}

.header-text {
  flex: 1;
}

.card-title {
  font-size: var(--font-size-xl);
  font-weight: var(--font-weight-semibold);
  color: var(--text-primary);
  margin: 0 0 var(--spacing-xs) 0;
}

.card-subtitle {
  font-size: var(--font-size-sm);
  color: var(--text-secondary);
  margin: 0;
  line-height: var(--line-height-base);
}

.card-content {
  padding: var(--spacing-xl);
}

/* 头像区域 */
.avatar-section {
  display: flex;
  justify-content: center;
  margin-bottom: var(--spacing-xl);
}

.avatar-container {
  position: relative;
  display: inline-block;
}

.user-avatar {
  border: 4px solid var(--border-light);
  box-shadow: var(--shadow-base);
  transition: all var(--transition-base);
}

.avatar-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  border-radius: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
  opacity: 0;
  transition: opacity var(--transition-base);
  cursor: pointer;
  font-size: var(--font-size-sm);
  gap: var(--spacing-xs);
}

.avatar-container:hover .avatar-overlay {
  opacity: 1;
}

/* 表单区域 */
.form-section {
  margin-bottom: var(--spacing-xl);
}

.modern-form {
  --el-form-label-font-size: var(--font-size-sm);
  --el-form-label-font-weight: var(--font-weight-medium);
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: var(--spacing-lg);
}

@media (max-width: 768px) {
  .form-grid {
    grid-template-columns: 1fr;
  }
}

.form-item-modern {
  margin-bottom: 0;
}

.form-item-modern.full-width {
  grid-column: 1 / -1;
}

.modern-input {
  --el-input-border-radius: var(--radius-base);
  --el-input-border-color: var(--border-light);
  --el-input-hover-border-color: var(--primary-color);
  --el-input-focus-border-color: var(--primary-color);
}

:deep(.modern-input .el-input__wrapper) {
  border-radius: var(--radius-base);
  box-shadow: var(--shadow-light);
  transition: all var(--transition-base);
}

:deep(.modern-input .el-input__wrapper:hover) {
  box-shadow: var(--shadow-base);
  transform: translateY(-1px);
}

:deep(.modern-input .el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 3px rgba(64, 158, 255, 0.1);
  transform: translateY(-1px);
}

.option-content {
  display: flex;
  align-items: center;
  gap: var(--spacing-sm);
}

/* 编辑操作按钮 */
.edit-actions {
  display: flex;
  gap: var(--spacing-md);
  justify-content: flex-end;
  padding-top: var(--spacing-lg);
  border-top: 1px solid var(--border-light);
  margin-top: var(--spacing-lg);
}

/* 账户安全区域 */
.security-list {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-md);
}

.security-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--spacing-lg);
  background: var(--bg-tertiary);
  border-radius: var(--radius-large);
  border: 1px solid var(--border-light);
  transition: all var(--transition-base);
}

.security-item:hover {
  background: var(--bg-quaternary);
  transform: translateX(4px);
  box-shadow: var(--shadow-base);
}

.security-info {
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
  flex: 1;
}

.security-icon {
  width: 40px;
  height: 40px;
  border-radius: var(--radius-base);
  background: var(--bg-primary);
  border: 1px solid var(--border-light);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  color: var(--text-secondary);
}

.security-details {
  flex: 1;
}

.security-title {
  font-size: var(--font-size-base);
  font-weight: var(--font-weight-medium);
  color: var(--text-primary);
  margin: 0 0 var(--spacing-xs) 0;
}

.security-desc {
  font-size: var(--font-size-sm);
  color: var(--text-secondary);
  margin: 0;
  line-height: var(--line-height-base);
}

.security-status {
  display: flex;
  align-items: center;
  gap: var(--spacing-md);
}

.security-action {
  display: flex;
  align-items: center;
  gap: var(--spacing-xs);
  color: var(--primary-color);
  font-weight: var(--font-weight-medium);
  transition: all var(--transition-base);
}

.security-action:hover {
  color: var(--primary-dark);
  transform: translateX(2px);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .modern-personal-info {
    padding: var(--spacing-md);
  }
  
  .header-content {
    flex-direction: column;
    gap: var(--spacing-lg);
    text-align: center;
  }
  
  .title {
    font-size: var(--font-size-xxl);
  }
  
  .security-item {
    flex-direction: column;
    align-items: flex-start;
    gap: var(--spacing-md);
  }
  
  .security-status {
    flex-direction: column;
    align-items: flex-start;
    gap: var(--spacing-sm);
  }
}

@media (max-width: 480px) {
  .card-content {
    padding: var(--spacing-lg);
  }
  
  .edit-actions {
    flex-direction: column;
  }
}

/* 动画效果 */
.modern-personal-info {
  animation: fadeIn 0.6s ease-out;
}

.info-section,
.security-section {
  animation: slideUp 0.6s ease-out;
}

.security-section {
  animation-delay: 0.2s;
}

/* 深色模式适配 */
.dark .modern-card {
  background: var(--bg-primary);
  border-color: var(--border-dark);
}

.dark .card-header {
  background: linear-gradient(135deg, var(--bg-primary) 0%, var(--bg-tertiary) 100%);
  border-bottom-color: var(--border-dark);
}

.dark .security-item {
  background: var(--bg-tertiary);
  border-color: var(--border-dark);
}

.dark .security-item:hover {
  background: var(--bg-quaternary);
}

.dark .security-icon {
  background: var(--bg-primary);
  border-color: var(--border-dark);
}

.personal-info {
  width: 100%;
}

/* 卡片样式 */
.info-card,
.security-card {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 基本信息部分 */
.info-content {
  padding: 20px 0;
}

.basic-info {
  display: flex;
  gap: 40px;
}

/* 头像部分 */
.avatar-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.user-avatar {
  width: 120px;
  height: 120px;
  font-size: 48px;
  cursor: pointer;
}

.avatar-actions {
  text-align: center;
}

/* 信息详情部分 */
.info-details {
  flex: 1;
}

/* 编辑操作按钮 */
.edit-actions {
  margin-top: 20px;
  text-align: right;
}

.edit-actions .el-button {
  margin-left: 12px;
}

/* 账户安全部分 */
.security-content {
  padding: 10px 0;
}

.security-title {
  font-size: 14px;
  color: #303133;
}

.security-status {
  font-size: 14px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .basic-info {
    flex-direction: column;
    gap: 20px;
  }
  
  .avatar-section {
    align-items: flex-start;
  }
  
  .el-row {
    display: block;
  }
  
  .el-col {
    width: 100%;
    margin-bottom: 10px;
  }
}
</style>