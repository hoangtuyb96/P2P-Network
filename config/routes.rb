Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  devise_scope :user do
    get "sign_up", to: "registrations#new"
    post "sign_up", to: "registrations#create"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
  resources :users do
    resources :statuses, only: [:new, :create, :index]
    get "following", to: "relationships#following"
    get "follower", to: "relationships#follower"
  end
  resources :groups, except: [:edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :images, only: :show
  resources :users, only: [:show, :update, :destroy]
  resources :comments, only: :create
  resources :relationships, only: [:create, :destroy]

  mount ActionCable.server => "/cable"
end
