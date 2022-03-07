Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users

  require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # resources :products do
  #   resources :reviews, only: :create
  #   resources :orders, only: :create
  #   resources :likes
  # end
  
  # resources :reviews, only: [ :update, :destroy ]
  # resources :orders, only: [ :index, :destroy ]
  # resources :users_admin, only: [ :new, :create ], :controller => 'users'

  # get 'tags/:tag', to: 'products#index', as: :tag
  # get 'filter/:filter', to: 'products#index', as: :filter

  namespace :admin do
    resources :products, only: [:new, :create, :edit, :update, :destroy] do
      resources :reviews, only: [:update, :destroy]
    end
  end

  scope module: :user do
    root to: 'pages#home'
    resources :orders, only: [ :index, :destroy ]
    resources :products, only: [:show, :index] do
      resources :reviews, only: :create
      resources :orders, only: :create
      resources :likes
    end
  end

  scope module: :support do
    resources :users_admin, only: [ :new, :create ], :controller => 'users'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/auth/login', to: 'authentication#login'
      resources :users_admin, only: [ :new, :create, :show, :destroy ], :controller => 'users'
      resources :orders, only: :index
      resources :products, only: [:index, :show, :update, :create, :destroy] do
        resources :orders, only: :create
        resource :likes
      end
    end
  end
end
