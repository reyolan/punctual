Rails.application.routes.draw do
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  devise_for :users

  delete 'tasks/destroy_completed', to: 'tasks#destroy_completed'
  resources :tasks, only: %i[new create]

  resources :categories do
    resources :tasks, shallow: true, except: :index
    delete '/tasks/destroy_completed', to: 'tasks#destroy_completed'
  end

  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  root 'static_pages#home'
end
