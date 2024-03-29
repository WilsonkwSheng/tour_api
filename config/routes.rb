Rails.application.routes.draw do
  resources :tour_hosts, only: [:create, :show]
  post '/tour_hosts_auth/login', to: 'tour_hosts_authentication#login'
  resources :tours
end
