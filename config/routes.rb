Rails.application.routes.draw do
  get 'recapcha/index'
  root to: "products#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  resources :users, only: [:show] do
    member do
      get "likes", "listings", "in_progress", "completed", "purchase", "purchased"
    end
  end

  resources :products, only: [:new, :create, :show] do
    member do
      post "purchase"
    end
  end

  resources :categories, only: [:index, :show]
end
