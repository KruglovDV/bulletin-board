# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth', to: 'auth#sign_out', as: :sign_out
    get 'profile', to: 'profile#index', as: :profile

    resources :bulletins, only: %i[new create show edit update] do
      member do
        patch 'archive'
        patch 'moderate'
      end
    end

    namespace :admin do
      root 'home#index'

      resources :bulletins, only: %i[index] do
        member do
          patch 'archive'
          patch 'publish'
          patch 'reject'
        end
      end
      resources :categories
    end
  end
end
