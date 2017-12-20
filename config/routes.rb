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
  end
  resources :groups, only: [:new, :create]
  resources :likes, only: [:create, :destroy]
  resources :images, only: :show
  resources :users, only: [:show, :update, :destroy]
  resources :comments, only: :create
  resources :relationships, only: [:create, :destroy]
end
