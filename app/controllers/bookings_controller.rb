class BookingsController < ApplicationController
  before_action :authorize_customer_request

  def create
    tour = Tour.find_by(id: params[:tour_id])

    if customer.bookings.pluck(:tour_id).include?(params[:tour_id])
      render json: { error: 'You have already booked this tour' }, status: :unprocessable_entity
      return
    end

    booking = customer.bookings.build(tour: tour)

    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    tour = Tour.find_by(id: params[:id])
    booking = customer.bookings.find_by(tour_id: tour.id)

    if booking.destroy
      head :no_content
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end
end