require 'rails_helper'

describe TourHost do
  it { should have_one(:image) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#uniqueness' do
    context 'email' do
      let!(:tour_host) { create(:tour_host) }
      let!(:tour_host_2) { create(:tour_host) }

      it do
        tour_host_2.update(email: tour_host.email)

        expect(tour_host_2.valid?).to eq(false)
        expect(tour_host_2.errors.full_messages).to eq(['Email has already been taken'])
      end
    end
  end

  describe '#email format' do
    context 'invalid' do
      let!(:tour_host) { create(:tour_host) }

      it do
        tour_host.update(email: 'invalid')

        expect(tour_host.valid?).to eq(false)
        expect(tour_host.errors.full_messages).to eq(['Email is invalid'])
      end
    end
  end
end
