class Tour < ApplicationRecord
  belongs_to :tour_host
  has_many :itineraries, dependent: :destroy
  has_many :bookings, dependent: :destroy
  accepts_nested_attributes_for :itineraries, allow_destroy: true

  validates :title, :description, :region, :city, :travel_type, presence: true
end
