<template>
  <div class="ai-chat-container" v-if="shouldShowAiChat">
    <!-- 聊天窗口触发按钮 -->
    <div
      v-if="!isExpanded"
      class="chat-trigger-btn"
      :style="{ right: position.x + 'px', bottom: position.y + 'px' }"
      @click="toggleChat"
      style="z-index: 9999; position: fixed;"
      @mousedown="startDrag"
    >
      <i class="el-icon-chat-dot-round chat-icon" />
      <span class="chat-text">AI助手</span>
      <div v-if="unreadCount > 0" class="unread-badge">{{ unreadCount }}</div>
    </div>

    <!-- 聊天窗口主体 -->
    <div
      v-if="isExpanded"
      class="chat-window"
      :style="{
        right: position.x + 'px',
        bottom: position.y + 'px',
        width: width + 'px',
        height: height + 'px'
      }"
    >
      <!-- ✨ [新增] 左上角拖拽手柄 -->
      <div class="resize-handle" @mousedown="startResize"></div>

      <!-- 窗口标题栏 -->
      <div class="chat-header" @mousedown="startDrag">
        <div class="header-left">
          <i class="el-icon-service header-icon" />
          <span class="header-title">AI智能助手</span>
          <div class="status-indicator online"></div>
        </div>
        <div class="header-actions">
          <el-button
            type="text"
            icon="el-icon-minus"
            size="mini"
            @click="toggleChat"
            class="action-btn"
          />
          <el-button
            type="text"
            icon="el-icon-close"
            size="mini"
            @click="closeChat"
            class="action-btn"
          />
        </div>
      </div>

      <!-- 聊天消息区域 -->
      <div class="chat-messages" ref="messagesContainer">
        <div v-if="messages.length === 0" class="welcome-message">
          <div class="welcome-icon">🤖</div>
          <h3>欢迎使用AI智能助手</h3>
          <p>我可以帮助您解答问题、提供建议或进行对话</p>
          <div class="quick-actions">
            <el-button size="mini" type="primary" plain round @click="sendQuickMessage('你好，请介绍一下自己')">
              打个招呼
            </el-button>
            <el-button size="mini" type="success" plain round @click="sendQuickMessage('帮我写一份工作总结')">
              写作助手
            </el-button>
          </div>
        </div>

        <div
          v-for="(message, index) in messages"
          :key="index"
          :class="['message-item', message.type]"
        >
          <div class="message-avatar">
            <i :class="message.type === 'user' ? 'el-icon-user' : 'el-icon-service'" class="avatar-icon"></i>
          </div>
          <div class="message-content">
            <div class="message-bubble">
              <div v-if="message.type === 'ai' && message.isTyping" class="typing-text">
                {{ message.displayText }}
                <span class="typing-cursor">|</span>
              </div>
              <div v-else class="message-text" v-html="formatMessage(message.text)"></div>
            </div>
            <div class="message-time">{{ formatTime(message.timestamp) }}</div>
          </div>
        </div>

        <div v-if="isLoading" class="message-item ai">
          <div class="message-avatar">
            <i class="el-icon-service avatar-icon"></i>
          </div>
          <div class="message-content">
            <div class="message-bubble loading">
              <div class="loading-dots">
                <span></span>
                <span></span>
                <span></span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 输入区域 -->
      <div class="chat-input-area">
        <div class="input-container">
          <el-input
            v-model="inputMessage"
            type="textarea"
            :rows="inputRows"
            placeholder="输入消息... (Enter发送)"
            resize="none"
            @keydown.enter.native="handleKeyDown"
            @input="handleInput"
            ref="messageInput"
            class="message-input"
          />
          <div class="input-actions">
            <el-button
              type="primary"
              circle
              size="mini"
              icon="el-icon-s-promotion"
              :loading="isLoading"
              :disabled="!inputMessage.trim()"
              @click="sendMessage"
              class="send-btn"
            />
          </div>
        </div>
      </div>
    </div>

    <!-- 拖拽/缩放遮罩 -->
    <div v-if="isDragging || isResizing" class="drag-overlay" :style="{ cursor: isResizing ? 'nwse-resize' : 'move' }"></div>
  </div>
</template>

<script>
import request from '@/utils/request'
import MarkdownIt from 'markdown-it'

const md = new MarkdownIt()

export default {
  name: 'AiChat',
  data() {
    return {
      isExpanded: false,
      position: { x: 20, y: 20 },
      isDragging: false,
      dragStart: { mouseX: 0, mouseY: 0, initialX: 0, initialY: 0 },

      // ✨ [新增] 调整大小所需的状态
      isResizing: false,
      resizeStart: { mouseX: 0, mouseY: 0, initialW: 0, initialH: 0 },
      width: 360,
      height: 480,
      minWidth: 320,
      minHeight: 400,

      messages: [],
      inputMessage: '',
      inputRows: 1,
      isLoading: false,
      unreadCount: 0,
      typingSpeed: 1,
      currentTypingMessage: null
    }
  },
  computed: {
    shouldShowAiChat() {
      // 检查是否在登录页面
      const isLoginPage = this.$route.path === '/login'
      // 检查用户是否已登录
      const isLoggedIn = this.$store.getters.token

      // 只有在非登录页面且用户已登录时才显示AI助手
      return !isLoginPage && isLoggedIn
    }
  },
  watch: {
    // 监听路由变化，登录成功后重置位置到右下角并加载聊天历史
    '$route'(to, from) {
      if (from.path === '/login' && to.path !== '/login' && this.$store.getters.token) {
        this.resetPositionToBottomRight()
        // 登录成功后加载聊天历史
        this.$nextTick(() => {
          this.loadChatHistory()
        })
      }
    },
    // 监听用户token变化，切换账户时清空聊天记录并重新加载新用户的历史记录
    '$store.getters.token'(newToken, oldToken) {
      if (newToken !== oldToken) {
        // 先清空当前聊天记录
        this.messages = []
        this.unreadCount = 0

        if (newToken) {
          // 如果有新token（用户登录），重置位置并加载新用户的聊天历史
          this.resetPositionToBottomRight()
          // 延迟加载聊天历史，确保token已经更新
          this.$nextTick(() => {
            this.loadChatHistory()
          })
        }
      }
    }
  },
  mounted() {
    this.loadChatHistory()
    document.addEventListener('mousemove', this.handleMouseMove)
    document.addEventListener('mouseup', this.handleMouseUp)
    window.addEventListener('resize', this.handleWindowResize)
  },
  beforeDestroy() {
    document.removeEventListener('mousemove', this.handleMouseMove)
    document.removeEventListener('mouseup', this.handleMouseUp)
    window.removeEventListener('resize', this.handleWindowResize)
    if (this.currentTypingMessage) {
      clearInterval(this.currentTypingMessage.timer)
    }
  },
  methods: {
    toggleChat() {
      console.log('✅ toggleChat() 被调用，当前状态：', this.isExpanded)
      this.isExpanded = !this.isExpanded
      console.log('➡️ 修改后 isExpanded =', this.isExpanded)
      if (this.isExpanded) {
        this.unreadCount = 0
        this.$nextTick(() => {
          this.scrollToBottom()
          this.$refs.messageInput?.focus()
        })
      }
    },
    closeChat() {
      this.isExpanded = false
      this.saveChatHistory()
    },
    startDrag(event) {
      if (this.isResizing || event.target.closest('.action-btn') || event.target.closest('.resize-handle')) return
      this.isDragging = true
      this.dragStart = {
        mouseX: event.clientX,
        mouseY: event.clientY,
        initialX: this.position.x,
        initialY: this.position.y
      }
      event.preventDefault()
    },

    // ✨ [新增] 开始调整大小的方法
    startResize(event) {
      this.isResizing = true
      this.resizeStart = {
        mouseX: event.clientX,
        mouseY: event.clientY,
        initialW: this.width,
        initialH: this.height
      }
      event.stopPropagation() // 阻止事件冒泡到 chat-header 的 startDrag
      event.preventDefault()
    },

    handleMouseMove(event) {
      // --- 处理拖拽 ---
      if (this.isDragging) {
        const deltaX = event.clientX - this.dragStart.mouseX
        const deltaY = event.clientY - this.dragStart.mouseY
        const newX = this.dragStart.initialX - deltaX
        const newY = this.dragStart.initialY - deltaY
        const elWidth = this.isExpanded ? this.width : 120
        const elHeight = this.isExpanded ? this.height : 50
        const maxX = window.innerWidth - elWidth
        const maxY = window.innerHeight - elHeight
        this.position = {
          x: Math.max(20, Math.min(newX, maxX - 20)),
          y: Math.max(20, Math.min(newY, maxY - 20))
        }
        return;
      }

      // --- 处理调整大小 ---
      if (this.isResizing) {
        const deltaX = event.clientX - this.resizeStart.mouseX
        const deltaY = event.clientY - this.resizeStart.mouseY

        const newWidth = this.resizeStart.initialW - deltaX
        const newHeight = this.resizeStart.initialH - deltaY

        this.width = Math.max(this.minWidth, newWidth)
        this.height = Math.max(this.minHeight, newHeight)
      }
    },
    handleMouseUp() {
      this.isDragging = false
      this.isResizing = false
    },
    handleWindowResize() {
      const elWidth = this.isExpanded ? this.width : 120
      const elHeight = this.isExpanded ? this.height : 50
      const maxX = window.innerWidth - elWidth
      const maxY = window.innerHeight - elHeight
      this.position = {
        x: Math.min(this.position.x, maxX - 20),
        y: Math.min(this.position.y, maxY - 20)
      }
    },
    handleKeyDown(event) {
      if (event.shiftKey) return
      event.preventDefault()
      this.sendMessage()
    },
    handleInput() {
      const lines = this.inputMessage.split('\n').length
      this.inputRows = Math.min(Math.max(lines, 1), 4)
    },
    async sendMessage() {
      const userMessage = this.inputMessage.trim()
      if (!userMessage || this.isLoading) return
      this.inputMessage = ''
      this.inputRows = 1
      this.addMessage('user', userMessage)
      this.isLoading = true
      try {
        const response = await request({
          url: '/ai/chat',
          method: 'post',
          data: { message: userMessage }
        })
        if (response.code === 200 && response.data?.reply) {
          this.addAiMessageWithTyping(response.data.reply)
        } else {
          this.addMessage('ai', '抱歉，我现在无法回答您的问题，请稍后再试。')
        }
      } catch (error) {
        console.error('AI聊天请求失败:', error)
        this.addMessage('ai', '网络连接异常，请检查网络后重试。')
      } finally {
        this.isLoading = false
      }
    },
    sendQuickMessage(message) {
      this.inputMessage = message
      this.sendMessage()
    },
    addMessage(type, text) {
      // 确保text是字符串类型
      const messageText = typeof text === 'string' ? text : String(text || '')
      const message = {
        type,
        text: messageText,
        timestamp: new Date(),
        isTyping: false,
        displayText: ''
      }
      this.messages.push(message)
      this.$nextTick(this.scrollToBottom)
      if (!this.isExpanded && type === 'ai') this.unreadCount++
      this.saveChatHistory()
    },
    addAiMessageWithTyping(text) {
      // 确保text是字符串类型
      const messageText = typeof text === 'string' ? text : String(text || '')
      const message = {
        type: 'ai',
        text: messageText,
        timestamp: new Date(),
        isTyping: true,
        displayText: ''
      }
      this.messages.push(message)
      this.$nextTick(this.scrollToBottom)
      this.startTypingEffect(message)
    },
    startTypingEffect(message) {
      let index = 0
      message.timer = setInterval(() => {
        if (index < message.text.length) {
          message.displayText += message.text[index]
          index++
          this.$nextTick(this.scrollToBottom)
        } else {
          message.isTyping = false
          clearInterval(message.timer)
          this.currentTypingMessage = null
          this.saveChatHistory()
        }
      }, this.typingSpeed)
      this.currentTypingMessage = message
    },
    scrollToBottom() {
      const container = this.$refs.messagesContainer
      if (container) container.scrollTop = container.scrollHeight
    },
    formatTime(timestamp) {
      const now = new Date()
      const time = new Date(timestamp)
      if (now - time < 60000) return '刚刚'
      if (now.toDateString() === time.toDateString()) {
        return time.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit', second: '2-digit' })
      }
      return time.toLocaleDateString('zh-CN') + ' ' + time.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit', second: '2-digit' })
    },
    formatMessage(text) {
      // 类型检查：确保输入是字符串类型
      if (typeof text !== 'string') {
        console.warn('formatMessage收到非字符串类型的数据:', typeof text, text)
        return text || '' // 如果不是字符串，返回空字符串或原值的字符串形式
      }

      // 空字符串检查
      if (!text || text.trim() === '') {
        return ''
      }

      try {
        return md.render(text)
      } catch (error) {
        console.error('MarkdownIt渲染失败:', error, '原始文本:', text)
        // 如果Markdown渲染失败，返回原始文本（进行HTML转义）
        return text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      }
    },
    // 重置位置到右下角
    resetPositionToBottomRight() {
      this.position = { x: 20, y: 20 }
      this.saveChatHistory()
    },
    // 清空聊天记录
    clearChatHistory() {
      this.messages = []
      this.unreadCount = 0
      // 移除本地存储的聊天记录（如果有的话）
      localStorage.removeItem('ai-chat-history')
      // 调用后端API清空聊天记录
      request({
        url: '/ai/history',
        method: 'delete'
      }).then(response => {
        if (response.code === 200) {
          console.log('聊天记录已从后端清空')
        }
      }).catch(error => {
        console.error('清空聊天记录失败:', error)
      })
    },
    saveChatHistory() {
      // 只保存位置和窗口大小到localStorage，聊天记录由后端自动保存
      localStorage.setItem('ai-chat-position', JSON.stringify(this.position))
      localStorage.setItem('ai-chat-size', JSON.stringify({ width: this.width, height: this.height }))

      // 注意：聊天记录现在由后端在每次对话时自动保存到Redis，无需前端手动保存
    },
    loadChatHistory() {
      // 如果用户未登录，不加载聊天记录
      if (!this.$store.getters.token) {
        return
      }

      try {
        // 从后端Redis加载聊天历史记录
        request({
          url: '/ai/history',
          method: 'get'
        }).then(response => {
          if (response.code === 200 && response.data && response.data.messages) {
            this.messages = response.data.messages.map(msg => ({
              ...msg,
              // 确保text字段是字符串类型
              text: msg.text || msg.content || '',
              timestamp: new Date(msg.timestamp),
              isTyping: false,
              displayText: msg.text || msg.content || ''
            }))

          } else {
            this.messages = []
          }

          // 加载位置信息（仍从localStorage获取）
          const position = localStorage.getItem('ai-chat-position')
          if (position) this.position = JSON.parse(position)

          // 加载窗口大小（仍从localStorage获取）
          const size = localStorage.getItem('ai-chat-size')
          if(size) {
              const parsedSize = JSON.parse(size)
              this.width = parsedSize.width || 360
              this.height = parsedSize.height || 480
          }
        }).catch(error => {
          console.error('从后端加载聊天记录失败:', error)
          this.messages = []
        })
      } catch (error) {
        console.error('加载聊天记录失败:', error)
        this.messages = []
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

.ai-chat-container {
  position: fixed;
  z-index: 9999;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  // ✨ [新增] 移除内联 style，统一在这里管理
  .chat-trigger-btn {
    position: fixed; // 确保 position 在这里定义
    z-index: 9999;
  }
}

.chat-trigger-btn {
  width: 120px;
  height: 50px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 25px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  user-select: none;
  color: white;

  &:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
  }

  .chat-icon {
    font-size: 20px;
    margin-right: 8px;
    transition: transform 0.3s;
  }

  &:hover .chat-icon {
    transform: rotate(-15deg);
  }

  .chat-text {
    font-size: 15px;
    font-weight: 600;
  }

  .unread-badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background: #ff4757;
    color: white;
    border-radius: 10px;
    min-width: 20px;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: bold;
  }
}

.chat-window {
  position: fixed;
  // 移除固定的 width 和 height
  // width: 360px;
  // height: 480px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: opacity 0.3s, transform 0.3s;
  animation: slideUp 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
}

// ✨ [新增] 拖拽手柄样式
.resize-handle {
  position: absolute;
  top: 0;
  left: 0;
  width: 20px;
  height: 20px;
  cursor: nwse-resize;
  z-index: 10;
  // 添加一个可视化的标记，方便用户找到
  &::after {
    content: '';
    position: absolute;
    bottom: 2px;
    right: 2px;
    width: 8px;
    height: 8px;
    border-bottom: 2px solid rgba(255, 255, 255, 0.5);
    border-right: 2px solid rgba(255, 255, 255, 0.5);
    transform: rotate(180deg); // 手柄指向左上
  }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.chat-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 12px 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: move;
  user-select: none;

  .header-left {
    display: flex;
    align-items: center;

    .header-icon {
      font-size: 18px;
      margin-right: 8px;
    }

    .header-title {
      font-size: 14px;
      font-weight: 600;
      margin-right: 8px;
    }

    .status-indicator {
      width: 8px;
      height: 8px;
      border-radius: 50%;

      &.online {
        background: #2ed573;
        box-shadow: 0 0 0 2px rgba(46, 213, 115, 0.3);
      }
    }
  }

  .header-actions {
    display: flex;
    gap: 4px;

    .action-btn {
      color: white;
      padding: 4px;

      &:hover {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 4px;
      }
    }
  }
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
  background: #f8f9fa;

  &::-webkit-scrollbar {
    width: 4px;
  }

  &::-webkit-scrollbar-track {
    background: transparent;
  }

  &::-webkit-scrollbar-thumb {
    background: #ddd;
    border-radius: 2px;
  }
}

.welcome-message {
  text-align: center;
  padding: 40px 20px;
  color: #666;

  .welcome-icon {
    font-size: 48px;
    margin-bottom: 16px;
  }

  h3 {
    margin: 0 0 8px 0;
    color: #333;
    font-size: 18px;
  }

  p {
    margin: 0 0 20px 0;
    font-size: 14px;
    line-height: 1.5;
  }

  .quick-actions {
    display: flex;
    gap: 8px;
    justify-content: center;
    flex-wrap: wrap;
  }
}

.message-item {
  display: flex;
  margin-bottom: 20px;
  animation: fadeIn 0.5s ease-out forwards;

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }

  &.user {
    flex-direction: row-reverse;

    .message-content {
      align-items: flex-end;

      .message-bubble {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
      }
    }

    .message-avatar {
      background-color: #e3e7fc;
      color: #667eea;
    }
  }

  &.ai {
    .message-bubble {
      background: white;
      color: #333;
      border: 1px solid #e1e8ed;
    }

    .message-avatar {
      background-color: #f1f3f5;
      color: #868e96;
    }
  }
}

.message-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: #e9ecef;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 10px;
  flex-shrink: 0;
  color: #495057;

  .avatar-icon {
    font-size: 18px;
  }
}

.message-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  max-width: calc(100% - 60px);
}

.message-bubble {
  padding: 12px 16px;
  border-radius: 18px;
  word-wrap: break-word;
  line-height: 1.4;
  font-size: 14px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);

  ::v-deep {
    p {
      margin: 0;
      &:not(:last-child) {
        margin-bottom: 0.5em;
      }
    }
    ul, ol {
      padding-left: 20px;
    }
    code {
      background-color: #f1f3f5;
      padding: 0.2em 0.4em;
      border-radius: 4px;
      font-size: 0.9em;
    }
    pre {
      background-color: #212529;
      color: #f8f9fa;
      padding: 1em;
      border-radius: 8px;
      overflow-x: auto;
      code {
        background-color: transparent;
        padding: 0;
      }
    }
  }
}

.message-time {
  font-size: 11px;
  color: #999;
  margin-top: 4px;
  padding: 0 4px;
}

.typing-text {
  .typing-cursor {
    animation: blink 1s infinite;
  }
}

@keyframes blink {
  0%, 50% { opacity: 1; }
  51%, 100% { opacity: 0; }
}

.loading-dots {
  display: flex;
  gap: 4px;

  span {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #999;
    animation: bounce 1.4s infinite ease-in-out both;

    &:nth-child(1) { animation-delay: -0.32s; }
    &:nth-child(2) { animation-delay: -0.16s; }
  }
}

@keyframes bounce {
  0%, 80%, 100% {
    transform: scale(0);
  }
  40% {
    transform: scale(1);
  }
}

.chat-input-area {
  border-top: 1px solid #e1e8ed;
  background: white;
  padding: 10px 12px;
}

.input-container {
  display: flex;
  gap: 8px;
  align-items: flex-end;
}

.message-input {
  flex: 1;

  ::v-deep .el-textarea__inner {
    border: none;
    background-color: #f1f3f5;
    border-radius: 20px;
    padding: 10px 18px;
    font-size: 14px;
    line-height: 1.5;
    color: #343a40;

    &::placeholder {
      color: #adb5bd;
    }

    &:focus {
      border: none;
      background-color: #e9ecef;
      box-shadow: none;
    }
  }
}

.send-btn {
  width: 36px;
  height: 36px;
  font-size: 16px;
  transition: all 0.2s;

  &:hover:not(.is-disabled) {
    transform: scale(1.1);
  }
}

.drag-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 9998;
}

@media (max-width: 768px) {
  .chat-window {
    width: calc(100vw - 20px);
    height: calc(100vh - 40px);
    right: 10px !important;
    bottom: 10px !important;
  }

  .chat-trigger-btn {
    width: 60px;
    height: 60px;
    border-radius: 50%;

    .chat-text {
      display: none;
    }
  }
}
</style>
