class AddUniqueIndexToChatRoomUsers < ActiveRecord::Migration[6.0]
  def change
  	add_index :chat_room_users, [:chat_room_id, :user_id], unique: true
  end
end
