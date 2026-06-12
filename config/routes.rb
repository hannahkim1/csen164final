Rails.application.routes.draw do
  resources :cartitems
  resources :carts
  resources :products do
    resources :reviews, only: [ :create ]
  end
  resources :reviews, only: [ :edit, :update, :destroy ]
  resources :favorites, only: [ :index, :create, :destroy ]
  resources :orders, only: [ :index, :new, :create, :show ]
  resources :wishlist_items, path: "wishlist", only: [ :index, :create, :destroy ] do
    post :move_to_cart, on: :member
  end

  # Authentication
  get  "signup", to: "users#new"
  resources :users, only: [ :create ]
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  root "shopper#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
