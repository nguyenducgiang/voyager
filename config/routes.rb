Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  root 'home#index'

  resources :teams do
    collection do
      patch :change_current_team
    end
  end

  namespace :admin do
    resources :users

    root to: 'users#index'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
