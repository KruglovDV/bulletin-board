# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth', to: 'auth#sign_out', as: :sign_out

    resources :bulletins, only: %i[new create show]

    namespace :admin do
      root 'home#index'
      resources :bulletins, only: %i[index]
      resources :categories
    end
  end
end
