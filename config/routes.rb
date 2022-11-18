# frozen_string_literal: true

Rails.application.routes.draw do
  resources :links
  resources :clicks, only: %i[index]

  namespace :api do
    resources :links, only: %i[create]
  end

  get 'sign_in', to: redirect("/auth/#{Rails.env.production? ? :google_oauth2 : :developer}")
  get 'sign_out', to: 'sessions#destroy'
  get 'auth/failure', to: redirect('/')
  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match '/:slug', to: 'home#url', via: %i[get post], as: 'short'
  root to: 'home#index'
end
