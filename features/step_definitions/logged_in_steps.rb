Given /^I am an authenticated user$/ do
  name = 'example'
  email = 'example@example.com'
  password = 'secret'

  Given %{I have one user "#{name}" with email "#{email}" and password "#{password}"}
  And %{I go to the user login page}
  And %{I fill in "username" with "#{name}"}
  And %{I fill in "password" with "#{password}"}
  And %{I press "Login"}
end

Given /^that I want to post a link$/ do
  #title = 'My revolutionary post'
  #website_link = "http://www.google.com"
  #category = 'activism'
  #And %{I go to the new post page(#{user})}
  #And %{I fill in "title" with "#{title}"}
  #And %{I fill in "website link" with "#{website_link}"}
  #And %{I fill in "category" with "#{category}"}
  #And %{I press "save"}
end

Then /^I should be redirected to the homepage$/ do
  view page_to(homepage)
end
