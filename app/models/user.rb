class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end
  
  has_many :posts
  has_many :votes
  has_many :comments
end
