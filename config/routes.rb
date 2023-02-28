Rails.application.routes.draw do
  resources :mechanics, only: [:show]
  resources :ride_mechanics, only: [:create]
  resources :amusment_parks, only: [:show]
end
