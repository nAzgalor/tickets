Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :users, only: :index
  resources :personal_messages, only: %i[new create]
  resources :conversations, only: %i[index show]

  resource :profile, only: %i[edit update]
  controller :page do
    %w[home dashboard].each { |page| get page }
  end

  namespace :admin do
    resources :users, except: :show

    root '/admin/users#index'
  end

  root 'page#home'
end
