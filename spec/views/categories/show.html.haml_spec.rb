require 'spec_helper'

describe "categories/show.html.haml" do
  before(:each) do
    assign(:category, @category = stub_model(Category,
      :name => "MyString"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
  end
end
