Rails.application.routes.draw do
  root 'home#index'
  get "publications", to: 'home#index'
  
  namespace :api do
    resources :publications, only: [:index]
  end
end
