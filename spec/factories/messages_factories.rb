FactoryBot.define do
  factory :message do
    message { Faker::Lorem.sentence }
    association :user, factory: :user
    association :conversation, factory: :conversation
  end
end
