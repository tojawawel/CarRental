Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users, controllers: { registrations: 'registrations'} #omniauth_callbacks: 'omniauth_callbacks'
  resources :cars do
    collection do
      match 'search' => 'cars#search', via: [:get, :post], as: :search
    end
  end
end
