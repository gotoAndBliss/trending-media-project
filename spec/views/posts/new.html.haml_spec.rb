require 'spec_helper'

describe "posts/new.html.haml" do
  before(:each) do
    assign(:post, stub_model(Post,
      :new_record? => true,
      :type => false,
      :name => "MyString",
      :url => "MyString",
      :text => "",
      :category => "MyString"
    ))
  end

  it "renders new post form" do
    render

    response.should have_selector("form", :action => posts_path, :method => "post") do |form|
      form.should have_selector("input#post_type", :name => "post[type]")
      form.should have_selector("input#post_name", :name => "post[name]")
      form.should have_selector("input#post_url", :name => "post[url]")
      form.should have_selector("input#post_text", :name => "post[text]")
      form.should have_selector("input#post_category", :name => "post[category]")
    end
  end
end
