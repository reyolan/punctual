Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  resources :tasks, except: :index do
    scope module: 'tasks' do
      resource :complete, only: :update, controller: 'completed_tasks'
    end
  end

  scope module: 'tasks' do
    delete 'completed_tasks', to: 'completed_tasks#destroy_all'
  end

  resources :categories, except: :show do
    scope module: 'categories' do
      resources :tasks, only: %i[new index]
      delete 'completed_tasks', to: 'completed_tasks#destroy_all'
    end
  end

  root 'static_pages#home'
end
