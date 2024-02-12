# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
      namespace :users do
        resources :session_infos, only: %i[index]
      end

      resources :users, only: %i[show] do
        resource :follow, only: %i[create]
        resource :unfollow, only: %i[destroy]
      end
      resources :tweets, only: %i[index create destroy] do
        resources :comments, only: %i[index]
        resource :retweets, only: %i[create]
        resource :favorites, only: %i[create]
      end
      resources :groups, only: %i[index create] do
        resources :messages, only: %i[index create]
      end
      resources :comments, only: %i[create destroy]
      resources :images, only: %i[create]
      resources :notifications, only: %i[index]
      resources :bookmarks, only: %i[index create destroy]
      resources :folders, only: %i[index create destroy] do
        resources :bookmark_folders, only: %i[index create]
      end
      resource :profile, only: %i[update]
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
