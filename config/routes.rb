Reachstats::Application.routes.draw do
  devise_for :users

  resources :players
  root :to => "home#index"
end
