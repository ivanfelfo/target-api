# This will guess the User class
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
    gender { rand(0..3) }
  end
end
