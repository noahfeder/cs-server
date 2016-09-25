# == Route Map
#
#   Prefix Verb  URI Pattern             Controller#Action
#   logout POST  /logout(.:format)       sessions#destroy
#    login POST  /login(.:format)        sessions#create
#   signup POST  /signup(.:format)       sessions#newuser
#     root GET   /                       binaries#index
# binaries GET   /binaries(.:format)     binaries#index
#          POST  /binaries(.:format)     binaries#create
#   binary GET   /binaries/:id(.:format) binaries#show
#          PATCH /binaries/:id(.:format) binaries#update
#          PUT   /binaries/:id(.:format) binaries#update
#

Rails.application.routes.draw do
  post '/logout' => 'sessions#destroy'

  post '/login' => 'sessions#create'

  post '/signup' => 'sessions#newuser'

  root to: 'binaries#index'
  resources :binaries, only: [:index, :show, :update, :create]
end
