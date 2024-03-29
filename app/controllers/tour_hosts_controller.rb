class TourHostsController < ApplicationController
  before_action :authorize_tour_host_request, except: :create
  before_action :find_tour_host, except: %i[create]

  def show
    if @tour_host.present?
      render json: @tour_host, status: :ok
    else
      render json: { errors: 'Tour Host not found' }, status: :not_found
    end
  end

  def create
    @tour_host = TourHost.new(tour_host_params)
    if @tour_host.save
      @tour_host.create_image(file: params[:image]) if params[:image]
      render json: @tour_host, status: :created
    else
      render json: { errors: @tour_host.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_tour_host
    @tour_host = TourHost.find_by(id: params[:id])
  end

  def tour_host_params
    params.permit(
      :name, :email, :password, :password_confirmation, :description,
      image_attributes: [:id, :file]
    )
  end
end
