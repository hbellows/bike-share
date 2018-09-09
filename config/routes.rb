Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stations, only: [:index]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show]

  get '/:id', to: 'stations#show'
end
