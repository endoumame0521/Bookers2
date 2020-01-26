Rails.application.routes.draw do

  get 'home/top'
  get 'home/about'

  devise_for :users

  resources :books do
  	resources :comments, only: [:create, :edit, :update, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end

  resources :users

  root 'home#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end