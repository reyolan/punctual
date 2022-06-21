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
      resource :complete, only: %i[create destroy], controller: 'completed_tasks'
    end
  end

  scope module: 'tasks' do
    resource :completed_tasks, only: :destroy, controller: 'all_completed_tasks'
  end

  resources :categories, except: :show do
    scope module: 'categories' do
      resources :tasks, only: %i[new index]
      resource :completed_tasks, only: :destroy, controller: 'all_completed_tasks'
    end
  end

  root 'static_pages#home'
end
