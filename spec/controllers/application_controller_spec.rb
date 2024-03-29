require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#authorize_tour_host_request' do
    let(:tour_host) { FactoryBot.create(:tour_host) }
    let(:valid_token) { JsonWebToken.encode(tour_host_id: tour_host.id) }

    context 'when authorization header is present with a valid JWT token' do
      before do
        request.headers['Authorization'] = "Bearer #{valid_token}"
      end

      it 'sets @tour_host with the decoded tour host' do
        expect(controller).to receive(:render).never
        controller.send(:authorize_tour_host_request)
        expect(assigns(:tour_host)).to eq(tour_host)
      end
    end

    context 'when authorization header is present with an invalid JWT token' do
      before do
        request.headers['Authorization'] = 'Bearer invalid_token'
      end

      it do
        expect(controller).to receive(:render).with(json: { errors: 'Not enough or too many segments' }, status: :unauthorized)
        controller.send(:authorize_tour_host_request)
      end
    end

    context 'when authorization header is missing' do
      before do
        request.headers['Authorization'] = nil
      end

      it do
        expect(controller).to receive(:render).with(json: { errors: 'Nil JSON web token' }, status: :unauthorized)
        controller.send(:authorize_tour_host_request)
      end
    end
  end

  describe '#authorize_customer_request' do
    let(:customer) { create(:customer) }
    let(:valid_token) { JsonWebToken.encode(customer_id: customer.id) }

    context 'when authorization header is present with a valid JWT token' do
      before do
        request.headers['Authorization'] = "Bearer #{valid_token}"
      end

      it 'sets @customer with the decoded customer' do
        expect(controller).to receive(:render).never
        controller.send(:authorize_customer_request)
        expect(assigns(:customer)).to eq(customer)
      end
    end

    context 'when authorization header is present with an invalid JWT token' do
      before do
        request.headers['Authorization'] = 'Bearer invalid_token'
      end

      it do
        expect(controller).to receive(:render).with(json: { errors: 'Not enough or too many segments' }, status: :unauthorized)
        controller.send(:authorize_customer_request)
      end
    end

    context 'when authorization header is missing' do
      before do
        request.headers['Authorization'] = nil
      end

      it do
        expect(controller).to receive(:render).with(json: { errors: 'Nil JSON web token' }, status: :unauthorized)
        controller.send(:authorize_customer_request)
      end
    end
  end
end
