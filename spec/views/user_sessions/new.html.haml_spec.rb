require 'spec_helper'

describe "user_sessions/new.html.haml" do
  before(:each) do
    assign(:user_session, stub_model(UserSession,
      :new_record? => true,
      :username => "MyString",
      :password => "MyString"
    ))
  end

  it "renders new user_session form" do
    render

    response.should have_selector("form", :action => user_sessions_path, :method => "post") do |form|
      form.should have_selector("input#user_session_username", :name => "user_session[username]")
      form.should have_selector("input#user_session_password", :name => "user_session[password]")
    end
  end
end
