class Tour < ApplicationRecord
  belongs_to :tour_host
  has_many :itineraries, dependent: :destroy
  has_many :bookings, dependent: :destroy
  accepts_nested_attributes_for :itineraries, allow_destroy: true
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images

  validates :title, :description, :region, :city, :travel_type, presence: true
end
