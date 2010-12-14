class MessageController < ApplicationController
  
  def inbox
    @new_mail = current_user.new_responses
    current_user.update_attribute("last_checked_mail", Time.now)
  end
  
  def index
    @old_mail = Comment.replies_for(current_user).order("created_at DESC")
  end
  
end
