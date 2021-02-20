FactoryBot.define do
  factory :administrator do
    sequence(:name) { |n| "Admin #{n}" }
  end
end
