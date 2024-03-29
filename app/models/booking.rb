class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :tour

  validates :customer_id, uniqueness: { scope: :tour_id }
end
