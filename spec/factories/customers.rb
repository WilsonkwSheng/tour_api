FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email(name: Faker::Name.first_name) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
