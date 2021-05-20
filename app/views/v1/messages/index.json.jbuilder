json.messages do
  json.array! @messages
end

json.pagy do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end
