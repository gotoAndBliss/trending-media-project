class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_back_or_default root_url
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(root_url, :notice => 'Successfully logged out.')  }
      format.xml  { head :ok }
    end
  end
end
