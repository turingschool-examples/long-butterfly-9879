Rails.application.routes.draw do
  resources :mechanics, only: [:show]
  resources :ride_mechanics, only: [:create]
  resources :amusement_parks, only: [:show]
end
