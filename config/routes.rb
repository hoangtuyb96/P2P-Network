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
    resources :statuses, except: [:show, :edit, :update] do
      resources :reports, only: :create
    end
    get "following", to: "relationships#following"
    get "follower", to: "relationships#follower"
    resources :reports, only: :create
  end
  resources :groups do
    get "requests", to: "groups#requests"
  end
  resources :likes, only: [:create, :destroy]
  resources :images, only: [:show, :destroy] do
    resources :reports, only: :create
  end
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :group_members, only: [:create, :update, :destroy]
  post "search", to: "search#search"
  namespace :admin do
    resources :reports
  end
  mount ActionCable.server => "/cable"
end
