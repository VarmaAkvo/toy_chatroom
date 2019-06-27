require 'test_helper'

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest
	setup do
		sign_in(@user = users(:one))
		@chat_room = chat_rooms(:one)
	end
  
  test 'shoule get index' do
  	get root_path
  	assert_response :success
  end

  test 'should get new' do
    get new_chat_room_path
    assert_response :success
  end

  test 'should get show' do
  	get chat_room_path(@chat_room)
  	assert_response :success
    # 加入新房间
    assert_difference('ChatRoomUser.count') do
      get chat_room_path(chat_rooms(:two))
    end
  end

  test 'should create a chat_room' do
  	assert_difference('ChatRoom.count') do
  	 	post chat_rooms_path, params: {chat_room: {
  		  name: 'new room'
  	  }}
  	end

  	assert_equal @user, ChatRoom.last.user
  end

  test 'should destroy a chat_room' do
  	assert_equal @user, @chat_room.user
  	assert_difference('ChatRoom.count', -1) do
  		delete chat_room_path(@chat_room)
  	end
  	# 只有当前用户才能删除该房间
  	other_room = chat_rooms(:two)
  	assert_not_equal @user, other_room.user
   	assert_no_difference('ChatRoom.count') do
  		delete chat_room_path(other_room)
  	end 	
  end

  test 'should leave a chat_room' do
    assert_difference('ChatRoomUser.count', -1) do
      delete leave_chat_room_path(@chat_room)
    end
  end
end
