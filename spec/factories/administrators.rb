FactoryBot.define do
  factory :administrator do
    password { %w[love secret sex god].shuffle.join }
    sequence(:email) { |n| "admin#{n}@example.com" }
    sequence(:name) { |n| "Admin #{n}" }
  end
end
