Rails.application.routes.draw do


  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users, only: [:show]
  resources :gyms do
    resources :likes, only: [:create, :destroy]
    resources :reviews do
      resources :goods, only: [:create, :destroy]
    end
  end
  root to: 'gyms#index'
  get 'search', to: 'gyms#search'
end
