Rails.application.routes.draw do

  root 'main#home'
  
  devise_for :users

  resources :campaigns
    
  resources :voters, except: [:edit, :update, :delete]


  get 'lider/create', to: 'lider#create'
end
