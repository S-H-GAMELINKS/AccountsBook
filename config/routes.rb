Rails.application.routes.draw do

  root 'accounts#index'

  resources :accounts
  resources :categories

  namespace :api, format: 'json' do
    resources :accounts
    resources :categories
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
