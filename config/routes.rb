Rails.application.routes.draw do
  #Session routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #Signup
  get    '/signup',  to: 'users#new'

  #Static pages
  get "/pages/:page" => "pages#show"

  #Resources
  resources :users, only: [:create]

  resources :teams, only: [:show, :new, :create] do
    resources :developers, only: [:show, :new, :create]
  end

  #Root to landing page
  root to: "pages#show", page: "home" 
end
