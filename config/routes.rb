# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/users/registrations'
      }
      namespace :users do
        resources :sessions, only: %i[index]
      end

      resources :tweets, only: %i[create]
      resources :images, only: %i[create]
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
