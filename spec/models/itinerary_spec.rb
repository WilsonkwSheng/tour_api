require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  describe 'validations' do
    it { should belong_to(:tour) }
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_at) }
    it { should validate_presence_of(:end_at) }

    describe '#start_at_before_end_at' do
      let!(:tour) { create(:tour) }
      let(:itinerary) { build(:itinerary, tour: tour, start_at: Time.current, end_at: Time.current - 1.second) }

      it 'ensures start_at is before end_at' do
        expect(itinerary).not_to be_valid
        expect(itinerary.errors[:start_at]).to include('must be before end time')
      end
    end

    describe '#start_at_before_end_at' do
      let!(:tour) { create(:tour) }
      let!(:existing_itinerary) { create(:itinerary, tour: tour, day: :monday, date: Date.today, start_at: Time.current, end_at: Time.current + 1.hour) }

      context 'no overlap' do
        let!(:non_overlapping_itinerary) { build(:itinerary, tour: tour, day: :monday, date: Date.today, start_at: existing_itinerary.start_at - 1.hour, end_at: existing_itinerary.start_at - 1.second) }

        it do
          expect(non_overlapping_itinerary).to be_valid
        end
      end

      context 'overlapped' do
        let!(:overlapping_itinerary) { build(:itinerary, tour: tour, day: :monday, date: Date.today, start_at: existing_itinerary.start_at + 1.second, end_at: existing_itinerary.end_at) }

        it do
          expect(overlapping_itinerary).not_to be_valid
          expect(overlapping_itinerary.errors[:base]).to include('Itineraries cannot overlap within the same day and date')
        end
      end
    end
  end
end