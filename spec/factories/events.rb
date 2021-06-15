FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "Event #{n}" }
    url { "www.google.com" }
    location { "Leeds" }
    description { "Some description" }
  end
end
