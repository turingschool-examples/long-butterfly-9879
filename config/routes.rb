Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/amusment_parks/:id', to: 'amusment_parks#show'
  
  get '/mechanics/:id', to: 'mechanics#show'

  post '/mechanic_rides/:id', to: 'mechanic_rides#create'
end
