Rails.application.routes.draw do
  root :to => 'pages#index'

  resources :users, :places, :likes, :photos

  resources :places do
    put :like, on: :member
  end

  # Login/Logout routes for email/password authentication.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # Use match as it might be a GET or POST. Used for omniauth authentication.
  match 'auth/:provider/callback', to: 'sessions#create_social', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
