# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tutors, only: %i[index show]

  resources :users, only: %i[index show]

  resources :appointments, only: %i[index show update destroy]

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'appointments/new', to 'appointments#create'
end
