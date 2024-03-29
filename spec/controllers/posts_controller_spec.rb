require 'spec_helper'

describe PostsController do

  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end
  
  describe "Authenticated examples" do
    before(:each) do
      activate_authlogic
      @user = Factory.create(:valid_user)
      UserSession.create(@user)
    end
  
    describe "#new" do
      it "should be successful" do
        get :new
        response.should be_success
      end
    end

    describe "GET index" do
      it "assigns all posts as @posts" do
        Post.stub(:all) { [mock_post] }
        get :index
        assigns(:posts).should eq([mock_post])
      end
    end

    describe "GET show" do
      it "assigns the requested post as @post" do
        Post.stub(:find).with("37") { mock_post }
        get :show, :id => "37"
        assigns(:post).should be(mock_post)
      end
    end

    describe "GET new" do
      it "assigns a new post as @post" do
        Post.stub(:new) { mock_post }
        get :new
        assigns(:post).should be(mock_post)
      end
    end

    describe "GET edit" do
      it "assigns the requested post as @post" do
        Post.stub(:find).with("37") { mock_post }
        get :edit, :id => "37"
        assigns(:post).should be(mock_post)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created post as @post" do
          Post.stub(:new).with({'these' => 'params'}) { mock_post(:save => true) }
          post :create, :post => {'these' => 'params'}
          assigns(:post).should be(mock_post)
        end

        it "redirects to the created post" do
          Post.stub(:new) { mock_post(:save => true) }
          post :create, :post => {}
          response.should redirect_to(post_url(mock_post))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          Post.stub(:new).with({'these' => 'params'}) { mock_post(:save => false) }
          post :create, :post => {'these' => 'params'}
          assigns(:post).should be(mock_post)
        end

        it "re-renders the 'new' template" do
          Post.stub(:new) { mock_post(:save => false) }
          post :create, :post => {}
          response.should render_template(:new)
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        it "updates the requested post" do
          Post.should_receive(:find).with("37") { mock_post }
          mock_post.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :post => {'these' => 'params'}
        end

        it "assigns the requested post as @post" do
          Post.stub(:find) { mock_post(:update_attributes => true) }
          put :update, :id => "1"
          assigns(:post).should be(mock_post)
        end

        it "redirects to the post" do
          Post.stub(:find) { mock_post(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(post_url(mock_post))
        end
      end

      describe "with invalid params" do
        it "assigns the post as @post" do
          Post.stub(:find) { mock_post(:update_attributes => false) }
          put :update, :id => "1"
          assigns(:post).should be(mock_post)
        end

        it "re-renders the 'edit' template" do
          Post.stub(:find) { mock_post(:update_attributes => false) }
          put :update, :id => "1"
          response.should render_template(:edit)
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested post" do
        Post.should_receive(:find).with("37") { mock_post }
        mock_post.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the posts list" do
        Post.stub(:find) { mock_post }
        delete :destroy, :id => "1"
        response.should redirect_to(user_posts_path(@user))
      end
    end
    
    describe "voting on posts" do
      
      before(:each) do
        @mock_cat = Factory.create(:category)
        Category.stub(:mock_cat)
        @post = Factory(:post)
      end
      
      it "should vote up" do
        get :vote_up, :id => @post.id
        @post.reload.vote_score.should == 1    
      end
      
      it "should vote down" do
        get :vote_down, :id => @post.id
        @post.reload.vote_score.should == -1
      end
      
      describe "vote value should not vote up" do
        before(:each) do
          get :vote_up, :id => @post.id
        end
        it "should be 1" do
          get :vote_up, :id => @post.id
          @post.reload.vote_score.should == 1
        end
      end
      
      describe "vote value should not vote down" do
        before(:each) do
          get :vote_down, :id => @post.id
        end
        it "should not vote down" do
          get :vote_down, :id => @post.id
          @post.reload.vote_score.should == -1
        end
      end
      
    end
    
  end
  
end
