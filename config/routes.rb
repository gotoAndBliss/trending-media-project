Shwagr::Application.routes.draw do

  root :to => 'main#index'

  match "login", :to => "user_sessions#new", :as => "login"
  match "logout", :to => "user_sessions#destroy", :as => "logout"
  match '/message/inbox', :to => "message#inbox", :as => "inbox"

  resources :message

  resources :comments do
    resources :comments
    member do
      get :vote_up
      get :vote_down
    end
  end
  
  resources :categories do
    member do
      get :show_posts
    end
  end
  resources :posts do
    resources :comments
    collection do
     get :load_images
   end
   member do
     get :vote_up 
     get :vote_down
   end
  end
  resources :user_sessions
  resources :users do
    resources :posts do
      collection do
        get :view
      end
    end
  end

  
end
