Rails.application.routes.draw do
  resources :mechanics, only: [:show, :update]

  resources :mechanic_rides, only: [:create]

  namespace :visitor do
    resources :amusement_parks, only: :show
  end
end
