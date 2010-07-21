require 'spec_helper'

describe "posts/show.html.haml" do
  before(:each) do
    assign(:post, @post = stub_model(Post,
      :type => false,
      :name => "MyString",
      :url => "MyString",
      :text => "",
      :category => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain(false)
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("")
    response.should contain("MyString")
  end
end
