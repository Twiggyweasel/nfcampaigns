Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :champions, only: [:index]
      resources :events, only: [:index]
    end
  end

  namespace :admin do
    resources :applications, only: [:index, :show]
    resources :contributions
    resources :payments, only: [:index, :edit, :update] do
      collection do
        get 'summary'
      end
    end

    get 'home', to: 'pages#home'
    get 'reports', to: 'reports#index'
    get 'over_100', to: 'reports#over_100'
    get 'unpaid_registrations', to: 'reports#unpaid_registrations'
    resources :events do
      resources :resources, except: [:show, :index]
      resources :registration_fees
      resources :attendees do
        resources :guests
      end
      resources :contributions
      resources :promo_cards, except:[:index]
      resources :teams do
        resources :contributions, only: [:edit, :destroy]
      end
      resources :orders
      resources :tickets
      resources :sponsor_levels
      resources :organizers
      get 'concert_summary', to: 'events#concert_summary'
      get 'event_summary', to: 'events#event_summary'
      get 'event_team_summary', to: 'events#event_team_summary'
      get 'event_contact_list', to: 'events#contact_list'
    end
    resources :promotions
    resources :users
    resources :applications, only: [:index, :show, :destroy]
    resources :resources, only: [:index]
    resources :gallery_images
    get 'collect_all', to: 'gallery_images#collect_all'
  end
  resources :contributions, only: [:new, :create]

  resources :events, except: [:new, :create] do
    resources :contributions, except: [:destroy] do
      get 'reciept', to: 'contributions#reciept'
      get 'decline', to: 'contributions#decline'
    end
    resources :comments, only: [:new, :create]
    resources :teams, except: [:index]
    resources :attendees, except: [:index]
    resources :registration_fees
    resources :orders
    resources :sponsorships
    get 'registration-select', to: 'events#registration_select'
    get 'attendees', to: 'events#attendees'
  end

  resources :orders do
    resources :payments, only: [:new, :create]
    get 'reciept', to: 'orders#reciept'
    get 'decline', to: 'orders#decline'
  end

  resources :sponsorships do
    resources :payments, only: [:new, :create]
    get 'reciept', to: 'sponsorships#reciept'
    get 'decline', to: 'sponsorships#decline'
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

  resources :volunteers, only: [:new, :create]

  get 'previous_events', to: 'events#previous_events'
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

  if Rails.env.production?
   get '404', :to => 'application#page_not_found'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
