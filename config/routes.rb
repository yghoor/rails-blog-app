Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "users#index"

  namespace :api, defaults: {format: :json} do
    get '/users/:user_id/posts', to: 'posts#index'
    get '/users/:user_id/posts/:post_id/comments', to: 'comments#index'
    post '/users/:user_id/posts/:post_id/comments/create', to: 'comments#create'

    devise_scope :user do
      post "sign_up", to: "registrations#create"
      post "sign_in", to: "sessions#create"
    end
  end

  resources :users , only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
