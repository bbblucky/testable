Feature: Complete course

  Scenario: Complete all the lecture to complete the course
    Given I am a new user
    And I have enrolled course "take home test"
    When I go to enrolled course "take home test" page
    Then the course progress should be 0%
    # Complete Lecture with text
    When I click "Lecture with text" within "Section 1" section
    And I click "Complete and continue"
    Then I should see text "Lecture with video"
    And the course progress should be 25%
    And the "Lecture with text" on sidebar should mark complete
    # Complete Lecture with video
    When I click "Complete and continue"
    Then I should see text "Lecture with pdf"
    And the course progress should be 50%
    And the "Lecture with video" on sidebar should mark complete
     # verify Previous Lecture button functional
    When I click "Previous Lecture"
    Then I should see text "Lecture with video"
    And I should see a "video" in lecture
    # verify back button and course page show up correctly
    When I click back button
    Then I should see "Lecture with text" complete
    And I should see "Lecture with video" complete
    # verify start next lecture button
    When I click "Start next lecture"
    Then I should see text "Lecture with pdf"
    And I should see a "pdf" in lecture
    # Complete Lecture with pdf
    When I click "Complete and continue"
    Then I should see text "Lecture with text"
    And the course progress should be 75%
    And the "Lecture with pdf" on sidebar should mark complete
    # Complete Lecture with text
    When I click "Complete and continue"
    Then I should see complete course "take home test" page
    And the course progress should be 100%

