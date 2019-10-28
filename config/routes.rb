Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :main, only: [:index]
  resources :user_login, only: [:index, :create]
  resources :new_user, only: [:index, :create]
  resources :new_device, only: [:index, :new, :create]
  resources :users
  resources :documents, only: [:index]


  scope :api do
    post 'led', to: 'api#led'
    post 'image', to: 'api#image'
    get 'place/:id', to: 'api#place'
    get 'new/:token/:url', to: 'api#new'
    post 'place_new', to: 'api#place_new'
    get 'show/:user_id', to: 'api#show'
    post 'id', to: 'api#id'
    get 'destroy/:id/:user_id', to: 'api#destroy'
  end
end
