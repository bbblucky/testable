Given /^I am a user enrolled take home test$/ do
  step 'I am on homepage'
  step 'I am not logged in'
  step 'I click "Login"'
  step 'login with username "yi@example.com" and password "Test1234"'
end

Then /^the course progress should be (\d+%)$/ do |percentage|
  expect(page).to have_xpath("//div[@class='course-progress']//span[@class='percentage' and contains(text(),'#{percentage}')]")
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
