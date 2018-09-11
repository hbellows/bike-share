Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root to: 'dashboard#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/bike-shop', to: 'accessories#index'

  get '/dashboard', to: 'users#show'

  namespace :admin do
    resources :users
    resources :stations, only: [:index]
  end

  resources :users, only: [:new, :create]
  resources :stations, only: [:index]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :accessories, only: [:show]
  resources :carts, only: [:create]
  resources :orders, only: [:show]

  get '/cart', to: 'carts#index'


  get '/:id', to: 'stations#show'
end
