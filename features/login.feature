Feature: Log in
  User can login with valid username and password.

  Scenario: User can log in from login link and redirect to courses page
    Given I am on homepage
    And I am not logged in
    When I click "Login"
    Then I should see text "Log In to takehome"
    When I login with valid info
    Then I should see course "take home test" with author "artash"






