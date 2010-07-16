require 'spec_helper'

describe "user_sessions/show.html.haml" do
  before(:each) do
    assign(:user_session, @user_session = stub_model(UserSession,
      :username => "MyString",
      :password => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
  end
end
