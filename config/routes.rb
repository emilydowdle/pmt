Rails.application.routes.draw do
  # get '/auth/:provider', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]
  resources :organizations, only: [:new, :create, :show, :edit], param: :slug do
    resources :incidents
  end
  resources :users do
    member do
      get :confirm_email
    end
  end

  root to: "home#show"
end
