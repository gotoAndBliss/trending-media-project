class MainController < ApplicationController

  def index
    # Ordered by most recent on default for now
    # store_location unless current_user
    #@posts = Post.find(:all, :order => "created_at DESC")
    @posts = (Post.all.sort {|a,b| b.shwagrithm <=> a.shwagrithm}).paginate(:page => params[:page], :per_page => 25)
  end
  
  
end