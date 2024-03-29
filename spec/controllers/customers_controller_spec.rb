require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'POST #create' do
    let(:customer) { build_stubbed(:customer) }

    context 'with valid parameters' do
      it do
        post :create, params: { name: customer.name, email: customer.email, password: 'password', password_confirmation: 'password' }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it do
        post :create, params: { name: customer.name, email: customer.email, password: 'password', password_confirmation: 'invalid' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let!(:customer) { create(:customer) }

    before do
      allow(controller).to receive(:authorize_customer_request).and_return(true)
    end

    context 'when customer exists' do
      it 'returns the tour host' do
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when customer does not exist' do
      it 'returns not_found status' do
        get :show, params: { id: 'invalid_id' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end