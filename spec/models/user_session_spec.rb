require 'spec_helper'

module UserSpecHelper
  
  def valid_spec_attributes
    {
      :login => "daniel.levine4@gmail.com",
      :password => "orange44",
    }
  end
  
end

describe UserSession do
  
  include UserSpecHelper
  
  before do
    @login.attributes = valid_spec_attributes
    @login = UserSession.new
  end
  
end
