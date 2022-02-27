Rails.application.routes.draw do

  root 'main#home'
  
  devise_for :users

  resources :campaigns

  resources :voters, except: [:edit, :update, :delete]

  get 'lider/create', to: 'lider#create'
  get 'lider/index', to: 'lider#index'
  get 'lider/edit/:id', to: 'lider#edit'

  post 'user', to: 'user#create'
  post 'user/:id', to: 'user#update'

end
