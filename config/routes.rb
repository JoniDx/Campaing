Rails.application.routes.draw do

  root 'main#home'
  
  devise_for :users

  resources :campaigns

  resources :voters, except: [:delete]
  
  resources :admins
  resources :liders

  get 'lider/create', to: 'lider#create'
  get 'lider/index', to: 'lider#index'
  get 'lider/edit/:id', to: 'lider#edit'

  get 'admin/create', to: 'admin#create'
  get 'admin/index', to: 'admin#index'
  get 'admin/edit/:id', to: 'admin#edit'

  post 'user', to: 'user#create'
  post 'user/:id', to: 'user#update'

end
