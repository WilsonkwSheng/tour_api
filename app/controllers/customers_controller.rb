class CustomersController < ApplicationController
  before_action :authorize_customer_request, except: :create
  before_action :find_customer, except: %i[create]

  def show
    if @customer.present?
      render json: @customer, status: :ok
    else
      render json: { errors: 'Customer not found' }, status: :not_found
    end
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created
    else
      render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def find_customer
    @customer = Customer.find_by(id: params[:id])
  end
end