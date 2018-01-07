Rails.application.routes.draw do


  get 'dashboard/index'

  get 'site/index'
  get '/site/pricing', as: 'pricing'

  resources :registrations, only: [:index, :create]
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'site#index'
  
  get 'login' => 'sessions#new'
  get 'logout'=>'sessions#destroy'
  
  resources :sessions, only: [:create, :destroy]
  
  namespace :admin do
    get '/' => 'dashboard#index'
  end
  
end
