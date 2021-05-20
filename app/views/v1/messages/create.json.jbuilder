json.message do
  json.id @message.id
  json.user_id @message.user_id
  json.message @message.message
  json.conversation_id @message.conversation_id
end
