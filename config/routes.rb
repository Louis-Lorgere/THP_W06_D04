Rails.application.routes.draw do

  resources :comments
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :gossips
  root "gossips#index"
  # get "/home", to: "pages#home"
  get "/team", to: "pages#team"
  get "/contact", to: "pages#contact"
  # get "/welcome/:name", to: "pages#welcome"
  # get "/welcome", to: "pages#welcome"
  # get "/tests/:id", to: "pages#gossip"
  # get "/users/:id", to: "pages#user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
