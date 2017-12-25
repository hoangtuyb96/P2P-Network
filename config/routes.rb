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
  resources :groups, except: [:edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :images, only: :show do
    resources :reports, only: :create
  end
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  mount ActionCable.server => "/cable"
end
