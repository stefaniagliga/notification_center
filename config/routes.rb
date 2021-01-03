Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :notifications, only: %i[create]
      resources :user_notifications, only: %i[index]
      resources :sessions, only: %i[create]
    end
  end
end
