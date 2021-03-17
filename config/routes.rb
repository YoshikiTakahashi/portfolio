Rails.application.routes.draw do
  root               to: 'home_pages#home'
  get    'home_pages/home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  # resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  get 'clients/index'
  get 'clients/getclient'
  post 'clients/create'
  delete 'clients/destroy'
end
