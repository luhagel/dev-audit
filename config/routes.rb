Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams, only: [:index, :show, :new, :create]
  resources :developers, only: [:index, :show, :new, :create]

  root to: "teams#index"
end
