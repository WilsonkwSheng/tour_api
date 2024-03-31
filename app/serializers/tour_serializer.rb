class TourSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :itineraries
  has_many :bookings
  has_many :images
end
