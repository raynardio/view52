Rails.application.routes.draw do
  devise_for :users
  get '/', to: 'dashboard#index', as: 'dashboard'
  get '/:page.html', to: 'dashboard#page'
end
