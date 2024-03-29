require 'rails_helper'

RSpec.describe ToursController, type: :controller do
  describe 'POST #create' do
    let(:tour_host) { create(:tour_host) }
    let(:tour) { build_stubbed(:tour) }

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

  describe 'GET #index' do
    let(:tour_host) { create(:tour_host) }
    let!(:tour) { create(:tour, tour_host: tour_host) }

    before do
      allow_any_instance_of(ApplicationController).to receive(:authorize_tour_host_request).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:tour_host).and_return(tour_host)
    end

    it 'returns a list of tours belonging to the tour host' do
      get :index

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([tour.as_json])
    end
  end

  describe 'GET #show' do
    let(:tour_host) { create(:tour_host) }
    let!(:tour) { create(:tour, tour_host: tour_host) }
    let!(:another_tour) { create(:tour) }

    before do
      allow_any_instance_of(ApplicationController).to receive(:authorize_tour_host_request).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:tour_host).and_return(tour_host)
    end

    it 'returns the requested tour belonging to the tour host' do
      get :show, params: { id: tour.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(tour.as_json)
    end

    it 'returns not found if the tour does not belong to the tour host' do
      get :show, params: { id: another_tour.id }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Tour not found' })
    end
  end
end