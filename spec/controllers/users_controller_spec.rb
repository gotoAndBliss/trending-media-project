require 'spec_helper'

describe UsersController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      User.stub(:new) { mock_user }
      get :new
      assigns(:user).should be(mock_user)
    end
  end
  
    describe "Authenticated examples" do
      before(:each) do
        activate_authlogic
        @user = Factory.create(:valid_user)
        UserSession.create(@user)
      end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        get :edit, :id => "1"
        assigns(:user).should == @user
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created user as @user" do
          User.stub(:new).with({'these' => 'params'}) { mock_user(:save => true) }
          post :create, :user => {'these' => 'params'}
          assigns(:user).should be(mock_user)
        end

        it "redirects to the created user" do
          User.stub(:new) { mock_user(:save => true) }
          post :create, :user => {}
          response.should redirect_to(root_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          User.stub(:new).with({'these' => 'params'}) { mock_user(:save => false) }
          post :create, :user => {'these' => 'params'}
          assigns(:user).should be(mock_user)
        end

        it "re-renders the 'new' template" do
          User.stub(:new) { mock_user(:save => false) }
          post :create, :user => {}
          response.should render_template(:new)
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        
        it "updates the requested user" do
          controller.stub!(:current_user).and_return(@user)
          @user.should_receive(:update_attributes).with(anything()).and_return(true)
          put :update, :id => @user , :current_user => {'email' => 'Trippy'}
        end

        it "assigns the requested user as @user" do
          get :edit, :id => "1"
          assigns(:user).should == @user
        end

        it "redirects to the user" do
          User.stub(:find) { mock_user(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(root_url)
        end
      end

      describe "with invalid params" do
        it "assigns the user as @user" do
          put :update, :id => "1"
          assigns(:user).should == @user
        end

        it "re-renders the 'edit' template" do
          #controller.stub!(:current_user).and_return(@user)
          #@user.stub!(:update_attributes => false)
          controller.stub_chain(:current_user, :update_attributes).and_return(false)
          put :update, :id => "1"
          response.should render_template(:edit)
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested user" do
        User.should_receive(:find).with("37") { mock_user }
        mock_user.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the users list" do
        User.stub(:find) { mock_user(:destroy => true) }
        delete :destroy, :id => "1"
        response.should redirect_to(users_url)
      end
    end
  
  end

end
