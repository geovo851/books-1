Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :books
  get 'books/search/:id' => 'books_online#search_books', as: 'search_books'
  get 'books-online' => 'books_online#index', as: 'books_online_index'
  post 'changed_draft/:id' => 'books#change_draft', as: 'change_draft'
  get 'contact' => 'books_online#contact', as: 'contact'
  get 'about' => 'books_online#about', as: 'about'
  root 'books_online#index'
end
