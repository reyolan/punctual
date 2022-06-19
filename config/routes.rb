Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  authenticated :user do
    root 'tasks#index', as: 'authenticated_root'
  end

  resources :tasks do
    scope module: 'tasks' do
      delete :destroy_all_completed, on: :collection, to: 'completed_tasks#destroy_all'
    end
  end

  resources :categories, except: :show do
    scope module: 'categories' do
      resources :tasks, only: %i[new index] do
        delete :destroy_all_completed, on: :collection, to: 'completed_tasks#destroy_all'
      end
    end
  end

  root 'static_pages#home'
end
