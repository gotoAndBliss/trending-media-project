require 'spec_helper'

describe "categories/index.html.haml" do
  before(:each) do
    assign(:categories, [
      stub_model(Category,
        :name => "MyString"
      ),
      stub_model(Category,
        :name => "MyString"
      )
    ])
  end

  it "renders a list of categories" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
  end
end
