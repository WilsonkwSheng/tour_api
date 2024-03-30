class ItinerarySerializer < ActiveModel::Serializer
  attributes :id, :day, :date, :start_at, :end_at, :title, :description

  has_many :images
end
