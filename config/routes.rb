Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'
  get 'dragon/new'
  root 'welcome#index'

  resources :dragon_types

  namespace :user do
    root to: 'profile#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
