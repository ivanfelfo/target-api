json.conversations do
  json.array! @conversations do |conversation|
    json.partial! 'info', conversation: conversation
  end
end
