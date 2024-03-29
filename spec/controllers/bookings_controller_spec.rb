require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:customer) { create(:customer) }
  let(:tour) { create(:tour) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:authorize_customer_request).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:customer).and_return(customer)
  end

  describe 'POST #create' do
    context 'when customer has not booked the tour' do
      it 'creates a new booking' do
        expect {
          post :create, params: { tour_id: tour.id }
        }.to change(customer.bookings, :count).by(1)
      end

      it 'returns the created booking' do
        post :create, params: { tour_id: tour.id }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('id', 'customer_id', 'tour_id')
      end
    end

    context 'when customer has already booked the tour' do
      let!(:booking) { create(:booking, customer: customer, tour: tour) }

      it 'returns an error message' do
        post :create, params: { tour_id: tour.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors' => ["Customer has already booked this tour"])
      end

      it 'does not create a new booking' do
        expect {
          post :create, params: { tour_id: tour.id }
        }.not_to change(Booking, :count)
      end
    end
  end
end
