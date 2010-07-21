require 'spec_helper'

describe "categories/edit.html.haml" do
  before(:each) do
    assign(:category, @category = stub_model(Category,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders the edit category form" do
    render

    response.should have_selector("form", :action => category_path(@category), :method => "post") do |form|
      form.should have_selector("input#category_name", :name => "category[name]")
    end
  end
end
