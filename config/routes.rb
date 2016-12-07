Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams, only: [:index, :show, :new, :create] do
    resources :developers, only: [:index, :show, :new, :create]
  end

  root to: "teams#index"
end
