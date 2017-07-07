Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :subscribers
  resources :subscription_notifications
  resources :short_codes
end
