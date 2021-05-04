FactoryBot.define do
  factory :target do
    title { Faker::Lorem.sentence }
    radius { Faker::Number.decimal(2, 3) }
    longitude { Faker::Number.decimal(l_digits: 2, r_digits: 3) }
    latitude { Faker::Number.decimal(l_digits: 2, r_digits: 3) }
    association :user, factory: :user
    association :topic, factory: :topic
  end
end
