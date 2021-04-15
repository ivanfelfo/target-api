Rails.application.routes.draw do
  devise_for :users

  namespace :v1 do
    resources :registrations, only: [:create]
    resources :sessions, only: [:create]
  end

  
end
