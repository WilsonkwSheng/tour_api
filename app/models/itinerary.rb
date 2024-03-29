class Itinerary < ApplicationRecord
  belongs_to :tour
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images

  enum day: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  validates :day, :date, :start_at, :end_at, presence: true
  validate :start_at_before_end_at
  validate :no_overlapping_itineraries

  private

  def start_at_before_end_at
    if start_at.present? && end_at.present? && start_at >= end_at
      errors.add(:start_at, 'must be before end time')
    end
  end

  def no_overlapping_itineraries
    return if tour.blank?

    overlapping_itineraries = tour.itineraries.where(day: day, date: date).where.not(id: id)
    overlapping_itineraries.each do |existing_itinerary|
      if (start_at <= existing_itinerary.end_at) && (existing_itinerary.start_at <= end_at)
        errors.add(:base, 'Itineraries cannot overlap within the same day and date')
        break
      end
    end
  end
end