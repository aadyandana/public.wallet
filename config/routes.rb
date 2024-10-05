Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :session do
    post "get_token", on: :collection
    post "refresh_token", on: :collection
  end

  resources :wallet, only: [ :create ]

  resources :transaction do
    post "top_up", on: :collection
    post "transfer", on: :collection
  end

  resources :stock_price, only: [] do
    get :price, on: :collection
    get :prices, on: :collection
    get :price_all, on: :collection
  end
end
