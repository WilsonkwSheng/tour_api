Rails.application.routes.draw do
  resources :tour_hosts, only: [:create, :show]
  post '/tour_hosts_auth/login', to: 'tour_hosts_authentication#login'
  resources :customers, only: [:create, :show]
  post '/customers_auth/login', to: 'customers_authentication#login'
  resources :tours
  resources :bookings, only: [:create]
end
