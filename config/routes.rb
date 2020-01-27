Rails.application.routes.draw do

  devise_for :users
  resources :gyms do
    resources :likes, only: [:create, :destroy]
    resources :reviews
  end
  root to: 'gyms#index'
  get 'search', to: 'gyms#search'
end
