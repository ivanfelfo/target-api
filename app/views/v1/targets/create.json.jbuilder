json.target do
  json.id @target.id
  json.title @target.title
  json.user_id @target.user_id
  json.topic_id @target.topic_id
  json.radius @target.radius
  json.latitude @target.latitude
  json.longitude @target.longitude
  json.description @target.description
end
