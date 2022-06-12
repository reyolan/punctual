Rails.application.routes.draw do
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
  end
  devise_for :users

  resources :tasks, only: %i[new create]
  resources :categories do
    resources :tasks, shallow: true, except: :index
  end

  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  root 'static_pages#home'
end
