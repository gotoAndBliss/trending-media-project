require 'spec_helper'

describe Category do
  before(:each) do
    @category = Factory.build(:category)
  end
  
  it "should be valid" do
    @category.should be_valid
    @category.save!
  end
  
  it "should be invalid" do
    Factory.build(:invalid_category).should be_invalid
  end
    
end
