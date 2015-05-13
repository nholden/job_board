Given(/^the user is not logged in$/) do
  expect(@current_user).to be_nil
end

Given(/^an administrator exists$/) do
  FactoryGirl.build(:admin).save
end

Given(/^an employer exists$/) do
  FactoryGirl.build(:user).save
end

Given(/^an employer is logged in$/) do
  @employer = User.new(:email    => "employee@employer.com",
                       :password => "employer",
                       :name     => "Employer",
                       :website  => "www.employer.com",
                       :role_id  => Role.find_or_create_by(label: 'employer').id)
  @employer.save
  visit('login')
  fill_in('session_email', :with => 'employee@employer.com')
  fill_in('session_password', :with => 'employer')
  click_button('Login')
end

When(/^he visits the create employer page$/) do
  visit('/signup/employer')
end

When(/^he submits the create employer form$/) do
  visit('/signup/employer')
  fill_in('user_email', :with => 'ceo@boeing.com')
  fill_in('user_password', :with => 'password')
  fill_in('user_password_confirmation', :with => 'password')
  fill_in('user_name', :with => 'Boeing')
  fill_in('user_website', :with => 'http://www.boeing.com')
  click_button('Create account')
end

When(/^he submits the create admin form$/) do
  visit('/signup/admin')
  fill_in('user_name', :with => 'Admin')
  fill_in('user_email', :with => 'admin@admin.org')
  fill_in('user_password', :with => 'password1')
  fill_in('user_password_confirmation', :with => 'password1')
  click_button('Create account')
end

When(/^he submits the create employer form without valid password confirmation$/) do
  visit('/signup/employer')
  fill_in('user_email', :with => 'ceo@boeing.com')
  fill_in('user_password', :with => 'password')
  fill_in('user_password_confirmation', :with => 'different_password')
  fill_in('user_name', :with => 'Boeing')
  fill_in('user_website', :with => 'http://www.boeing.com')
  click_button('Create account')
end

Then(/^he should see "(.*?)"$/) do |text|
  page.should have_content(text)
end

Then(/^he should see a textbox filled in with "(.*?)"$/) do |text|
  page.should have_selector("input[value='#{text}']")
end

Then(/^he should not see "(.*?)"$/) do |text|
  page.should_not have_content(text)
end

Then(/^he should not see a textbox filled in with "(.*?)"$/) do |text|
  page.should_not have_selector("input[value='#{text}']")
end

When(/^he logs out$/) do
  click_link("Log out")
end

