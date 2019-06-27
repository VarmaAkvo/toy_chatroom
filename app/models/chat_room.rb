class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chat_messages, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  validates :name, presence: true
end
