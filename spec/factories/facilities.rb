FactoryBot.define do
  factory :facility do
    sequence(:name) { |n| "Type #{n}" }
  end
end
