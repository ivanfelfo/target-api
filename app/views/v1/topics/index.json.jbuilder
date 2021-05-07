json.topics do
  json.array! @topics
end

json.pagy do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end
