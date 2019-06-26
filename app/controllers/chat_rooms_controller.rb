class ChatRoomsController < ApplicationController
	def index
		@chat_rooms = ChatRoom.all
	end

	def new
		@chat_room = current_user.chat_rooms.build
	end

	def show
		@chat_room = ChatRoom.find(params[:id])
	end

	def create
		@chat_room = current_user.chat_rooms.build(name: params[:chat_room][:name])
		if @chat_room.save
			redirect_to root_path
		else
			flash.now[:alert] = '房间创建失败。'
			render 'new'
		end
	end

	def destroy
		@chat_room = ChatRoom.find(params[:id])
		if @chat_room.user == current_user
			@chat_room.destroy
			redirect_to root_path
		else
			flash.now[:alert] = '你没有权限进行该操作。'
			render 'show'
		end
	end
end
