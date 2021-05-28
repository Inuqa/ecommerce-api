Rails.application.routes.draw do
  get 'cart/index'
  defaults format: :json do
    namespace :api do
      namespace :admin do
        resources :orders
        resources :products do
          resources :variants
        end
      end
      resources :products, only: %i[index show]
      resources :variants, only: [:index]
      resources :orders, only: [:create]

      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/current_user', to: 'admins#current'

      post '/payment', to: 'payments#commit'

      post '/asd', to: 'cart#test'
    end
  end
end
