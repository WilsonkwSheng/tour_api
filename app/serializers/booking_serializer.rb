class BookingSerializer < ActiveModel::Serializer
  attributes :id, :tour_id, :customer_id
end
