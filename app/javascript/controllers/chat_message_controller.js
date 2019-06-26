import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["submit", "textarea"]

  check_blank(e) {
    // 如果聊天信息只包含空格，则不发送请求到服务器，并且弹出警告
    let chat_message_content = this.textareaTarget.value.trim()
    if (chat_message_content.length == 0) {
      e.preventDefault()
      alert("Message cannot be blank.")
    }
  }
  // Ctrl+Enter 直接发送
  send_message(e) {
    if (e.ctrlKey && e.keyCode == 13) {
      this.submitTarget.click()
    }
  }
}