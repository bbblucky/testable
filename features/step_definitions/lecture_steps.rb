Given /^I am a user enrolled take home test$/ do
  step 'I am on homepage'
  step 'I click "Login"'
  if page.has_css?('div.welcome-back-sso') && !page.has_xpath?("//p[text()='yi@example.com']")
    click_link "No Thanks, I'd Like to Log Out"
    visit('/sign_in')
  end
  step 'login with username "yi@example.com" and password "Test1234"'
end

Given /^I have enrolled course "([^"]*)"$/ do |course|
  step 'I am on "All Courses" page'
  step 'I click "' + course + '"'
  step 'I try to enroll the course' if page.has_xpath?("//button[@id='enroll-button-top']")
end


Then /^the course progress should be (\d+%)$/ do |percentage|
  expect(page).to have_xpath("//div[contains(@class,'course-progress')]//span[@class='percentage' and contains(text(),'#{percentage}')]")
end

When /^I go to enrolled course "([^"]*)" page$/ do |course_name|
  step 'I am on "My Courses" page'
  step 'I click "' + course_name + '"'
end

Then /^I should see "([^"]*)" lecture page$/ do |lecture_name|
  expect(page).to have_xpath("//div[@class='course-mainbar lecture-content']//h2[contains(.,'#{lecture_name}')]")
end

Then /^I should see a "([^"]*)" in lecture$/ do |content_type|
  case content_type
    when 'paragraph'
      expect(page).to have_css('div.lecture-text-container')
    when 'video'
      expect(page).to have_css('video')
    when 'pdf'
      expect(page).to have_css('iframe.pdf-viewer')
    else
      #nothing
  end
end

Then /^I (should|should not) see a download link for "([^"]*)"$/ do |expectation, file_name|
  xpath = "//a[@class='download' and contains(.,'#{file_name}')]"
  if expectation == 'should'
    expect(page).to have_xpath(xpath)
  else
    expect(page).not_to have_xpath(xpath)
  end
end

Then /^I should see highlight "([^"]*)" in sidebar$/ do |lecture_name|
  xpath = "//div[@class='row lecture-sidebar']//li[contains(@class,'next-lecture')]//span[contains(text(),'#{lecture_name}')]"
  expect(page).to have_xpath(xpath)
end

Then /^the "([^"]*)" on sidebar should mark complete$/ do |lecture_name|
  xpath = "//div[@class='row lecture-sidebar']//li[contains(@class,'section-item completed')]//span[contains(text(),'#{lecture_name}')]"
  expect(page).to have_xpath(xpath)
end

Then /^I should see complete course "([^"]*)" page$/ do |course_name|
  expect(page).to have_xpath("//div[@class='course-sidebar']//h2[text()='#{course_name}']")

  #verify start next lecture button disabled
  expect(page).to have_xpath("//a[contains(@class,'start-next-lecture disabled')]")

  #verfiy all lecture has complete
  expect(page).to have_xpath("//li[@class='section-item completed']", count: 4)

  #verify course complete
  expect(page).to have_xpath("//div[@class='course-progress']//span[@class='percentage' and contains(text(),'100%')]")
end

Then /^I should see "([^"]*)" complete$/ do |lecture_name|
  xpath =  "//li[@class='section-item completed']//span[contains(text(),'#{lecture_name}')]"
  expect(page).to have_xpath(xpath)
end

When /^I click back button$/ do
  page.find(:xpath, "//a[@class='nav-icon-back']").click
end


