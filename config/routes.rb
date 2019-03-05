Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users, controllers: { registrations: 'registrations'} #omniauth_callbacks: 'omniauth_callbacks'
  resources :cars
end
