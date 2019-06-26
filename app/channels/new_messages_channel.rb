class NewMessagesChannel < ApplicationCable::Channel
  def subscribed
     stream_from "NewMessagesChannel:#{params[:chat_room_id]}"
  end

  def unsubscribed
  	stop_all_streams
  end
end