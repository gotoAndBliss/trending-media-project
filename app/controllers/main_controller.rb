class MainController < ApplicationController

  def index
    # Ordered by most recent on default for now
    # store_location unless current_user
    @posts = Post.find(:all, :order => "created_at DESC")
    @user = User.all
  end
  
  
end