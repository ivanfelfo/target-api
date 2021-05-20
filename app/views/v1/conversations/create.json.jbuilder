json.conversation do
  json.id @conversation.id
  json.topic @conversation.topic.name
  json.user_id1 @conversation.user_id1
  json.user_id2 @conversation.user_id2
  json.read @conversation.read
end
