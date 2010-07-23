class MainController < ApplicationController

  def index
    # Ordered by most recent on default for now
    @posts = Post.find(:all, :order => "created_at DESC")
    @user = User.all
  end
  
end