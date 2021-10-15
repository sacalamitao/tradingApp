Rails.application.routes.draw do
  resources :transactions
  resources :stocks
  root 'home#index'
  resources :home
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post "/" => 'stocks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
