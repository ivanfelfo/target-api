json.conversations do
  json.array! @conversations do |conversation|
    json.partial! 'info', conversation: conversation
    json.unread_messages_count conversation.messages.unread.count
  end
end
