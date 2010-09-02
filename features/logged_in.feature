Feature: 
  In order for me to potentially overthrow the government
  I would like to login to shwagr, and submit a link

  Background: Valid and authenticated user has been to the site before
    Given I am an authenticated user
    
  Scenario: Submitting a Link
    Given I am logged in as the following user:
      | name      |  Alfred Hitchcock |
      | email     | alfie@example.com |
      | password  | secret            |
    When I go to the posts page
    And I follow "New post"
    And I fill in the following:
      | title     | my revolutionary post     |
      | url       | http://www.hqchannel.com/ |
      | category  | Activism                  |
    And I follow "Save"
    Then I should see the homepage
      