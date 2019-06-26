import { Controller } from "stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = [ "messages", "textarea" ]

  connect() {
  	let thisControler = this;
  	this.channel = createConsumer().subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: this.data.get('id')}, {
		  connected() {
		    // Called when the subscription is ready for use on the server
		  },

		  disconnected() {
		    // Called when the subscription has been terminated by the server
		  },

		  received(data) {
		  	// 插入信息
		  	thisControler.messagesTarget.insertAdjacentHTML('beforeend', data["new_message"])
		    //清除输入框
	      thisControler.textareaTarget.value = ""
	      // 拉到聊天区底部
	      thisControler.messagesTarget.scrollTop = thisControler.messagesTarget.scrollHeight
		  }
		});
		// 拉到聊天区底部
	  this.messagesTarget.scrollTop = thisControler.messagesTarget.scrollHeight
  }
}