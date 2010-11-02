Reachstats::Application.routes.draw do
  get "stats/index"

  devise_for :users

  resources :players
  root :to => "home#index"
end
