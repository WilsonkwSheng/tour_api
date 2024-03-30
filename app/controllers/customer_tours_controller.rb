class CustomerToursController < ApplicationController
  before_action :authorize_customer_request

  def index
    @tours = Tour.all
    render json: @tours
  end

  def show
    @tour = Tour.all.includes(itineraries: :images).find_by(id: params[:id])
    if @tour.present?
      render json: @tour, include: { itineraries: :images }
    else
      render json: { error: 'Tour not found' }, status: :not_found
    end
  end
end
