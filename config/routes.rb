Rails.application.routes.draw do
  devise_for :users
  resources :tasks, only: %i[new create]
  resources :categories do
    resources :tasks, shallow: true, except: :index
  end

  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings', as: 'settings'

  get '/users', to: redirect('/users/sign_up')
end
