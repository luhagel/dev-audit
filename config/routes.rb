Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :developers, only: [:index, :show, :new, :create]

  root to: "developers#index"
end
