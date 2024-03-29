class ToursController < ApplicationController
  before_action :authorize_tour_host_request, :set_tour_host

  def create
    @tour = @tour_host.tours.build(tour_params)

    if @tour.save
      render json: @tour, status: :created
    else
      render json: { errors: @tour.errors.full_messages }, status: :unprocessable_entity
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
