require 'spec_helper'

describe "comments/show.html.haml" do
  before(:each) do
    @comment = assign(:comment, stub_model(Comment,
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("MyText".to_s)
  end
end
