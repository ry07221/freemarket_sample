Rails.application.routes.draw do
  get 'categories/show'
  devise_for :users 
  devise_scope :user do
    get "users/select_registration", to: 'users/registrations#select', as: :select_registration
  end
  
  get 'recapcha/index'
  root to: "products#index"

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

