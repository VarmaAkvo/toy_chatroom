class RenameChatRoomsUsersToChatRoomUsers < ActiveRecord::Migration[6.0]
  def change
  	drop_table :chat_room_users
  	rename_table :chat_rooms_users, :chat_room_users
  end
end
