Rails.application.routes.draw do
  
  namespace :admin do
    resources :payments, only: [:index]
    get 'home', to: 'pages#home'
    resources :events do 
      resources :resources, except: [:show, :index]
    end
    resources :promotions 
    resources :users
    resources :applications, only: [:index, :show, :destroy]
    resources :resources, only: [:index]
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
  end
  
  resources :contributions do
      resources :payments, only: [:new, :create]
  end
  
  resources :attendees, except: [:new, :create, :index] do
    # resources :pledge_pages, only: [:edit, :update]
    resources :payments
    get 'reciept', to: 'attendees#reciept'
     get 'decline', to: 'attendees#decline'
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
  
  resources :users do  #needed by omniauth-identity
    resources :profiles, only: [:new, :create, :edit, :update] do
      member { put :has_nf }
    end
    get 'account_settings', to: 'profiles#show'
  end
  
  resources :champions do 
    resources :contributions
  end
  
  resources :applications, except: [:index, :destroy]
  
  resources :payments, only: [:index, :new, :create, :show]
  resources :referrals
  get 'top_attendees', to: 'pages#attendees'
  get 'top_teams', to: 'teams#index'
  get 'contribution_select', to: 'contributions#contribution_select'
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
