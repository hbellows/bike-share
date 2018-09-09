Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/bike-shop', to: 'accessories#index'
  resources :stations, only: [:index]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :accessories, only: [:show]
  resources :carts, only: [:create]

  get '/:id', to: 'stations#show'
end
