Rails.application.routes.draw do
  mount MessageQuickly::Engine, at: "/webhook"
  resources :contacts, only: [:new, :create]
  resources :visitors, only: [:new, :create]
  root to: 'visitors#new'
end
