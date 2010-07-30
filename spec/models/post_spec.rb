require 'spec_helper'

module PostSpecHelper
  
  def valid_post_attributes
      {
      :name => "My sweet post",
      :category => "spirituality",
      :url => "google.com"
      }
    end
end

describe Post do
  
  include PostSpecHelper
  
  before do
    @post = Post.new
  end
  
  it "should be a valid post" do
    @post.attributes = valid_post_attributes
    @post.should be_valid
  end
  
  it "should have an error on category" do
    @post.attributes = valid_post_attributes.except(:category)
    @post.should have(1).error_on(:category)
  end
  
end
