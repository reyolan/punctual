Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :tasks, only: %i[create destroy new]

  authenticated :user do
    root 'static_pages#welcome', as: 'authenticated_root'
  end

  root 'static_pages#home'
end
