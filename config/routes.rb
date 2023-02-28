Rails.application.routes.draw do
  resources :mechanics, only: [:show]
end
