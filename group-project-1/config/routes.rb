Rails.application.routes.draw do
  resources :supplies
  resources :tasks
  resources :event_users
  resources :events
  resources :users
  resources :sessions, except: [:new, :create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
