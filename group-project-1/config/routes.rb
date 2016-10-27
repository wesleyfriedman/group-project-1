Rails.application.routes.draw do

  root 'welcome#index'
  resources :supplies
  resources :tasks
  resources :event_users
  resources :events
  resources :users
  # resources :sessions, except: [:new, :create]
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
