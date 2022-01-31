Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :products do
    resources :reviews, only: :create
    resources :orders, only: :create
  end
  resources :reviews, only: [ :destroy ]
  resources :orders, only: [ :index, :destroy ]
end
