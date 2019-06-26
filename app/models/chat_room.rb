class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chat_messages, dependent: :destroy

  validates :name, presence: true
end
