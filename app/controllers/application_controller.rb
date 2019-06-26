class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :set_my_rooms, if: :user_signed_in?

	layout :select_layout

  private

  def set_my_rooms
    @my_rooms = current_user.joined_chat_rooms
  end

  def select_layout
    current_user.nil? ? 'unlogin' : 'application'
  end
end
