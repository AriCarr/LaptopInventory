Rails.application.routes.draw do
  resources :computers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login/:user_id' => 'sessions#login_local' if Rails.env.development?
  delete '/logout', to: 'sessions#destroy'
end
