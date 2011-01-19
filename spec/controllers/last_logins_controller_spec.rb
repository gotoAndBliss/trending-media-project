require 'spec_helper'

describe LastLoginsController do

  def mock_last_login(stubs={})
    @mock_last_login ||= mock_model(LastLogin, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all last_logins as @last_logins" do
      LastLogin.stub(:all) { [mock_last_login] }
      get :index
      assigns(:last_logins).should eq([mock_last_login])
    end
  end

  describe "GET show" do
    it "assigns the requested last_login as @last_login" do
      LastLogin.stub(:find).with("37") { mock_last_login }
      get :show, :id => "37"
      assigns(:last_login).should be(mock_last_login)
    end
  end

  describe "GET new" do
    it "assigns a new last_login as @last_login" do
      LastLogin.stub(:new) { mock_last_login }
      get :new
      assigns(:last_login).should be(mock_last_login)
    end
  end

  describe "GET edit" do
    it "assigns the requested last_login as @last_login" do
      LastLogin.stub(:find).with("37") { mock_last_login }
      get :edit, :id => "37"
      assigns(:last_login).should be(mock_last_login)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created last_login as @last_login" do
        LastLogin.stub(:new).with({'these' => 'params'}) { mock_last_login(:save => true) }
        post :create, :last_login => {'these' => 'params'}
        assigns(:last_login).should be(mock_last_login)
      end

      it "redirects to the created last_login" do
        LastLogin.stub(:new) { mock_last_login(:save => true) }
        post :create, :last_login => {}
        response.should redirect_to(last_login_url(mock_last_login))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved last_login as @last_login" do
        LastLogin.stub(:new).with({'these' => 'params'}) { mock_last_login(:save => false) }
        post :create, :last_login => {'these' => 'params'}
        assigns(:last_login).should be(mock_last_login)
      end

      it "re-renders the 'new' template" do
        LastLogin.stub(:new) { mock_last_login(:save => false) }
        post :create, :last_login => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested last_login" do
        LastLogin.should_receive(:find).with("37") { mock_last_login }
        mock_last_login.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :last_login => {'these' => 'params'}
      end

      it "assigns the requested last_login as @last_login" do
        LastLogin.stub(:find) { mock_last_login(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:last_login).should be(mock_last_login)
      end

      it "redirects to the last_login" do
        LastLogin.stub(:find) { mock_last_login(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(last_login_url(mock_last_login))
      end
    end

    describe "with invalid params" do
      it "assigns the last_login as @last_login" do
        LastLogin.stub(:find) { mock_last_login(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:last_login).should be(mock_last_login)
      end

      it "re-renders the 'edit' template" do
        LastLogin.stub(:find) { mock_last_login(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested last_login" do
      LastLogin.should_receive(:find).with("37") { mock_last_login }
      mock_last_login.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the last_logins list" do
      LastLogin.stub(:find) { mock_last_login }
      delete :destroy, :id => "1"
      response.should redirect_to(last_logins_url)
    end
  end

end
