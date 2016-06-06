Rails.application.routes.draw do
  # get '/auth/:provider', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]

  resources :organizations, param: :slug do
    resources :incidents
    resources :users, only: [:new, :create, :show] do
      member do
        get :add_existing_user
        post :confirm_add
        get :confirm_email
      end
    end
  end

  root to: "home#show"
end
