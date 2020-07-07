Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users
  get '/user' => 'dashboards#show', :as => :user_root

  resource :dashboard, only: [:show]
end
