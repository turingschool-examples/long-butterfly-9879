Rails.application.routes.draw do
  resources :mechanics, only: [:show, :update]

  resources :amusement_parks, only: [:show]
  
end
