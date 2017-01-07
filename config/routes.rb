Rails.application.routes.draw do
  get 'team_members/new'

  get 'team_members/create'

  # match errors to their templates
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

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
