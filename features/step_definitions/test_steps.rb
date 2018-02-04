Given /^I am on homepage$/ do
  visit Capybara.app_host
end

Given /^I am on "([^"]*)" page/ do |page|
  visit("/#{page}")
end

Given /^I am not logged in/ do
  visit('/sign_out')
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


Then /^I should be redirect to "([^"]*)" page$/ do |page|
  current_path.should == "/#{page}"
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |value, keys|
  fill_in(value, with: keys)
end

When /^I check "([^"]*)"$/ do |checkbox|
  check(checkbox)
end

Then /^Sleep$/ do
  sleep 100
end
