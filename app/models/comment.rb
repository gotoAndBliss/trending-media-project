class Comment < ActiveRecord::Base
  
  belongs_to  :post
  belongs_to  :parent, :class_name => 'Comment'
  has_many    :children, :class_name => 'Comment'
  
  validates_presence_of :text
  
end
