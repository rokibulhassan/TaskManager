Rails.application.routes.draw do
  devise_for :users
  resources :tasks, defaults: {format: :json}
  root :to => "home#index"
end
