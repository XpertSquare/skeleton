Rails.application.routes.draw do
  get 'site/index'

  resources :registrations, only: [:index, :create]
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'site#index'
  
  get 'login' => 'sessions#new'
  get 'logout'=>'sessions#destroy'
  
  resources :sessions, only: [:create, :destroy]
  
end
