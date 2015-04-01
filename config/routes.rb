Rails.application.routes.draw do
  root :to => 'pages#index'

  resources :users, :places, :likes, :photos, :pages
  
  post '/users/:id/delete' => 'users#destroy', :as => 'user_delete'
  post '/places/:id/delete' => 'places#destroy', :as => 'place_delete'

  resources :places do
    post :like, on: :member
    delete :like, on: :member
  end

  # Login/Logout routes for email/password authentication.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # Used for omniauth authentication.
  match 'auth/:provider/callback', to: 'sessions#create_social', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
