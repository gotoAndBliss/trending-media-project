require 'spec_helper'

describe "comments/index.html.haml" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment,
        :text => "MyText"
      ),
      stub_model(Comment,
        :text => "MyText"
      )
    ])
  end

  it "renders a list of comments" do
    render
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
