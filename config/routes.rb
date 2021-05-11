Rails.application.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'users', controllers: {
      confirmations: 'v1/confirmations',
      registrations: 'v1/registrations',
      sessions: 'v1/sessions'
    }
    resources :dashboards, only: [:index], as: :dashboards
    resources :targets, as: :targets
    resources :topics, as: :topics
    resources :users, as: :users, only: [:update]
  end
end
