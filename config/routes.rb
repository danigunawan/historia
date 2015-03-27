Rails.application.routes.draw do
  root :to => 'pages#index'

  resources :users, :places

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  match 'auth/:provider/callback', to: 'sessions#create_social', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
