FactoryBot.define do
  factory :itinerary do
    association :tour
    date { Date.current }
    day { 0 }
    start_at { Time.current }
    end_at { Time.current + 1.hour }
    title { Faker::Lorem::sentence }
    description { Faker::Lorem::paragraph }
  end
end
