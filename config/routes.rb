Shwagr::Application.routes.draw do |map|

  map.resources :categories
  map.resources :posts
  map.resources :user_sessions
  map.resources :users do |users|
    users.resources :posts, :collection => {:view => :get}
  end
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => 'main'
  
end
