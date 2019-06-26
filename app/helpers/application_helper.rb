module ApplicationHelper
  def sidebar_link(room)
    link_class = 'list-group-item list-group-item-action'
    link_id = "new_messages_from_chat_room_#{room.id}"
    link_to room.name, chat_room_path(room), class: link_class, id: link_id, remote: true
  end
end
