Feature: Enroll a class

  Scenario: User can enroll a course from course page, after enrollment user can view enrolled course page
    Given I am a new user
    And I am on "All Courses" page
    When I click "take home test"
    Then I should see "take home test" course page
    When I try to enroll the course
    Then I should see enrollment successful
    When I click "Continue to Course"
    Then I should see enrolled course "take home test" page






