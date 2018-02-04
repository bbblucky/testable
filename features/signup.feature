Feature: Sign up

  Scenario: User will redirect to sign up page if he doesn't login
    Given I am on homepage
    When I click "Enroll Now"
    Then I should see text "Sign Up to takehome"

  Scenario: User can sign up from sign up link and redirect to courses page
    Given I am on homepage
    When I click "Sign Up"
    Then I should see text "Sign Up to takehome"
    When I sign up with valid info
    Then I should see course "take home test" with author "artash"







