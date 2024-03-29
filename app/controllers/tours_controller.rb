class ToursController < ApplicationController
  before_action :authorize_tour_host_request, :set_tour_host

  def index
    @tours = @tour_host.tours
    render json: @tours
  end

  def create
    @tour = @tour_host.tours.build(tour_params)

    if @tour.save
      render json: @tour, status: :created
    else
      render json: { errors: @tour.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @tour = @tour_host.tours.find_by(id: params[:id])
    if @tour.present?
      render json: @tour
    else
      render json: { error: 'Tour not found' }, status: :not_found
    end
  end

  private

  def tour_params
    params.require(:tour).permit(:title, :description, :region, :city, :travel_type)
  end

  def set_tour_host
    @tour_host = tour_host
  end
end
