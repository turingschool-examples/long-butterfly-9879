Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :mechanics, only: :show
  get '/mechanics/:id', to: 'mechanics#show'
  post 'mechanics/:id', to: 'mechanic_rides#create'
  get '/amusement_parks/:id', to: 'amusement_parks#show'
end
