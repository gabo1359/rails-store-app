Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users

  require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
      resources :likes, only: [:create, :destroy]
    end
  end

  scope module: :support do
    resources :users_admin, only: [ :new, :create ], :controller => 'users'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/auth/login', to: 'authentication#login'
      namespace :admin do
        resources :users_admin, only: [:create, :show, :destroy], :controller => 'users'
        resources :user_reviews, only: [:update, :destroy]
        resources :products, only: [:create, :update, :destroy]
      end
      scope module: :user do
        resources :user_reviews, only: [:create, :show]
        resources :orders, only: :index
        resources :products, only: [:index, :show] do
          resources :orders, only: :create
          resources :likes, only: [:create, :destroy]
        end
      end
    end
  end
end
