Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :tasks, except: :index

  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings', as: 'settings'

  get '/users', to: redirect('/users/sign_up')
end
