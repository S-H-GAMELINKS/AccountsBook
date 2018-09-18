Rails.application.routes.draw do

  resources :categories
  root 'accounts#index'

  resources :accounts

  namespace :api, format: 'json' do
    resources :accounts
    resources :categories
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
