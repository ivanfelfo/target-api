# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    devise_for :users, controllers: {
      confirmations: 'confirmations'
    }
  end
end
