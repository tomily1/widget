# frozen_string_literal: true

Rails.application.routes.draw do
  root 'public_widgets#index'

  post '/login', to: 'authentication#create'
  post '/logout', to: 'authentication#logout'
  post '/register', to: 'authentication#register'

  resources :personal_widgets, only: %i(index create)
  resources :profile, only: [:show]
end
