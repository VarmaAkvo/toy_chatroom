class ChatRoomsController < ApplicationController
	def index
		@chat_rooms = ChatRoom.all.includes(:user)
		@user_counts = ChatRoomUser.where(chat_room: @chat_rooms).group(:chat_room_id).count
		respond_to do |format|
			format.html { render 'index' }
		end
	end

	def new
		@chat_room = current_user.chat_rooms.build
	end

	def show
		@chat_room = ChatRoom.find(params[:id])
		# 如果当前用户还未加入该房间则加入
		current_user.chat_room_users.find_or_create_by(chat_room: @chat_room)
		@chat_message = current_user.chat_messages.build(chat_room: @chat_room)
		@chat_messages = @chat_room.chat_messages.includes(:user)
		respond_to do |format|
			format.html { render 'show' }
		end
	end

	def create
		@chat_room = current_user.chat_rooms.build(name: params[:chat_room][:name])
		if @chat_room.save
			current_user.chat_room_users.create(chat_room: @chat_room)
			@chat_message = current_user.chat_messages.build(chat_room: @chat_room)
			@chat_messages = @chat_room.chat_messages.includes(:user)
			redirect_to @chat_room
		else
			flash.now[:alert] = '房间创建失败。'
			render 'new'
		end
	end

	def destroy
		@chat_room = ChatRoom.find(params[:id])
		if @chat_room.user == current_user
			@chat_room.destroy
			# 强制其他在该房间的用户离开并重定向到首页
			ActionCable.server.broadcast("DestroyChatRoomChannel:#{@chat_room.id}", url: root_url)
			redirect_to root_path
		else
			flash.now[:alert] = '你没有权限进行该操作。'
			@chat_messages = @chat_room.chat_messages.includes(:user)
			@chat_message = current_user.chat_messages.build(chat_room: @chat_room)
			render 'show'
		end
	end

	def leave
		@chat_room = ChatRoom.find(params[:id])
		current_user.chat_room_users.find_by(chat_room: @chat_room).destroy
		redirect_to root_path
	end
end
