Rails.application.routes.draw do
  
  namespace :admin do
    resources :payments, only: [:index]
    get 'home', to: 'pages#home'
    resources :events
    resources :promotions 
    resources :users
  end
  
  resources :events, except: [:new, :create] do 
    resources :contributions, only: [:show, :new, :create, :edit, :update]
    resources :comments, only: [:new, :create]
    resources :teams
    resources :attendees
    resources :registration_fees
  end
  resources :contributions
  
  resources :attendees, except: [:new] do
    # resources :pledge_pages, only: [:edit, :update]
    
    get 'pledge_page', to: 'pledge_pages#show', as: :pledge_page
    resources :guests, except: [:show]
    resources :contributions, only: [:show, :new, :create, :edit, :update]
  end
  resources :pledge_pages do
    resources :comments, only: [:new, :create]
  end
  
  match '/auth/:provider/callback', to: 'session#create', via: [:get, :post] #omniauth route
  match '/register', to: 'users#new', via: [:get, :post]
  
  match '/login', to: 'session#new', via: [:get, :post]
  match '/logout', to: 'session#destroy', via: [:get, :post]
  get '/auth/failure', to: 'session#failure'
  resources :users #needed by omniauth-identity
  
  resources :payments, only: [:index, :new, :create, :show]
  
  # get '/top_attendees', to: 'pages#top_attendees'
  get '/top_teams', to: 'teams#index'
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
