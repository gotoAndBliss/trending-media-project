Given /^I have one\s+user "([^\"]*)" with email "([^\"]*)" and password "([^\"]*)"$/ do |username,email, password|
  @user = User.new(:email => email,
                   :username=>username,
                   :password => password,
                   :password_confirmation => password)
   @user.save!
end