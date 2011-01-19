require "spec_helper"

describe LastLoginsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/last_logins" }.should route_to(:controller => "last_logins", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/last_logins/new" }.should route_to(:controller => "last_logins", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/last_logins/1" }.should route_to(:controller => "last_logins", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/last_logins/1/edit" }.should route_to(:controller => "last_logins", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/last_logins" }.should route_to(:controller => "last_logins", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/last_logins/1" }.should route_to(:controller => "last_logins", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/last_logins/1" }.should route_to(:controller => "last_logins", :action => "destroy", :id => "1")
    end

  end
end
