Rails.application.routes.draw do
  get 'site/index'

  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'site#index'
end
