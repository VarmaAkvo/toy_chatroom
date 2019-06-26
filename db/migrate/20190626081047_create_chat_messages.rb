class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
    	t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :chat_room, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
