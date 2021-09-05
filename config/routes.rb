Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      namespace :admin do
        resources :orders
        resources :products do
          resources :variants, only: %i[index create]
        end
        resources :variants, except: %i[index create] do
          get '/restore', to: 'variants#restore'
        end
        get '/products/:id/restore', to: 'products#restore'
      end
      resources :categories, only: %i[index show]
      resources :products, only: %i[index show]
      resources :variants, only: [:index]
      resources :orders, only: [:create]

      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/current_user', to: 'admins#current'

      post '/payment', to: 'payments#commit'
      get '/payments/:uuid', to: 'payments#show'
    end
  end
end
