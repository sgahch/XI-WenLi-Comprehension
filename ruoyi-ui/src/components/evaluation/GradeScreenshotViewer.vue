<template>
  <div class="grade-screenshot-viewer">
    <el-card class="viewer-card" shadow="hover">
      <div slot="header" class="card-header">
        <span>
          <i class="el-icon-view"></i>
          成绩截图核验
        </span>
        <el-tag v-if="screenshots.length === 0" type="info" size="small">
          学生未上传成绩截图
        </el-tag>
        <el-tag v-else type="success" size="small">
          已上传 {{ screenshots.length }} 张截图
        </el-tag>
      </div>

      <div v-if="screenshots.length === 0" class="empty-state">
        <i class="el-icon-picture-outline"></i>
        <p>该学生未上传成绩截图</p>
      </div>

      <div v-else class="viewer-content">
        <!-- 左侧：成绩截图展示 -->
        <div class="screenshot-section">
          <div class="section-title">
            <i class="el-icon-picture"></i>
            教务系统成绩截图
          </div>
          
          <el-carousel
            v-if="screenshots.length > 1"
            :interval="0"
            arrow="always"
            height="500px"
            indicator-position="outside"
          >
            <el-carousel-item v-for="(screenshot, index) in screenshots" :key="index">
              <div class="image-container">
                <el-image
                  :src="screenshot.url"
                  :preview-src-list="screenshotUrls"
                  fit="contain"
                  class="screenshot-image"
                >
                  <div slot="error" class="image-error">
                    <i class="el-icon-picture-outline"></i>
                    <p>图片加载失败</p>
                  </div>
                </el-image>
                <div class="image-info">
                  <span>{{ screenshot.originalName }}</span>
                  <span class="file-size">{{ formatFileSize(screenshot.fileSize) }}</span>
                </div>
              </div>
            </el-carousel-item>
          </el-carousel>

          <div v-else class="single-image">
            <el-image
              :src="screenshots[0].url"
              :preview-src-list="screenshotUrls"
              fit="contain"
              class="screenshot-image"
            >
              <div slot="error" class="image-error">
                <i class="el-icon-picture-outline"></i>
                <p>图片加载失败</p>
              </div>
            </el-image>
            <div class="image-info">
              <span>{{ screenshots[0].originalName }}</span>
              <span class="file-size">{{ formatFileSize(screenshots[0].fileSize) }}</span>
            </div>
          </div>
        </div>

        <!-- 右侧：提交的成绩数据 -->
        <div class="grade-data-section">
          <div class="section-title">
            <i class="el-icon-document"></i>
            学生提交的成绩数据
          </div>
          
          <div v-if="gradeData && gradeData.length > 0" class="grade-table">
            <el-table
              :data="gradeData"
              border
              stripe
              size="small"
              max-height="450"
            >
              <el-table-column
                prop="courseName"
                label="课程名称"
                min-width="120"
              />
              <el-table-column
                prop="courseCode"
                label="课程代码"
                width="100"
              />
              <el-table-column
                prop="credit"
                label="学分"
                width="70"
                align="center"
              />
              <el-table-column
                prop="score"
                label="成绩"
                width="80"
                align="center"
              >
                <template slot-scope="scope">
                  <el-tag
                    :type="getScoreTagType(scope.row.score)"
                    size="small"
                  >
                    {{ scope.row.score }}
                  </el-tag>
                </template>
              </el-table-column>
              <el-table-column
                prop="gradePoint"
                label="绩点"
                width="80"
                align="center"
              />
            </el-table>
          </div>

          <div v-else class="empty-grade-data">
            <i class="el-icon-document-remove"></i>
            <p>暂无成绩数据</p>
          </div>

          <!-- 核验提示 -->
          <div class="verification-tips">
            <el-alert
              title="核验提示"
              type="warning"
              :closable="false"
              show-icon
            >
              <p>请仔细对比左侧截图与右侧数据，确保：</p>
              <ul>
                <li>课程名称、课程代码一致</li>
                <li>成绩、学分、绩点准确无误</li>
                <li>截图清晰完整，无PS痕迹</li>
              </ul>
            </el-alert>
          </div>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import { getGradeScreenshots } from '@/api/evaluation/attachment'

export default {
  name: 'GradeScreenshotViewer',
  props: {
    // 详情ID
    detailId: {
      type: Number,
      required: true
    },
    // 成绩数据（用于对比）
    gradeData: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      screenshots: [],
      loading: false
    }
  },
  computed: {
    screenshotUrls() {
      return this.screenshots.map(item => item.url)
    }
  },
  watch: {
    detailId: {
      handler(val) {
        console.log('=== [GradeScreenshotViewer] detailId 变化 ===')
        console.log('新的 detailId:', val)
        if (val) {
          this.loadScreenshots()
        } else {
          console.warn('⚠️ detailId 为空，无法加载成绩截图')
        }
      },
      immediate: true
    }
  },
  methods: {
    // 加载成绩截图
    async loadScreenshots() {
      console.log('\n=== [GradeScreenshotViewer] 开始加载成绩截图 ===')

      if (!this.detailId) {
        console.warn('⚠️ detailId 为空，无法加载')
        return
      }

      console.log('智育维度 detailId:', this.detailId)
      console.log('请求接口: GET /evaluation/attachment/grade-screenshot/' + this.detailId)

      this.loading = true
      try {
        const response = await getGradeScreenshots(this.detailId)
        console.log('后端返回的原始响应:', response)

        if (response.code === 200) {
          this.screenshots = response.data || []
          console.log('✅ 成功加载成绩截图，数量:', this.screenshots.length)

          if (this.screenshots.length > 0) {
            console.log('成绩截图列表:')
            this.screenshots.forEach((screenshot, index) => {
              console.log(`  [${index + 1}] 文件名: ${screenshot.fileName || screenshot.originalName}`)
              console.log(`      URL: ${screenshot.url}`)
              console.log(`      文件大小: ${this.formatFileSize(screenshot.fileSize)}`)
              console.log(`      附件类型: ${screenshot.attachmentType}`)
              console.log(`      detailId: ${screenshot.detailId}`)
            })
          } else {
            console.warn('⚠️ 后端返回的成绩截图列表为空')
            console.log('可能的原因:')
            console.log('  1. 学生确实没有上传成绩截图')
            console.log('  2. detailId 不正确')
            console.log('  3. 附件的 attachmentType 不是 GRADE_SCREENSHOT')
            console.log('  4. 附件的 detailId 与当前 detailId 不匹配')
          }
        } else {
          console.error('❌ 后端返回错误:', response.msg)
        }
      } catch (error) {
        console.error('❌ 加载成绩截图失败:', error)
        console.error('错误详情:', error.response || error.message)
        this.$message.error('加载成绩截图失败')
      } finally {
        this.loading = false
        console.log('=== [GradeScreenshotViewer] 加载完成 ===\n')
      }
    },

    // 格式化文件大小
    formatFileSize(bytes) {
      if (!bytes) return '0 B'
      const k = 1024
      const sizes = ['B', 'KB', 'MB', 'GB']
      const i = Math.floor(Math.log(bytes) / Math.log(k))
      return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i]
    },

    // 获取成绩标签类型
    getScoreTagType(score) {
      if (score >= 90) return 'success'
      if (score >= 80) return ''
      if (score >= 70) return 'warning'
      if (score >= 60) return 'info'
      return 'danger'
    }
  }
}
</script>

<style scoped lang="scss">
.grade-screenshot-viewer {
  .viewer-card {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      span {
        font-size: 16px;
        font-weight: 500;
        
        i {
          color: #409EFF;
          margin-right: 8px;
        }
      }
    }
  }

  .empty-state {
    text-align: center;
    padding: 60px 0;
    color: #909399;
    
    i {
      font-size: 64px;
      margin-bottom: 16px;
    }
    
    p {
      font-size: 14px;
    }
  }

  .viewer-content {
    display: flex;
    gap: 24px;
    
    .screenshot-section,
    .grade-data-section {
      flex: 1;
      
      .section-title {
        font-size: 14px;
        font-weight: 500;
        color: #303133;
        margin-bottom: 16px;
        padding-bottom: 8px;
        border-bottom: 2px solid #DCDFE6;
        
        i {
          color: #409EFF;
          margin-right: 6px;
        }
      }
    }

    .screenshot-section {
      .image-container,
      .single-image {
        .screenshot-image {
          width: 100%;
          height: 450px;
          border: 1px solid #DCDFE6;
          border-radius: 4px;
          background: #F5F7FA;
        }

        .image-info {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-top: 12px;
          padding: 8px 12px;
          background: #F5F7FA;
          border-radius: 4px;
          font-size: 12px;
          color: #606266;
          
          .file-size {
            color: #909399;
          }
        }

        .image-error {
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          height: 100%;
          color: #C0C4CC;
          
          i {
            font-size: 48px;
            margin-bottom: 12px;
          }
        }
      }
    }

    .grade-data-section {
      .empty-grade-data {
        text-align: center;
        padding: 40px 0;
        color: #909399;
        
        i {
          font-size: 48px;
          margin-bottom: 12px;
        }
      }

      .verification-tips {
        margin-top: 16px;
        
        ::v-deep .el-alert {
          p {
            margin: 8px 0 4px;
            font-size: 13px;
          }
          
          ul {
            margin: 8px 0 0 20px;
            padding: 0;
            
            li {
              margin: 4px 0;
              font-size: 12px;
              line-height: 1.6;
            }
          }
        }
      }
    }
  }
}
</style>

