Rails.application.routes.draw do
  get 'calendar', to: 'calendar#index'
  devise_for :users, module: :user
  get '/', to: 'dashboard#index', as: 'dashboard'
  get '/profile', to: 'profile#index'
  put '/profile', to: 'profile#update'
  resources :role, path: 'roles', only: [:index, :show]
  get '/search', to: 'global_search#search'
  get '/google/oauth2callback', to: 'google#oauth2callback'
  get '/google/calendar', to: 'google#calendar'
  post '/tag', to: 'tag#create'
  get '/tag', to: 'tag#index'
  get '/autocomplete/views', to: 'autocomplete#views'
  get '/autocomplete/tags', to: 'autocomplete#tags'
  resources :note
end
