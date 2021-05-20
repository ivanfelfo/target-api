FactoryBot.define do
  factory :conversation do
    user_id1 { create(:user).id }
    user_id2 { create(:user).id }
    association :topic, factory: :topic
  end
end
