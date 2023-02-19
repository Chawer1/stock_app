# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index new create]

  resources :portfolios, only: %i[index new create show] do
    resources :investments, only: %i[new create show]
  end

  post 'authenticate', to: 'users#authenticate'
  get 'login', to: 'users#new'
  post 'login', to: 'users#create'
  delete 'logout', to: 'users#destroy'
end
