class CategoriesController < ApplicationController
  
  before_filter :require_user, :except => [:show_posts]
  
  def show_posts
    @category = Category.find_by_name(params[:id])
    if current_user
      if !current_user.last_logins.find_by_category_id(@category).blank?
        current_user.last_logins.find_by_category_id(@category).update_attribute("updated_at", Time.now)
      else
        @last_login = LastLogin.new(:user_id => current_user.id, :category_id => @category.id )
        @last_login.save
      end
    end
    @category_posts = (Post.find(:all, :conditions => { :category => @category.name }).sort {|a,b| b.shwagrithm <=> a.shwagrithm}).paginate(:page => params[:page], :per_page => 25)
  end
  
  def index
    
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end


  def show
    @category = Category.find_by_name(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end


  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end


  def edit
    @category = Category.find_by_name(params[:id])
  end


  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find_by_name(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find_by_name(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def require_user
    unless current_user && current_user.username == "gotoAndBliss"
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end
  
end
