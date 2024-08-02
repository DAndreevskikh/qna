Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
