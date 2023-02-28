Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/mechanics/:id/rides', to: 'mechanics#create'
  get '/mechanics/:id', to: 'mechanics#show'

  get '/amusement_parks/:id', to: 'amusement_parks#show'
end
