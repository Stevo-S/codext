require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'welcome/index'
  root 'welcome#index'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'outbound_messages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :subscribers
  resources :subscription_notifications
  resources :short_codes
  resources :outbound_messages
  resources :batch_messages
end
