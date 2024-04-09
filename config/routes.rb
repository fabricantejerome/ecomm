Rails.application.routes.draw do
  namespace :admin do
    resources :orders
    
    resources :products do
      resources :stocks
    end
    resources :categories
  end
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end

  resources :categories, only: [:show]
  resources :products, only: [:show]

  get "admin" => "admin#index"
  get "cart" => "carts#show"
  post "checkout" => "checkouts#create"
  get "success" => "checkouts#success"
  get "cancel" => "checkouts#cancel"
  post "webhooks" => "webhooks#stripe"
end
