Rails.application.routes.draw do
  get '/', to: 'dashboard#index'
  get '/:page.html', to: 'dashboard#page'
end
