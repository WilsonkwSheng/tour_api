require 'rails_helper'

RSpec.describe TourHostsAuthenticationController, type: :controller do
  describe 'POST #login' do
    let!(:tour_host) { create(:tour_host) }

    context 'with valid credentials' do
      it 'returns a JWT token' do
        post :login, params: { email: tour_host.email, password: 'password' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('token', 'exp', 'name')
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized status' do
        post :login, params: { email: 'invalid@example.com', password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
