require 'spec_helper'

describe "posts/index.html.haml" do
  before(:each) do
    assign(:posts, [
      stub_model(Post,
        :type => false,
        :name => "MyString",
        :url => "MyString",
        :text => "",
        :category => "MyString"
      ),
      stub_model(Post,
        :type => false,
        :name => "MyString",
        :url => "MyString",
        :text => "",
        :category => "MyString"
      )
    ])
  end

  it "renders a list of posts" do
    render
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
  end
end
