Given /^I am on homepage$/ do
  visit Capybara.app_host
end

Given /^I am on "([^"]*)" page/ do |page|
  visit("/#{page}")
end

Given /^I am not logged in/ do
  visit('/sign_out')
end

Given /^I am a new user$/ do
  step "I am on homepage"
  step 'I click "Sign Up"'
  step "I sign up with valid info"
end

When /^I click "([^"]*)"$/ do |key|
  click_link key
end

Then /^I should see text "([^"]*)"$/ do |text_content|
  expect(page).to have_xpath("//*[contains(text(),'#{text_content}')]")
end

When /^I sign up with valid info$/ do
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
  fill_in('Email Address', with: 'yi@example.com')
  fill_in('Password', with: 'Test1234')
  page.find(:xpath, "//input[@value='Log In']").click
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

Then /^Sleep$/ do
  sleep 100
end
