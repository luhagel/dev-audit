Rails.application.routes.draw do
  # match errors to their templates
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  #Session routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #Signup
  get    '/signup',  to: 'users#new'

  #Static pages
  get "/pages/:page", to: "pages#show"

  #Resources
  resources :users, only: [:create]

  resources :github_users, only: [:create]

  resources :teams, only: [:show, :new, :create, :destroy] do
    resources :developers, only: [:show, :new, :create, :destroy]
  end

  #get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'
  get '/paimages' => 'pages#paimages'

  #Root to landing page
  root to: "pages#show", page: "home"

  def query_params_to_query(request)
    query_params = request.params.except(:path, :format)
    query_params.any? ? "?#{query_params.to_query}" : ""
  end

  constraints(host: %r{^dev-stat.us}) do
    redirect_action = ->(params, _request) do
      "https://www.dev-stat.us/#{params[:path]}#{query_params_to_query(_request)}"
    end
    root to: redirect(redirect_action)
    match '/*path', to: redirect(redirect_action), via: [:get, :post]
  end
end
