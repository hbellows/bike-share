Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root to: 'accessories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/trips-dashboard', to: 'trips#dashboard'
  get '/conditions-dashboard', to: 'conditions#dashboard'
  get '/bike-shop', to: 'accessories#index'

  get '/admin/dashboard', to: 'admin/users#show'
  get '/dashboard', to: 'users#show'

  namespace :admin do
    resources :users
    resources :stations
    resources :conditions
    resources :orders, only: [:index]
    resources :accessories, only: [:index]
  end

  resources :users, only: [:new, :create, :edit, :update]
  resources :stations, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :accessories, only: [:show]
  resources :carts, only: [:create]
  resources :orders, only: [:show]

  get '/cart', to: 'carts#index'
  delete '/cart', to: 'carts#destroy'


  get '/:id', to: 'stations#show'

end
