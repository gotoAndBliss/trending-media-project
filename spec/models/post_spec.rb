require 'spec_helper'

module PostSpecHelper
  
  def valid_post_attributes
      {
      :name => "My sweet post",
      :category => "spirituality",
      :url => "google.com"
      }
  end
end

describe Post do
  
  include PostSpecHelper
  
  before do
    #@post = Post.new
    @mock_cat = Factory.create(:category)
    Category.stub(:mock_cat)
    @post = Factory(:post)
  end
  
  describe "a post is created" do
    it "should be a valid post" do
      @post.should be_valid
    end
    it "should have an error on category" do
      @post = Factory.build(:post, { :category => nil } )
      @post.save.should be_false
      @post.should have(1).error_on(:category)
    end
    it "should prepare posts" do
      @post = Factory.build(:post, 
        {:category => "SPIRITUALITY"})
      @post.save
      @post.category.should == "spirituality"
      @post.url.should == "http://www.shwagr.com"
    end
    it "should not pass if it does not have text or a url" do
      @post = Factory.build(:post, 
          {:text => nil, :url => nil})
      @post.save.should be_false
      @post.should have(1).error_on(:url)
    end
    it "should pass if it has text and no url" do
      @post = Factory.build(:post, 
          {:text => "The Lazy Brown Fox..", :url => nil})
      @post.save
      @post.should be_valid
    end
  end
  
  describe "time from now" do
    it "should be a few days ago" do
      @time_now = Time.parse("Sept 20 2010 14:20")
      Time.stub!(:now).and_return(@time_now)
      @post = Factory(:post, 
        :created_at => Time.parse("Sept 02 2010 14:20"))
      @post.time_from_now.should == "18 days"
    end
    it "should be a few hours ago" do
      @time_now = Time.parse("Sept 20 2010 14:20")
      Time.stub!(:now).and_return(@time_now)
      @post = Factory(:post,
        :created_at => Time.parse("Sept 20 2010 12:20"))
      @post.time_from_now.should == "2 hours"
    end
  end
  
  describe "what exactly is a sexy link" do
    it "should make me horny" do
      @post = Factory(:post, :url => "http://www.92y.org/calendar/calendar.asp?subject=View+All+Subjects&92Y_drop=bycalendar_tab")
      @post.is_a_sexy_link.should == "www.92y.org"
    end
  end
  
  describe "vote scores" do
    it "should show me the total vote score" do
      @post.votes = [Factory(:vote, :value => "1"), 
                     Factory(:vote, :value => "1")]
      @post.vote_score.should == 2
    end
  end
  
  
  
end
