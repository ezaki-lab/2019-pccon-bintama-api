Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :main, only: [:index]
  resources :user_login, only: [:index]
  resources :new_user, only: [:index, :create]
end
