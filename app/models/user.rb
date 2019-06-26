class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :chat_rooms
  has_many :chat_messages, dependent: :destroy
  has_many :chat_room_users,  dependent: :destroy
  has_many :joined_chat_rooms, class_name: 'ChatRoom', through: :chat_room_users, source: :chat_room
end
