# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tutors, only: %i[index show] do
    resources :appointments
  end

  # resources :users, only: [:show] do
  #   resources :appointments
  # end
end
