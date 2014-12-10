Given(/^the user is not logged in$/) do
  expect(@current_user).to be_nil
end

When(/^he visits the create employer page$/) do
  visit('users/new')
end

When(/^he submits the create employer form$/) do
  visit('/users/new')
  fill_in('user_email', :with => 'ceo@boeing.com')
  fill_in('user_password', :with => 'password')
  fill_in('user_password_confirmation', :with => 'password')
  fill_in('user_name', :with => 'Boeing')
  fill_in('user_website', :with => 'http://www.boeing.com')
  click_button('Create account')
end

When(/^he submits the create employer form without valid password confirmation$/) do
  visit('/users/new')
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

Then(/^he should not see "(.*?)"$/) do |text|
  page.should_not have_content(text)
end

