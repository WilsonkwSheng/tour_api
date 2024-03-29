require 'rails_helper'

RSpec.describe ToursController, type: :controller do
  let(:tour_host) { create(:tour_host) }
  let(:tour) { build_stubbed(:tour) }

  describe 'POST #create' do
    context 'when tour host is authenticated' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:authorize_tour_host_request).and_return(true)
        allow_any_instance_of(ApplicationController).to receive(:tour_host).and_return(tour_host)
      end

      context 'with valid parameters' do
        it 'creates a new tour' do
          post :create, params: { tour: { title: tour.title, description: tour.description, region: tour.region, city: tour.city, travel_type: tour.travel_type } }
          expect(response).to have_http_status(:created)
          expect(tour_host.tours.count).to eq(1)
        end
      end

      context 'with invalid parameters' do
        it 'returns unprocessable_entity status' do
          post :create, params: { tour: { title: tour.title } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when tour host is not authenticated' do
      it 'returns unauthorized status' do
        post :create, params: { tour: { title: tour.title, description: tour.description, region: tour.region, city: tour.city, travel_type: tour.travel_type } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end