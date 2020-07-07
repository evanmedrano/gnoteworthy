Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users
  get '/dashboard' => 'dashboards#show', :as => :user_root

  resource :dashboard, only: [:show] do
    resources :notes
  end
end
