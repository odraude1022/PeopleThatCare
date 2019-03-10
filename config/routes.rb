Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  end
