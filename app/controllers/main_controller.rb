class MainController < ApplicationController

  def index
    @posts = Post.all
    @user = User.all
  end
  
end