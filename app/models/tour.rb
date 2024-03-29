class Tour < ApplicationRecord
  belongs_to :tour_host
  has_many :itineraries, dependent: :destroy

  validates :title, :description, :region, :city, :travel_type, presence: true
end
