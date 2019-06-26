class ChatMessagesController < ApplicationController
	def create
		@chat_room = ChatRoom.find(params[:chat_room_id])
		@chat_message = current_user.chat_messages.build(
			content: params[:chat_message][:content], 
			chat_room: @chat_room )
		if @chat_message.save
			new_message = render_to_string(partial: 'chat_messages/chat_message', locals: {chat_message: @chat_message})
			ActionCable.server.broadcast("ChatRoomChannel:#{params[:chat_room_id]}", new_message: new_message)
			ActionCable.server.broadcast("NewMessagesChannel:#{params[:chat_room_id]}", new_message: true)
		end
	end
end
