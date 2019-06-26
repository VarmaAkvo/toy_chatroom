require 'test_helper'

class ChatMessageTest < ActiveSupport::TestCase
	setup do
		@chat_message = chat_messages(:one)
	end

  test 'should be true' do
    assert @chat_message.valid?
  end

  test 'content should be present' do
  	@chat_message.content = ''
  	assert_not @chat_message.valid?
  end
end
