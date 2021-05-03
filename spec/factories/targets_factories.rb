FactoryBot.define do
  factory :target do
    title { Faker::Lorem.sentence }
    radius { Faker::Number.decimal(2, 3) }
    lat { Faker::Number.decimal(2, 3) }
    lon { Faker::Number.decimal(2, 3) }
    user
    topic
  end
end
