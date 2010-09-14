require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :username => "stinkyfeet",
      :email => "blastedfingers@dangerous.com",
      :password => "D1ff1cultPa55w0rd",
      :password_confirmation => "D1ff1cultPa55w0rd",
    }
  end
  
  it "should create a new account given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should succeed creating a new :valid_user from the Factory" do
    Factory.create(:valid_user)
  end
  
  it "should invalid :invalid_user facotory" do
    Factory.build(:invalid_user).should be_invalid
  end
  
end
