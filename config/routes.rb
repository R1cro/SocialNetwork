Rails.application.routes.draw do
  get 'session/new'

  root 'landing_pages#home'
  get  '/help',    to: 'landing_pages#help'
  get  '/about',   to: 'landing_pages#about'
  get  '/contact', to: 'landing_pages#contact'
  get  '/signup',  to: 'users#new'
  get  '/login',   to: 'session#new'
  post  '/login',   to: 'session#create'
  delete  '/logout',  to: 'session#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :forgot_password, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  resources :microposts, only: [:create, :destroy]
  resources :tags, only: [:show]
  resources :relationships, only: [:create, :destroy]

  root 'landing_pages#home'
end
