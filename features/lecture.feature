Feature: Lecture detail
  user can go to enrolled course from my courses page,
  and user can view each lecture within the enrolled course.

  Scenario: Verify use can go to enrolled course from my course page
    Given I am a user enrolled take home test
    When I am on "My Courses" page
    Then I should see course "take home test" with author "artash"
    When I click "take home test"
    Then I should see enrolled course "take home test" page

  Scenario: Verify Lecture with text should up correctly
    Given I am a user enrolled take home test
    When I go to enrolled course "take home test" page
    When I click "Lecture with text" within "Section 1" section
    Then I should see text "Lecture with text"
    And I should see a "paragraph" in lecture
    And I should see a download link for "test_image.png"
    And I should see highlight "Lecture with text" in sidebar
    And I should see text "Complete and continue"
    And I should not see text "Previous Lecture"

  Scenario: Verify Lecture with video should up correctly
    Given I am a user enrolled take home test
    When I go to enrolled course "take home test" page
    When I click "Lecture with video" within "Section 1" section
    Then I should see text "Lecture with video"
    And I should see a "video" in lecture
    And I should see highlight "Lecture with video" in sidebar
    And I should see text "Complete and continue"
    And I should see text "Previous Lecture"

  Scenario: Verify Lecture with pdf should up correctly
    Given I am a user enrolled take home test
    When I go to enrolled course "take home test" page
    When I click "Lecture with pdf" within "Section 2" section
    Then I should see text "Lecture with pdf"
    And I should see a "pdf" in lecture
    And I should see highlight "Lecture with pdf" in sidebar
    And I should see text "Complete and continue"
    And I should see text "Previous Lecture"

  Scenario: Verify Lecture with text in section 2 should up correctly
    Given I am a user enrolled take home test
    When I go to enrolled course "take home test" page
    When I click "Lecture with text" within "Section 2" section
    Then I should see text "Lecture with text"
    And I should see a "paragraph" in lecture
    And I should not see a download link for "test_image.png"
    And I should see highlight "Lecture with text" in sidebar
    And I should see text "Complete and continue"
    And I should see text "Previous Lecture"



