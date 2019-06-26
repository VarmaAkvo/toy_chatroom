import { Controller } from "stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = [ "link" ]

  connect() {
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
		  }
		});
  }
}