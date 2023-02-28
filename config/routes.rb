Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/mechanics/:id", to: "mechanics#show"
  post "/mechanics/:id/guest_rooms", to: "mechanic_rides#create"

  get "/amusement_park/:id", to: "amusement_parks#show"
end
