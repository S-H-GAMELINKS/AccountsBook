Rails.application.routes.draw do

  root 'accounts#index'
  get '/about',   to: 'accounts#index'
  get '/contact',   to: 'accounts#index'
  get '/category', to: 'accounts#index'

  namespace :api, format: 'json' do
    resources :accounts
    resources :categories
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
