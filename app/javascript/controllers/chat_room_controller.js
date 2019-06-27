import { Controller } from "stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = [ "messages", "textarea" ]

  connect() {
  	let thisControler = this;
  	this.chatRoomChannel = createConsumer().subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: this.data.get('id')}, {
		  received(data) {
		  	// 插入信息
		  	thisControler.messagesTarget.insertAdjacentHTML('beforeend', data["new_message"])
		    //清除输入框
	      thisControler.textareaTarget.value = ""
	      // 拉到聊天区底部
	      thisControler.messagesTarget.scrollTop = thisControler.messagesTarget.scrollHeight
		  },

      stop() {
        this.perform('stop')
      }
		});
		// 非房主才订阅该channel
		if (this.data.get('owner') == "false") {
			this.destroyChatRoomChannel = createConsumer().subscriptions.create({ channel: "DestroyChatRoomChannel", chat_room_id: this.data.get('id')}, {
				received(data) {
					alert("房主已强制关闭该房间。")
					window.location.assign(data["url"])
				},

        stop() {
          this.perform('stop')
        }
			});
		}
		// 拉到聊天区底部
	  this.messagesTarget.scrollTop = thisControler.messagesTarget.scrollHeight
  }

  disconnect() {
    if (this.chatRoomChannel) {
      this.chatRoomChannel.stop()
    }
    if (this.destroyChatRoomChannel) {
      this.destroyChatRoomChannel.stop()
    }
  }
}
