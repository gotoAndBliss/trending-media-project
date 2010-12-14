class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end
  
  has_many :posts
  has_many :votes
  has_many :comments
  
  def new_responses
    Comment.replies_for(self).after(last_checked_mail)
  end
  
end
