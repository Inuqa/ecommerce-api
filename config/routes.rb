Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      resources :variants
    end
  end
end
