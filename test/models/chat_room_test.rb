require 'test_helper'

class ChatRoomTest < ActiveSupport::TestCase
  setup do
  	@chatroom = chat_rooms(:one)
  end

  test 'should be true' do
  	assert @chatroom.valid?
  end

  test 'name should be present' do
  	@chatroom.name = ''
  	assert_not @chatroom.valid?
  end
end
