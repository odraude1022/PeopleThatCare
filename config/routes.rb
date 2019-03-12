Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: :index
  resources :users, except: :index
  resources :charities, except: :index
  resources :news_posts

  get 'hello_world', to: 'hello_world#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/charity_login', to: 'charity_sessions#new'
  post '/charity_login', to: 'charity_sessions#create'
  delete '/charity_logout', to: 'charity_sessions#destroy'
  end
