Rails.application.routes.draw do
  devise_for :users, module: :user
  get '/', to: 'dashboard#index', as: 'dashboard'
  get '/profile', to: 'profile#index'
  put '/profile', to: 'profile#update'
end
