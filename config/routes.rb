Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'blogs#index'
  resources :blogs do
    collection do
      post :confirm
      get :articles
    end
  end

  get '/webpages', to: 'webpages#index'

  resources :users, only: [:new, :create, :show]

  resources :favorites, only: [:create, :destroy]
end
