Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :mechanics, only: :show
	resources :ride_mechanics, only: :create
end