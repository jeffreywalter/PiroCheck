Rails.application.routes.draw do
  get 'products/index'

  resources :products
  root 'products#index'
end
