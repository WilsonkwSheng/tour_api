FactoryBot.define do
  factory :tour do
    title { Faker::Lorem::sentence }
    description { Faker::Lorem::paragraph }
    region { Faker::Lorem::sentence }
    city { Faker::Lorem::sentence }
    travel_type { Faker::Lorem::sentence }
    tour_host
  end
end
