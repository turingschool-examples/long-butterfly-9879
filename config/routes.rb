Rails.application.routes.draw do
  resources :mechanics, only: [:show, :update]

  resources :mechanic_rides, only: [:create]
end
