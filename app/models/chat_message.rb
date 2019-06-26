class ChatMessage < ApplicationRecord
	belongs_to :user
	belongs_to :chat_room, touch: true

	validates :content, presence: true
end
