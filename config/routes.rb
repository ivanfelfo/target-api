Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :v1 do
    post '/messages/:id', to: 'messages#create', as: :messages
    get '/messages/:id', to: 'messages#index'
    get '/conversations/unread', to: 'conversations#unread'
    mount_devise_token_auth_for 'User', at: 'users', controllers: {
      confirmations: 'v1/confirmations',
      registrations: 'v1/registrations',
      sessions: 'v1/sessions'
    }
    resources :dashboards, only: [:index], as: :dashboards
    resources :targets, as: :targets
    resources :topics, as: :topics
    resources :users, as: :users, only: [:update]
    resources :conversations, only: %i[index create show]
  end
end
