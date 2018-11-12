Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    resource :profile
  end
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  resources :cryptocurrencies
  resources :calculator
  resources :matyaka_data_records
  get 'matyaka_data_entry', to: 'matyaka_data_records#new'
  get 'matyaka_data_search', to: 'matyaka_data_records#index'
  get 'crypto', to: 'cryptocurrencies#crypto'
  get 'websocket', to: 'cryptocurrencies#websocket'
end
