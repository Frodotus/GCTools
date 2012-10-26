Gctools::Application.routes.draw do
  resources :geocaches

  get "geochecker/index"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match "geochecker" => "geochecker#index"
  match "upload" => "upload#index"
  match "uploadgpx" => "upload#upload"
  match "stats" => "upload#stats"
  match "img" => "upload#img"
  match "charts/cache_types_pie" => "chart#cache_types_pie"
  devise_for :users
  resources :users, :only => [:show, :index]
end
