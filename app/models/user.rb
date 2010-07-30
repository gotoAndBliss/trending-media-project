class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :posts, :dependent => :destroy
  has_many :votes
  
end
