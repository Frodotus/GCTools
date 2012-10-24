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
  devise_for :users
  resources :users, :only => [:show, :index]
end
