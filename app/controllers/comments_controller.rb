class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    #debugger
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.commentable.class == Comment
      @comment.post_parent_id = @comment.commentable.post_parent_id
    elsif @comment.commentable.class == Post
      @comment.post_parent_id = @comment.commentable.id
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@comment.post_parent_id) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
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
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def get_vote
    current_comment = Comment.find(params[:id])
    @comment = current_comment
    @vote =  current_comment.votes.find_by_user_id(current_user.id)
    unless @vote
      @vote = Vote.create(:user_id => current_user.id, :value => 0)
      current_comment.votes << @vote
    end
  end
  
end
