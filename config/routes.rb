Rails.application.routes.draw do
  devise_for :users
  root to:"homes#top"
  get "home/about" => "homes#about"
  resources :users, only:[:index, :show, :edit, :update] do
    resource :relationships, only:[:create, :destroy]
    get "followings" => "relationships#followings", as: 'followings'
    get "followers" => "relationships#followeds", as: 'followers'
  end

  resources :books, only:[:index, :show, :edit, :create, :destroy, :update] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  
  resources :messages, only:[:create]
  resources :rooms, only:[:show, :create]
  
  get '/searches' => 'searches#search', as: 'search'
  
end
