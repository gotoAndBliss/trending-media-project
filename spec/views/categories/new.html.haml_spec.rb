require 'spec_helper'

describe "categories/new.html.haml" do
  before(:each) do
    assign(:category, stub_model(Category,
      :new_record? => true,
      :name => "MyString"
    ))
  end

  it "renders new category form" do
    render

    response.should have_selector("form", :action => categories_path, :method => "post") do |form|
      form.should have_selector("input#category_name", :name => "category[name]")
    end
  end
end
