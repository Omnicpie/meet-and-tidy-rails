FactoryBot.define do
  factory :user do
    name { "Morty" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "top-secret" }
  end
end
