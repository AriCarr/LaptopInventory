Rails.application.routes.draw do

  resources :computers do
    member do
      get :overwrite, as: 'overwrite'
      patch :inplace, as: 'inplace'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/seed', to: 'application#seed'

  get '/search', to: 'computers#search'

  get '/sysinfo', to: 'downloads#sysinfo'

  get '/search_results', to: 'computers#search_results', as: 'search_results'
end
