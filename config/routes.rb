Shwagr::Application.routes.draw do |map|

  map.resources :categories, :member => {:show_posts => :get}
  map.resources :posts, :member => {:vote_up => :get, :vote_down => :get}
  map.resources :user_sessions
  map.resources :users do |resc|
    resc.resources :posts, :collection => {:view => :get}
  end
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => 'main'
  
end
