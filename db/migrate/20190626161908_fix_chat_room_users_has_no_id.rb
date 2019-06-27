class FixChatRoomUsersHasNoId < ActiveRecord::Migration[6.0]
  def change
  	drop_table :chat_room_users
  	#remove_index :chat_room_users, :user_id
  	#remove_index :chat_room_users, :chat_room_id
  	#remove_index :chat_room_users, [:chat_room_id, :user_id]
    create_table :chat_room_users do |t|
    	t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :chat_room, null: false, foreign_key: true

      t.timestamps
    end
    #add_index :chat_room_users, :user_id
    #add_index :chat_room_users, :chat_room_id
    #add_index [:chat_room_id, :user_id], unique: true
  end
end
