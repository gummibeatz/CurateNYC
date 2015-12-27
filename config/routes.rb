Rails.application.routes.draw do
  resources :emails

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  use_doorkeeper
  root to: "emails#new"
  get 'work' => 'application#work', :as => :work
  get 'about' => 'application#about', :as => :about
  get 'signin' => 'application#signin', :as => :signin

    resources :user
    resources :wardrobe
    resources :like
    resources :outfit

  # get '/auth/facebook', :as => 'application#signin', as: 'signin'
  # match 'auth/facebook/callback', to: 'sessions#create', via: [:get, :post]
  # match 'auth/failure', to: redirect('/'), via: [:get, :post]
  # get 'signin' => 'application#signin', :as => :signin
  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  match '/auth/failure', :to => 'sessions#failure', via: [:get, :post]
  get 'logout' => 'sessions#destroy', :as => :logout
  
  namespace :api do
    namespace :v1 do
      resources :tokens,:only => [:create, :destroy]
      resources :user,via: [:get, :post]
      resources :wardrobe,via: [:get, :post]
      post '/outfit/:id/edit', to: 'outfit#update'
      post '/user/new', to: 'user#create'
      post '/user/:id/edit', to: 'user#update'
      post '/like/:id/edit', to: 'like#update'
      post '/wardrobe/:id/edit', to: 'wardrobe#update'
      match '/matches', :to => 'wardrobe#match', via: [:get, :post]
      resources :like,via: [:get, :post]
      resources :outfit,via: [:get, :post]
      resources :batch
    end
  end
end
