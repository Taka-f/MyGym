Rails.application.routes.draw do

  devise_for :users
  resources :gyms do
    resources :reviews
  end
  root 'gyms#index'
end
