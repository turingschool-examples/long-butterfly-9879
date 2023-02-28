Rails.application.routes.draw do
  resources :mechanics, only: :show
  
  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
