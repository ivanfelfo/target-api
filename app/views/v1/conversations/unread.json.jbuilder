json.conversations do
  json.array! @conversations do |conversation|
    json.id conversation.id
    json.user_id1 conversation.user_id1
    json.user_id2 conversation.user_id2
    json.unread_messages_count conversation.messages.unread.count
  end
end
