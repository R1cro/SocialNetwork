Rails.application.routes.draw do
  get 'landing_pages/home'

  get 'landing_pages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_pages#home'
end
