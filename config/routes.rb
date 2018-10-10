Rails.application.routes.draw do
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end
  root to: redirect{ '/public' }

  devise_for :users, skip: :all
  devise_scope :user do
    get '/u/saml', to: 'saml#init'
    post '/u/saml', to: 'saml#consume'
    delete '/u/logout', to: 'devise/sessions#destroy'
  end

  namespace :admin do
    get '', to: 'admin#show'
    resources :families, except: [ :show ]
    resource :students, only: [ :create, :show, :update ]
    resources :users, only: [ :destroy, :index, :update ]
  end

  namespace :daycare do
    get '', to: 'daycares#show'

    resource :admin, only: [ :show ] do
      get :balance_sheets
      resources :entries, only: [ :edit, :index, :update ]
      resources :history, only: [ :show ]
      resources :payments, only: [ :show, :update ]
      get :report
      post :report
      get :total
    end

    resource :checkin, only: [ :show ]
    namespace :checkin do
      resources :grade, only: [ :show, :update, :destroy ]
    end

    resource :checkout, only: [ :create, :show, :update ]
  end

  resource :public, only: [ :show ]

  # get :tardy,                           to: 'tardy#grades'
  # get 'tardy/:grade/:letter/:student',  to: 'tardy#student'
  # get 'tardy/:grade/:letter',           to: 'tardy#students'
  # get 'tardy/:grade',                   to: 'tardy#letters'
end
