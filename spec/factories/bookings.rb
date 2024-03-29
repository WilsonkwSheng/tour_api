FactoryBot.define do
  factory :booking do
    association :customer
    association :tour
  end
end
