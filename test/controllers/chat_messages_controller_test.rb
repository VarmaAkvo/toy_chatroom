require 'test_helper'

class ChatMessagesControllerTest < ActionDispatch::IntegrationTest
  test 'should create a message' do 
  	sign_in @user = users(:one)
  	assert_difference('ChatMessage.count') do
  		post  chat_room_chat_messages_path(@chat_room = chat_rooms(:one)), params: {
        chat_message: { content: 'content'}
      }
    end
  end
end
