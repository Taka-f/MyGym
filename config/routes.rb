Rails.application.routes.draw do

  devise_for :users
  resources :gyms do
    resources :reviews
  end
  root to: 'gyms#index'
  get 'search', to: 'gyms#search'
end
