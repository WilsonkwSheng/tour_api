require 'rails_helper'

RSpec.describe TourHostsController, type: :controller do
  describe 'POST #create' do
    # Note: Commenting this out for now as it is saving to local drive public folder.
    # let(:image_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test_image.png'), 'image/png') }
    let(:tour_host) { build_stubbed(:tour_host) }

    context 'with valid parameters' do
      it do
        post :create, params: { name: tour_host.name, email: tour_host.email, password: 'password', password_confirmation: 'password', description: 'Lorem ipsum' }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it do
        post :create, params: { name: tour_host.name, email: tour_host.email, password: 'password', password_confirmation: 'invalid' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:tour_host) { create(:tour_host) }

    before do
      allow(controller).to receive(:authorize_tour_host_request).and_return(true)
    end

    context 'when tour host exists' do
      it 'returns the tour host' do
        get :show, params: { id: tour_host.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when tour host does not exist' do
      it 'returns not_found status' do
        get :show, params: { id: 'invalid_id' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end