class ChatMessagesController < ApplicationController
	def create
		@chat_room = ChatRoom.find(params[:chat_room_id])
		@chat_message = current_user.chat_messages.build(
			content: params[:chat_message][:content], 
			chat_room: @chat_room )
		if @chat_message.save
			redirect_to @chat_room
		else
			flash[:alert] = '内容不能为空。'
			@chat_messages = @chat_room.
			redirect_to @chat_room
		end
	end
end
