Rails.application.routes.draw do
  namespace :admin do
    resources :payments, only: [:index]
    get 'home', to: 'pages#home'
    resources :events do 
      resources :resources, except: [:show, :index]
      resources :registration_fees
      resources :attendees do 
        resources :guests
      end
      resources :contributions
      resources :promo_cards, except:[:index]
      resources :teams
      resources :orders
      resources :tickets
    end
    resources :promotions 
    resources :users
    resources :applications, only: [:index, :show, :destroy]
    resources :resources, only: [:index]
    resources :gallery_images
    get 'collect_all', to: 'gallery_images#collect_all'
  end
  
  resources :events, except: [:new, :create] do 
    resources :contributions, only: [:show, :new, :create, :edit, :update] do 
      get 'reciept', to: 'contributions#reciept'
      get 'decline', to: 'contributions#decline'
    end
    resources :comments, only: [:new, :create]
    resources :teams, except: [:index]
    resources :attendees, except: [:index]
    resources :registration_fees
    resources :orders
    get 'registration-select', to: 'events#registration_select'
  end
  
  resources :orders do
    resources :payments
    get 'reciept', to: 'orders#reciept'
    get 'decline', to: 'orders#decline'
  end
  
  resources :contributions, except: [:destroy, :index] do
      resources :payments, only: [:new, :create]
  end
  
  resources :attendees, except: [:new, :create, :index] do
    # resources :pledge_pages, only: [:edit, :update]
    resources :payments
    get 'reciept', to: 'attendees#reciept'
    get 'decline', to: 'attendees#decline'
    # get 'pledge_page', to: 'pledge_pages#show', as: :pledge_page
    resource :pledge_page, only: [:edit, :update, :show]
    resources :guests, except: [:show]
    resources :contributions, only: [:show, :new, :create, :edit, :update]
    post 'join_team', to: 'attendees#join_team'
  end
  
  resources :pledge_page do
    resources :comments, only: [:new, :create]
  end
  
  match '/auth/:provider/callback', to: 'session#create', via: [:get, :post] #omniauth route
  match '/register', to: 'users#new', via: [:get, :post]
  
  match '/login', to: 'session#new', via: [:get, :post]
  match '/logout', to: 'session#destroy', via: [:get, :post]
  get '/auth/failure', to: 'session#failure'
  
  resources :users do  #needed by omniauth-identity
    resources :notifications
    resources :profiles, only: [:new, :create, :edit, :update] do
      member { put :has_nf }
    end
    get 'account_settings', to: 'profiles#show'
  end
  resources :password_resets
  resources :champions do 
    resources :contributions
  end
  
  resources :applications, only: [:new, :create]
  
  resources :referrals
  get 'top_attendees', to: 'pages#attendees'
  get 'top_teams', to: 'teams#index'
  get 'contribution_select', to: 'contributions#contribution_select'
  get 'about', to: 'pages#about'
  get 'privacy', to: 'pages#privacy'
  get 'nf', to: "pages#nf"
  
  post 'check_promotion_code', to: 'promotions#check_promotion_code'
  
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
