Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :notifications, only: %i[index create]
      resources :user_notifications, only: %i[index update]
      resources :sessions, only: %i[create]
      resources :users, only: %i[index]
    end
  end
end
