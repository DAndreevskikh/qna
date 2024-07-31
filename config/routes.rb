Rails.application.routes.draw do
  resources :questions do
    resources :answers, only: [:create]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
