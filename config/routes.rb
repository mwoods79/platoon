Reachstats::Application.routes.draw do
  resources :players
  root :to => "home#index"
end
