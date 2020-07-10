Rails.application.routes.draw do
  get 'errors/show'
  root to: 'home#index'

  devise_for :users
  get '/dashboard' => 'dashboards#show', :as => :user_root

  resource :dashboard, only: [:show] do
    resources :notes, only: [:show, :new, :edit, :create, :update, :destroy]
  end

  resource :emails, only: [:create]

  get '*unmatched_route', to: 'errors#show'
end
