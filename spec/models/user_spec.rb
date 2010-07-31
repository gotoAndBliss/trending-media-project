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
end
