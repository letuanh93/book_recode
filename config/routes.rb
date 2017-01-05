Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  # devise_for :users, controllers: {sessions: "users/sessions"}
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_scope :user do
  #   get 'sign_in', to: 'devise/sessions#new'
  # end
  # devise_for :users, controllers: {sessions: "users/sessions"}
  devise_for :users
  # resources :users
  resources :users do
    collection do
      match "search" => "users#search", via: [:get, :post], as: :search
    end
  end
end
