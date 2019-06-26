class CreateJoinTableChatRoomUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :chat_rooms, :users do |t|
    	t.index :chat_room_id
    	t.index :user_id
      t.index [:chat_room_id, :user_id], unique: true
    end
  end
end
