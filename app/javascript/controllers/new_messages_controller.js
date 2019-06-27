import { Controller } from "stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = [ "link" ]

  connect() {
  	// 当在该房间中时不订阅其新信息频道
  	let chatRoom = document.querySelector("[data-controller='chat-room']")
  	if (!(chatRoom && chatRoom.getAttribute('data-chat-room-id') == this.data.get('id'))) {
	  	let thisControler = this;
	  	this.channel = createConsumer().subscriptions.create({ channel: "NewMessagesChannel", chat_room_id: this.data.get('id')}, {
			  connected() {
			    // Called when the subscription is ready for use on the server
			  },

			  disconnected() {
			    // Called when the subscription has been terminated by the server
			  },

			  received(data) {
			  	thisControler.linkTarget.classList.add('new_messages')
			  },

        stop() {
          this.perform('stop')
        }
			});
  	}
  }

  disconnect() {
    if (this.channel) {
      this.channel.stop()
    }
  }
}
