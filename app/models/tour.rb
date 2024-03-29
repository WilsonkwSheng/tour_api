class Tour < ApplicationRecord
  belongs_to :tour_host

  validates :title, :description, :region, :city, :travel_type, presence: true
end
