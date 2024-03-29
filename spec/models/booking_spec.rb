require 'rails_helper'

RSpec.describe Booking, type: :model do
  it { should belong_to(:tour) }
  it { should belong_to(:customer) }

  describe 'validations' do
    context 'valid booking' do
      let(:customer1) { create(:customer) }
      let(:customer2) { create(:customer) }
      let(:tour) { create(:tour) }
      let!(:booking1) { create(:booking, customer: customer1, tour: tour) }
      let(:booking2) { build(:booking, customer: customer2, tour: tour) }

      it 'allows different customers to book the same tour' do
        expect(booking2).to be_valid
      end
    end

    context 'invalid booking' do
      let(:customer) { create(:customer) }
      let(:tour) { create(:tour) }
      let!(:booking) { create(:booking, customer: customer, tour: tour) }
      let(:duplicate_booking) { build(:booking, customer: customer, tour: tour) }

      it 'ensures customer cannot book the same tour more than once' do
        expect(duplicate_booking).not_to be_valid
        expect(duplicate_booking.errors[:customer_id]).to include('has already booked this tour')
      end
    end
  end
end
