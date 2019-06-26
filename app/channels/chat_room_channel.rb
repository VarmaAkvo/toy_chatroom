class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
     stream_from "ChatRoomChannel:#{params[:chat_room_id]}"
  end

  def unsubscribed
  	stop_all_streams
  end
end
