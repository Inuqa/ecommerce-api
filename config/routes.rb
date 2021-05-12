Rails.application.routes.draw do
  defaults format: :json do
    namespace :admin do
      resources :products do
        resources :variants
      end
    end
    resources :products, only: %i[index show]
  end
end
