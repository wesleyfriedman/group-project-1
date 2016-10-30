Rails.application.routes.draw do

  root 'welcome#index'
  resources :supplies
  resources :event_users
  resources :events do
    resources :tasks
    member do
      post 'invite'
    end
  end
  resources :users
  # resources :sessions, except: [:new, :create]
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post 'users/respond_to_invitation' => 'users#respond_to_invitation'
  # get '/events/:id/tasks/new' => 'tasks#new'
  # post '/events/:id/tasks' => 'tasks#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
