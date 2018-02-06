Given /^I am on homepage$/ do
  visit Capybara.app_host
end

Given /^I am on "([^"]*)" page/ do |page|
  case page
    when 'My Courses'
      visit('/courses/enrolled')
    when 'All Courses'
      visit('/courses')
    else
      visit("/#{page}")
  end
end

Given /^I am not logged in/ do
  step 'I click "Login"'
  if page.has_css?('div.welcome-back-sso')
    click_link "No Thanks, I'd Like to Log Out"
  end
  step 'I am on homepage'
end

Given /^I am a new user$/ do
  step 'I am on homepage'
  step 'I click "Sign Up"'
  step 'I sign up with valid info'
end

When /^I am on enrolled course "([^"]*)" page$/ do |course|
  step 'I click "' + course + '"'
  step 'I try to enroll the course'
  step 'I click "Continue to Course"'
end

When /^I click "([^"]*)"$/ do |key|
  click_link key
end

When /^I click "([^"]*)" within "([^"]*)" section$/ do |key, section|
  within(:xpath, "//div[contains(@class,'course-section') and div[contains(.,'#{section}')]]") do
    click_link key
  end
end

Then /^I (should|should not) see text "([^"]*)"$/ do |expectation, text_content|
  xpath = "//*[contains(text(),'#{text_content}')]"
  if expectation == 'should'
    expect(page).to have_xpath(xpath)
  else
    expect(page).not_to have_xpath(xpath)
  end
end

When /^I sign up with valid info$/ do
  if page.has_css?('div.welcome-back-sso')
    click_link "No Thanks, I'd Like to Log Out"
  end
  @email = Faker::Internet.safe_email
  @name = Faker::Name.name
  fill_in('Full Name', with: @name)
  fill_in('Email Address', with: @email)
  fill_in('Password', with: 'Test1234')
  fill_in('Confirm Password', with: 'Test1234')
  check('user_agreed_to_terms')
  page.find(:xpath, "//input[@value='Sign Up']").click
end

When /^I login with valid info$/ do
  step 'login with username "yi@example.com" and password "Test1234"'
end

When /^login with username "([^"]*)" and password "([^"]*)"$/ do |usr, pwd|
  if page.has_xpath?("//p[text()='#{usr}']")
    click_link 'Continue as'
  else
    if page.has_css?('div.welcome-back-sso') && !page.has_xpath?("//p[text()='#{usr}']")
      click_link 'Log In with a School Account'
    end
    fill_in('Email Address', with: usr)
    fill_in('Password', with: pwd)
    page.find(:xpath, "//input[@value='Log In']").click
  end
end

Then /^I should see course "([^"]*)" with author "([^"]*)"$/ do |course, author|
  xpath = "//div[@class='course-listing' and //div[contains(text(),'#{course}')] and //div[contains(text(),'#{author}')]]"
  expect(page).to have_xpath(xpath)
end

Then /^I should see "([^"]*)" course page$/ do |course_name|
  expect(page).to have_xpath("//h1[@class='course-title' and contains(text(),'#{course_name}')]")
  expect(page).to have_xpath("//h2[contains(text(),'Your Instructor')]")
  expect(page).to have_xpath("//h2[contains(text(),'Class Curriculum')]")
  expect(page).to have_css('div.course-section')
  expect(page).to have_css('div.faq-question')
  expect(page).to have_css('div.faq-answer')
end

Then /^I should be redirect to "([^"]*)" page$/ do |page|
  current_path.should == "/#{page}"
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |value, keys|
  fill_in(value, with: keys)
end

When /^I check "([^"]*)"$/ do |checkbox|
  check(checkbox)
end

When /^I try to enroll the course$/ do
  page.find(:xpath, "//button[@id='enroll-button-top']").click
end

Then /^I should see enrollment successful$/ do
  expect(page).to have_xpath("//h1[contains(text(),'Thanks for enrolling in this course!')]")
  expect(page).to have_xpath("//p[contains(text(),'Your order ID:')]")
  expect(page).to have_xpath("//p[contains(text(),'You will shortly receive an email confirmation at')]")
  expect(page).to have_xpath("//strong[contains(text(),'#{@email}')]")
  expect(page).to have_xpath("//a[contains(text(),'Continue to Course')]")
end

Then /^I should see enrolled course "([^"]*)" page$/ do |course_name|
  # verify left side bar
  expect(page).to have_xpath("//div[@class='course-sidebar']//h2[text()='#{course_name}']")
  expect(page).to have_xpath("//div[@class='course-sidebar']//div[@class='course-progress']")
  expect(page).to have_link('Class Curriculum')
  expect(page).to have_link('Your Instructor')

  #verify course main section
  expect(page).to have_content('Class Curriculum')
  expect(page).to have_link('Start next lecture')
  expect(page).to have_css('div.row div.course-section')
end

Then /^Stop/ do
  sleep 1000
end

Then /^Sleep/ do
  sleep 1
end