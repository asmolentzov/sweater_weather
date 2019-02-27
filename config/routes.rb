Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :backgrounds, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :gifs, only: [:index]
      resources :favorites, only: [:index, :create]
      delete '/favorites', to: 'favorites#destroy'
    end
  end
end
