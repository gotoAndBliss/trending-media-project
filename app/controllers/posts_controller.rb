require 'uri'

class PostsController < ApplicationController
  
  def index
    @posts = Post.all 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
    #debugger
    @post = Post.find(params[:id])

    @commentable = find_commentable
    @comments = @commentable.comments

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def new
    @post = Post.new
    @cat_names = Category.all.collect {|c| c.name }.inspect
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end


  def edit
    @post = Post.find(params[:id])
  end

  #TO DO , fix this bullshit. This shold be a virgin posts controller for create.
  def create
    @post = Post.params[:post]
    if @post.save
      flash[:notice] = "Successfully created comment."
      redirect_to :id => nil
    else
      render :action => 'new'
    end
  end


  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(user_posts_path(current_user), :notice => "Post was deleted.") }
      format.xml  { head :ok }
    end
  end  
  
  def vote_up
    get_vote
    @vote.value += 1 unless @vote.value == 1
    @vote.save
    respond_to do |format|
      format.js { render :action => "vote", :layout => false }
    end
  end
  
  def vote_down
    get_vote
    @vote.value -= 1 unless @vote.value == -1
    @vote.save
    respond_to do |format|
      format.js { render :action => "vote", :layout => false }
    end
  end
  
  private

  def find_commentable
    params.each do |name, value|
      if params[:controller] == "comments"
        return Comment.find(params[:comment][:id])
      elsif params[:controller] == "posts" 
        return Post.find(params[:id])
      end
    end
    nil
  end

  def get_vote
    current_post = Post.find(params[:id])
    @post = current_post
    @vote =  current_post.votes.find_by_user_id(current_user.id)
    unless @vote
      @vote = Vote.create(:user_id => current_user.id, :value => 0)
      current_post.votes << @vote
    end
  end
  
end
