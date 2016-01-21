Rails.application.routes.draw do
  devise_for :users
  get 'show' => 'books#show'
  root 'books#index'
end
