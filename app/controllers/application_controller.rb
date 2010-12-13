class ApplicationController < ActionController::Base
  
  before_filter :load_categories
  
  protect_from_forgery
  layout 'application'
  
  helper_method :current_user
  
  def load_categories
    @categories = Category.all
  end
  
  private
  
  def require_login
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end  
  
  def store_location
    if request.params[:controller] == "comments"
      session[:return_to] = post_url(request.params[:post_id])
    else
      session[:return_to] = request.fullpath
    end
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
