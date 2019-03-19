Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: :index
  resources :users, except: :index do
    scope module: :users do
      resources :charities, only: [:update, :destroy, :index]
    end
  end
  resources :charities
  resources :news_posts
  resources :categories, only: [:index, :show]

  get 'hello_world', to: 'hello_world#index'

  get '/user_login', to: 'user_sessions#new'
  post '/user_login', to: 'user_sessions#create'
  delete '/user_logout', to: 'user_sessions#destroy'

  get '/charity_login', to: 'charity_sessions#new'
  post '/charity_login', to: 'charity_sessions#create'
  delete '/charity_logout', to: 'charity_sessions#destroy'
  end
