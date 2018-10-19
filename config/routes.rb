Rails.application.routes.draw do
  devise_for :users, module: :user
  get '/', to: 'dashboard#index', as: 'dashboard'
  get '/:page.html', to: 'dashboard#page'
end
