Rails.application.routes.draw do

  get 'good/create'

  get 'good/destroy'

  devise_for :users
  resources :gyms do
    resources :likes, only: [:create, :destroy]
    resources :reviews do
      resources :goods, only: [:create, :destroy]
    end
  end
  root to: 'gyms#index'
  get 'search', to: 'gyms#search'
end
