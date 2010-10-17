require 'spec_helper'

describe Comment do
  
  before do
    @mock_cat = Factory.create(:category)
    Category.stub(:mock_cat)
    @post = Factory(:post)
    @comment = Factory(:comment)
  end
  
  describe "a comment is made" do
    it "should be a valid comment" do
      @comment.should be_valid
    end
  end
  
  
  
end
