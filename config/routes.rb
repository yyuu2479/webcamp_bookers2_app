Rails.application.routes.draw do
  devise_for :users
  root to:"homes#top"
  get "home/about" => "homes#about"
  resources :users, only:[:index, :show, :edit, :update] do
    resource :relationships, only:[:create, :destroy]
  end
  
  resources :books, only:[:index, :show, :edit, :create, :destroy, :update] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
end
