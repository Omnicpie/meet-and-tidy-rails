FactoryBot.define do
  factory :event_type do
    sequence(:name) { |n| "Type #{n}" }
  end
end
