Rails.application.routes.draw do

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get    '/signup',  to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]

  resources :teams, only: [:index, :show, :new, :create] do
    resources :developers, only: [:show, :new, :create]
  end

  root to: "teams#index"
end
