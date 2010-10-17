Given /^that there is a post$/ do
  @post = Post.new
end

Then /^I should be able to comment on that post$/ do
  Given %{I go to the posts page}
  And %{I press "comment"}
  
end

Given /^I fill out the form appropriately$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the homepage$/ do
  pending # express the regexp above with the code you wish you had
end
