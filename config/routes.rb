Rails.application.routes.draw do
  get 'variants/index'
  get 'variants/create'
  get 'variants/update'
  get 'variants/destroy'
  get 'products/index'
  get 'products/create'
  get 'products/update'
  get 'products/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
