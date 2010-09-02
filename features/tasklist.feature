Feature: 
  In order for me to potentially overthrow the government
  I would like to login to shwagr, and submit a link

  Background: Valid and authenticated user has been to the site before
    Given I am an authenticated user

  @ok
  Scenario: Submitting a Link
    Given that I want to post a link
    And I fill out the form appropriately
    Then I should be redirected to the homepage