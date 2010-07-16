require 'spec_helper'

describe "user_sessions/index.html.haml" do
  before(:each) do
    assign(:user_sessions, [
      stub_model(UserSession,
        :username => "MyString",
        :password => "MyString"
      ),
      stub_model(UserSession,
        :username => "MyString",
        :password => "MyString"
      )
    ])
  end

  it "renders a list of user_sessions" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
  end
end
