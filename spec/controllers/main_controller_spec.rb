require 'spec_helper'

describe MainController do
  
  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
  describe "GET index" do
    it "assigns all posts as @posts" do
      Post.stub(:find).with(:all, :order => "created_at DESC") { [mock_post] }
      get :index
      assigns(:posts).should eq([mock_post])
    end
  end
  
end