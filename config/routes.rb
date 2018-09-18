Rails.application.routes.draw do

  root to: 'accessories#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  get '/stations-dashboard', to: 'stations#dashboard'
  get '/trips-dashboard', to: 'trips#dashboard'
  get '/conditions-dashboard', to: 'conditions#dashboard'
  get '/bike-shop', to: 'accessories#index'

  get '/admin/bike-shop', to: 'admin/accessories#index'

  get '/admin/dashboard', to: 'admin/users#show'
  get '/dashboard', to: 'users#show'

  namespace :admin do
    resources :accessories, only: [:new, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :stations, only: [:new, :create, :edit, :update, :destroy]
    resources :conditions, only: [:new, :create, :edit, :update]
    resources :orders, only: [:index]
    resources :trips
  end

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :stations, only: [:index, :show]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show, :destroy]
  resources :accessories, only: [:show]
  resources :carts, only: [:create]
  resources :orders, only: [:show, :update]

  get '/cart', to: 'carts#index'
  delete '/cart', to: 'carts#destroy'

  get '/:id', to: 'stations#show'

end
