Rails.application.routes.draw do

  root 'main#home'
  
  devise_for :users

  scope :dashboard do
    get '', to: 'dashboard#index'

    resources :campaigns
    
    resources :voters

  end
end
