FactoryBot.define do
  factory :mess do
    sequence(:title) { |n| "Mess #{n}" }
  end
end
