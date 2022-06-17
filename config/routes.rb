Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :tasks, only: %i[new create]
  delete 'tasks/destroy_completed', to: 'tasks#destroy_completed'

  resources :categories do
    resources :tasks, shallow: true, except: :index
    delete '/tasks/destroy_completed', to: 'tasks#destroy_completed'
  end

  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  root 'static_pages#home'
end
