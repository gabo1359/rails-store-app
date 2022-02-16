Rails.application.routes.draw do
  get 'user/create'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :products do
    resources :reviews, only: :create
    resources :orders, only: :create
    resources :likes
  end
  resources :reviews, only: [ :update, :destroy ]
  resources :orders, only: [ :index, :destroy ]
  resources :users_admin, only: [ :new, :create ], :controller => 'users'
  get 'tags/:tag', to: 'products#index', as: :tag
  get 'filter/:filter', to: 'products#index', as: :filter
end
