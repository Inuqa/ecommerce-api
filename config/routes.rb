Rails.application.routes.draw do
  get 'cart/index'
  defaults format: :json do
    namespace :admin do
      resources :orders
      resources :products do
        resources :variants
      end
    end
    resources :products, only: %i[index show]
    resources :variants, only: [:index]
  end
end
