FactoryBot.define do
  factory :tour_host do
    name { Faker::Name.name }
    email { Faker::Internet.email(name: Faker::Name.first_name) }
    password { 'password' }
    password_confirmation { 'password' }
    description { nil }
  end
end
