Rails.application.routes.draw do
  resources :events do 
    resources :contributions, only: [:show, :new, :create, :edit, :update]
    resources :comments, only: [:new, :create]
    resources :teams
    resources :attendees
  end
  resources :contributions
  
  resources :attendees, except: [:new] do
    resources :pledge_pages, only: [:show, :new, :create]
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
  resources :users #needed by omniauth-identity
  
  
  root to: "events#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
