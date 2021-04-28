Rails.application.routes.draw do
  namespace :v1 do
    devise_for :users, controllers: {
      confirmations: 'v1/confirmations'
    }
    resources :dashboards, only: [:index], as: :dashboards
  end
end
