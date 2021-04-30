Rails.application.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'users', controllers: {
      confirmations: 'v1/confirmations',
      registrations: 'v1/registrations',
    }
    # devise_for :users, controllers: {
    #   confirmations: 'v1/confirmations'
    # }
    resources :dashboards, only: [:index], as: :dashboards
  end
end
