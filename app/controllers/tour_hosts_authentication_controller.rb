class TourHostsAuthenticationController < ApplicationController
  before_action :authorize_tour_host_request, except: :login

  def login
    @tour_host = TourHost.find_by_email(params[:email])
    if @tour_host&.authenticate(params[:password])
      token = JsonWebToken.encode(tour_host_id: @tour_host.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     name: @tour_host.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
