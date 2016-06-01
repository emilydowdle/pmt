Rails.application.routes.draw do

  # get '/auth/:provider', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  # Webhooks
  post 'pagerduty/incident', to: 'pager_duty#webhook', :defaults => { :format => 'json' }
  
  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]
  resources :organizations, only: [:new, :create, :show, :edit], param: :slug do
    resources :incidents
  end

  root to: "home#show"
end
