Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  get "my_portfolio", to: "users#my_portfolio"
  post "search_stock", to: "stocks#search"
  get "my_friends", to: "users#my_friends"
  post "search_friend", to: "users#search"
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
end
