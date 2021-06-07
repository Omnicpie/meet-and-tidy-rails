FactoryBot.define do
  factory :mess_type do
    sequence(:name) { |n| "Type #{n}" }
  end
end
