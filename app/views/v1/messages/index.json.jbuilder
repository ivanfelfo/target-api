json.messages do
  json.array! @messages do |message|
    json.partial! 'info', message: message
  end
end

json.pagy do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end
